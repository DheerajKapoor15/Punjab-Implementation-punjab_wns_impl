--migrateCityConnections
drop function pbsc_migrateCityConnections();
CREATE OR REPLACE FUNCTION pbsc_migrateCityConnections(in_billingCycle IN varchar(16))
RETURNS bigint AS
$BODY$
DECLARE
connections egswtax_stg_connection%ROWTYPE;

v_billingcycleid 		bigint;
v_moduleid 				bigint;
v_temp 					integer;
v_isdatavalid 			boolean default false;
v_return				bigint default 0;
BEGIN
	v_isdatavalid := pbwc_validateData();
	if (v_isdatavalid) then
		select id into v_moduleid from eg_module where name='Sewerage Tax Management';
		select id into v_billingcycleid from eg_installment_master where id_module=v_moduleid and description=in_billingCycle;
	
		if(v_billingcycleid is null)then
			raise notice 'migrateCityConnections : Invalid billing cycle (%)', in_billingCycle;
			return 0;
		end if;
			
		for connections in (select * from egswtax_stg_connection where (ismigrated=false or ismigrated is null))
		loop 
			begin
				--raise notice 'migrateCityConnections : Started for assessment no (%)', v_connectionno;
				v_temp  := pbsc_migrateConnection(connections.oldconsumernumber, connections.connectiondate::date, v_billingcycleid, in_billingCycle, v_moduleid, connections.corraddress);
				if(v_temp=0)then
					v_return:=0;
				end if;
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'migrateCityConnections : % %', SQLERRM, SQLSTATE;
			END;
		END LOOP;
	end if;
	return v_return;
END;
$BODY$ LANGUAGE plpgsql;

--migrateLocalityConnections
drop function pbsc_migrateLocalityConnections(varchar);
CREATE OR REPLACE FUNCTION pbsc_migrateLocalityConnections(localityCode IN varchar(16), in_billingCycle IN varchar(16))
RETURNS bigint AS
$BODY$
DECLARE
connections egswtax_stg_connection%ROWTYPE;

v_moduleid 			bigint;
v_billingcycleid 	bigint;
v_temp 				integer;
v_isdatavalid 		boolean default false;
v_return			bigint default 0;
BEGIN
	v_isdatavalid := pbwc_validateData();
	if (v_isdatavalid) then
		select id into v_moduleid from eg_module where name='Sewerage Tax Management';
		select id into v_billingcycleid from eg_installment_master where id_module=v_moduleid and description=in_billingCycle;

		if(v_billingcycleid is null)then
			raise notice 'migrateLocalityConnections : Invalid billing cycle (%)', in_billingCycle;
			return 0;
		end if;

		for connections in (select * from egswtax_stg_connection where (ismigrated=false or ismigrated is null) and locality=localityCode)
		loop 
			begin
				--raise notice 'migrateLocalityConnections : Started for Old connectionno (%)', connections.oldconsumernumber;
				v_temp  := pbsc_migrateConnection(connections.oldconsumernumber, connections.connectiondate::date, v_billingcycleid, in_billingCycle, v_moduleid, connections.corraddress);
				if(v_temp=0)then
					v_return:=0;
				end if;
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'migrateLocalityConnections : % %', SQLERRM, SQLSTATE;
			END;
		END LOOP;
	end if;
	return v_return;
END;
$BODY$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION pbsc_migrateConnection(oldConnectionNo IN varchar(60), connectionDate IN date, currinst IN bigint, currinstdesc IN varchar(16), idModule IN bigint, corrAddress IN varchar(256))
RETURNS bigint AS
$BODY$
DECLARE

v_idconnection 				bigint;
v_idconnectiondet 			bigint;
v_addressid					bigint;
v_idowner 					bigint;
v_idownerlk					bigint;
v_iddmd						bigint;
v_totaltax					double precision;
v_consumercount				bigint;
v_dcbcount					bigint;
v_billingmatchingcount		bigint;
v_futurebillingcount		bigint;
v_inbillingstartdate		date;
v_newconsumercode			varchar(16);

BEGIN
	begin
		--raise notice 'migrateConnection : Started for Old connectionno (% % % %)', oldConnectionNo, currinst, currinstdesc, idModule;
		select start_date into v_inbillingstartdate from eg_installment_master where id=currinst;
		select count(*) into v_consumercount from egswtax_connection where oldconsumernumber=oldConnectionNo;
		if(v_consumercount>0)then
			raise notice 'migrateConnection : There is already a connection with given old consumer number (%)', oldConnectionNo;
			update egswtax_stg_connection set error=coalesce(error, '') || ' There is already a connection with given old consumer number' where oldconsumernumber=oldConnectionNo;
			return 0;
		end if;

		select count(*), sum(coalesce(chargeamount, 0) + coalesce(penaltyamount, 0) + coalesce(interestamount, 0)) into v_dcbcount, v_totaltax from egswtax_stg_connection_dcb where oldconsumernumber=oldConnectionNo;
		select count(*) into v_billingmatchingcount from egswtax_stg_connection_dcb where billingcycle=currinstdesc and oldconsumernumber=oldConnectionNo;
		select count(distinct oldconsumernumber) into v_futurebillingcount from egswtax_stg_connection_dcb dcb, eg_installment_master inst where dcb.oldconsumernumber=oldConnectionNo and inst.id_module=idModule and dcb.billingcycle=inst.description and inst.start_date>v_inbillingstartdate;
		raise notice 'migrateConnection : v_dcbcount, v_billingmatchingcount, v_futurebillingcount (% % %)', v_dcbcount, v_billingmatchingcount, v_futurebillingcount;
		if(v_dcbcount>0)then
			if (v_billingmatchingcount=0 or v_futurebillingcount>0) then
				update egswtax_stg_connection set error=coalesce(error, '') || ' There is no DCB with migration billing cycle or there is DCB future billing cycles' where oldconsumernumber=oldConnectionNo;
				return 0;
			end if;
		end if;
		v_idowner := pbsc_createOwner(oldConnectionNo, corrAddress, v_addressid);
		--raise notice 'migrateConnection : owner created (%)', v_idowner;
		v_addressid := pbsc_createAddress(oldConnectionNo, v_idowner);
		--raise notice 'migrateConnection : address created (%)', v_addressid;
		v_idconnectiondet := pbsc_createConnection(oldConnectionNo, v_addressid);
		--raise notice 'migrateConnection : Connection created (%)', v_idconnection;
		select conn.shsc_number, app.connection into v_newconsumercode, v_idconnection from egswtax_connection conn, egswtax_applicationdetails app where app.id=v_idconnectiondet and conn.id=app.connection;
		v_idownerlk := pbsc_linkOwner(v_idconnection, connectionDate, v_idowner);
		--raise notice 'migrateConnection : Owner linked (%)', v_idownerlk;
		if (v_totaltax>0) then
			v_iddmd := pbsc_createDemand(oldConnectionNo, v_idconnectiondet, currinst, connectionDate, idModule, currinstdesc);
			raise notice 'migrateConnection : Demand created';
		end if;
		update egswtax_stg_connection set ismigrated=true where oldconsumernumber=oldConnectionNo;
		raise notice 'migrateConnection : Connection with Old Consumer Nuber: % is successfully migrated and the new consumercode is: %', oldConnectionNo, v_newconsumercode;
		return v_idconnectiondet;
	EXCEPTION
	WHEN OTHERS THEN
	raise notice 'migrateConnection : % %', SQLERRM, SQLSTATE;
	update egswtax_stg_connection set error = SQLSTATE || '-' || SQLERRM where oldconsumernumber=oldConnectionNo;
	END;
END;
$BODY$ LANGUAGE plpgsql;


--generateUsername
create or replace FUNCTION pbsc_generateUsername(name IN varchar(100))
RETURNS VARCHAR as $$
declare
	v_username 	varchar(16); 
	v_random 	varchar(18);
	v_randomno 	varchar(10);
BEGIN 
	--raise notice 'generateUsername name (%)',name;
	v_username := lpad(upper(substr(replace(replace(replace(name,'.',''),' ',''),',',''),1,6)), 6, '0');
	v_random := random()*100000000000;
	v_randomno := substring(v_random from 1 for 10);
	v_username := v_username || v_randomno;
	--raise notice 'generateUsername, username generated (%)', v_username;
return v_username;
EXCEPTION
WHEN OTHERS THEN
raise notice 'generateUsername : % %', SQLERRM, SQLSTATE;
END;  
$$ LANGUAGE plpgsql;

--createAddress
create or replace FUNCTION pbsc_createAddress(oldConnectionNo IN varchar(50), userid IN bigint)  
RETURNS numeric as $$
declare
	v_addresspk 	bigint;  
BEGIN 
	--raise notice 'createAddress oldConnectionNo (%)', oldConnectionNo;
	select nextval('seq_eg_address') into v_addresspk;
	INSERT INTO eg_address(housenobldgapt, type, landmark, streetroadline, arealocalitysector, pincode, id, userid, buildingname)
	select houseno, 'STMSCONNECTION_ADDRESS', landmark, street, (select name from eg_boundary where code=locality), pincode, v_addresspk, userid, buildingname from egswtax_stg_connection where oldconsumernumber = oldConnectionNo;
	insert into egswtax_address (id) values (v_addresspk);
	--raise notice 'createAddress Address created';
return v_addresspk;
EXCEPTION
WHEN OTHERS THEN
raise notice 'createAddress : % %', SQLERRM, SQLSTATE;
END; 
$$ LANGUAGE plpgsql;

--createOwner
create or replace FUNCTION pbsc_createOwner(oldConnectionNo IN varchar(50), corraddress IN varchar(256), addressid IN bigint)  
RETURNS numeric as $$
declare
	v_userpk 	bigint;  
	v_addresspk	bigint;
BEGIN 
	--raise notice 'createOwner oldConnectionNo, corraddr1, corraddr2, addressid (% % % % %)', oldConnectionNo, corraddr1, corraddr2, addressid;
	select nextval('seq_eg_address') into v_addresspk;
	select nextval('seq_eg_user') into v_userpk;
	INSERT INTO eg_user(id, locale, username, password, mobilenumber, emailid, createddate, lastmodifieddate, createdby, lastmodifiedby, active, name, gender, type, aadhaarnumber, guardian, guardianrelation, dob)
    select v_userpk, 'en_IN', pbsc_generateUsername(ownername), 'NOT SET', mobileno, emailid, connectiondate, connectiondate, 1, 1, TRUE, ownername, (CASE WHEN gender = 'Female' THEN 0 ELSE 1 END), 'CITIZEN', aadharno, guardian, guardianrelation, dob from egswtax_stg_connection where oldconsumernumber = oldConnectionNo;

	--raise notice 'createOwner Owner created';
IF (corraddress IS NOT NULL AND length(corraddress)>0) then
	--raise notice 'createOwner Corr Address available';
    INSERT INTO eg_address(arealocalitysector, id, userid)
    values (corraddress, v_addresspk, v_userpk);
	insert into eg_correspondence_address (id) values (v_addresspk);
	--raise notice 'createOwner Owner address created with available corr address';
else
	--raise notice 'createOwner Corr Address NOT available';
	INSERT INTO eg_address(housenobldgapt, type, streetroadline, arealocalitysector, pincode, id, userid, buildingname)
	select housenobldgapt, 'CORRESPONDENCE', streetroadline, arealocalitysector, pincode, v_addresspk, v_userpk, buildingname from eg_address where id=addressid;
	insert into eg_correspondence_address (id) values (v_addresspk);
	--raise notice 'createOwner Owner address created with property address';
END IF;
return v_userpk;
EXCEPTION
WHEN OTHERS THEN
raise notice 'createOwner : % %', SQLERRM, SQLSTATE;
END;  
$$ LANGUAGE plpgsql;

--createConnection
create or replace FUNCTION pbsc_createConnection(oldConnectionNo IN varchar(50), addressid bigint)  
RETURNS numeric as $$
declare
	v_connectionpk 		bigint;
	v_connectiondetpk 	bigint;
	v_applicationdetpk 	bigint;
	v_connectionno 		varchar(10);
BEGIN
	select nextval('seq_egswtax_shsc_number') into v_connectionno;
	select code||lpad(v_connectionno,6,'0') into v_connectionno from eg_city;
	select nextval('seq_egswtax_connection') into v_connectionpk;
	select nextval('seq_egswtax_connectiondetail') into v_connectiondetpk;
	select nextval('seq_egswtax_applicationdetails') into v_applicationdetpk;

	--raise notice 'createConnection oldConnectionNo, addressid (% %)',oldConnectionNo, addressid;
	INSERT INTO egswtax_connection(id, shsc_number, status, executiondate, legacy, createdby, createddate, lastmodifieddate, lastmodifiedby, version, oldconsumernumber, zone, ward, block, locality, address)
	select v_connectionpk, v_connectionno, upper(coalesce(status,'ACTIVE')), connectiondate, true, 1, connectiondate, connectiondate, 1, 0, oldconsumernumber, (select parent from eg_boundary where id= (select parent from eg_boundary where code=locality)), null, (select parent from eg_boundary where code=locality), (select id from eg_boundary where code=locality), addressid from egswtax_stg_connection where oldconsumernumber = oldConnectionNo;

	INSERT INTO egswtax_connectiondetail(id, propertyidentifier, propertytype, noofclosets_residential, noofclosets_nonresidential, version, donationcharges, wateridentifier, usagetype, billingtype, billamount, plotsize, isplotsizeactual, ledgernumber, billgroupnumber, currentbillingcycle, lastbilldate, currentoccupier) select v_connectiondetpk, propertyidentifier, null, resdseats, nonresdseats, 0, coalesce(securitydeposit,0), waterconnectionnumber, (select id from egswtax_usage_type where name=usagetype), upper(billingtype), custombillamount, plotsize, (CASE WHEN isplotsizeactual = 'Yes' THEN TRUE ELSE FALSE END), ledgerid, billgroupid, currentbillingcycle, lastbilldate, currentoccupier from egswtax_stg_connection where oldconsumernumber = oldConnectionNo;

	INSERT INTO egswtax_applicationdetails(id, applicationtype, connection, applicationnumber, applicationdate, disposaldate, state_id, status, estimationnumber, estimationdate, workordernumber, workorderdate, filestoreid, createdby, createddate, lastmodifieddate, lastmodifiedby, version, isactive, connectiondetail, parent, closeconnectionreason, closurenoticenumber, closurenoticedate, source, rejectionnumber, rejectiondate)
	select v_applicationdetpk, (select id from egswtax_application_type where code='NEWSEWERAGECONNECTION'), v_connectionpk, null, connectiondate, null, null, (select id from egw_status where moduletype='SEWERAGETAXAPPLICATION' and code='SANCTIONED'), null, null, null, null, null, 1, connectiondate, connectiondate, 1, 0, true, v_connectiondetpk, null, null, null, null, 'SYSTEM', null, null from egswtax_stg_connection where oldconsumernumber = oldConnectionNo;
	--raise notice 'createConnection connection details created';
return v_applicationdetpk;
EXCEPTION
WHEN OTHERS THEN
raise notice 'createConnection : % %', SQLERRM, SQLSTATE;
END; 
$$ LANGUAGE plpgsql;

--Link Owner to Property
create or replace FUNCTION pbsc_linkOwner(connection IN bigint, connectiondate IN date, idUser IN bigint)  
RETURNS numeric as $$
declare
	v_ownerlkpk 	bigint;  
BEGIN 
	--raise notice 'linkOwner idBasiprop, idUser (% % %)', idBasiprop, idUser;
	select nextval('seq_egswtax_connection_owner_info') into v_ownerlkpk;
	INSERT INTO egswtax_connection_owner_info(id, connection, orderno, owner, createdby, createddate, lastmodifieddate, lastmodifiedby)
    VALUES (v_ownerlkpk, connection, 1, idUser, 1, connectiondate, connectiondate, 1);
	--raise notice 'linkOwner Owner linked';
	return 1;
EXCEPTION
WHEN OTHERS THEN
raise notice 'linkOwner : % %', SQLERRM, SQLSTATE;
END;
$$ LANGUAGE plpgsql;

--Demand
create or replace FUNCTION pbsc_createDemand(oldConnectionNo IN varchar(50), idApplicationDet IN bigint, currInst IN bigint, connectiondate IN date, idModule IN bigint, currInstDesc varchar(16)) 
RETURNS numeric as $$
declare
	v_demandpk 	bigint; 
	v_dmddet 	bigint; 
	v_temp 		bigint; 
	v_idinst	bigint; 
	connectionDCB 	egswtax_stg_connection_dcb%ROWTYPE;
BEGIN 
	--raise notice 'createDemand oldConnectionNo, idConnectionDet, currInst, connectiondate, idModule (% % % %)',oldConnectionNo, idConnectionDet, currInst, connectiondate, idModule;

	select nextval('seq_eg_demand') into v_demandpk;
	INSERT INTO eg_demand(id, id_installment, base_demand, is_history, create_date, modified_date, amt_collected)
    VALUES (v_demandpk, currInst, 0, 'N', connectiondate, connectiondate, 0);

	insert into egswtax_demand_connection (id, demand, applicationdetail, createdby, createddate, lastmodifieddate, lastmodifiedby, version) values (nextval('seq_egswtax_demand_connection'), v_demandpk, idApplicationDet, 1, connectiondate, connectiondate, 1, 0);
	--raise notice 'createDemand Demand Created';
	for connectionDCB in (select * from egswtax_stg_connection_dcb where oldconsumernumber =oldConnectionNo and (ismigrated='N' or ismigrated is null))
	loop 
		select id into v_idinst from eg_installment_master where id_module=idModule and description=connectionDCB.billingcycle;
		v_temp := pbsc_createInstDemandDetail(v_demandpk, v_idinst, coalesce(connectionDCB.chargeamount, 0), coalesce(connectionDCB.chargecollection, 0), coalesce(connectionDCB.penaltyamount, 0), coalesce(connectionDCB.penaltycollection, 0), coalesce(connectionDCB.interestamount, 0), coalesce(connectionDCB.interestcollection, 0), coalesce(connectionDCB.advancecollection, 0), idModule, connectiondate);

	END LOOP;
return v_demandpk;
EXCEPTION
WHEN OTHERS THEN
raise notice 'createDemand : % %', SQLERRM, SQLSTATE;
END;
$$ LANGUAGE plpgsql;

--createInstDemandDetail
create or replace FUNCTION pbsc_createInstDemandDetail(idDemand IN bigint, idInstall IN bigint, chargeAmt IN double precision, chargeColl IN double precision, penaltyAmt IN double precision, penaltyColl IN double precision, interestAmt IN double precision, interestColl IN double precision, advanceColl IN double precision, idModule IN bigint, connectionDate IN date) 
RETURNS numeric as $$
declare
	v_temp 	bigint;  
BEGIN 
	--raise notice 'createInstDemandDetail idDemand, idInstall, propTax, eduCess, libCess, unAuthPenalty, idModule, connectionDate (% % % % % % % % % % %)',idDemand, idInstall, chargeAmt, chargeColl, penaltyAmt, penaltyColl, interestAmt, interestColl, interestColl, idModule, connectionDate;

	IF (coalesce(chargeAmt,0)>0) then
		v_temp := pbsc_createDemandDetail(idDemand, pbsc_getDemandReason(idInstall, 'SEWERAGETAX', idModule), chargeAmt, chargeColl, connectionDate);
	end if;
	IF (coalesce(penaltyAmt,0)>0) then
		v_temp := pbsc_createDemandDetail(idDemand, pbsc_getDemandReason(idInstall, 'PENALTY', idModule), penaltyAmt, penaltyColl, connectionDate);
	end if;
	IF (coalesce(interestAmt,0)>0) then
		v_temp := pbsc_createDemandDetail(idDemand, pbsc_getDemandReason(idInstall, 'INTEREST', idModule), interestAmt, interestColl, connectionDate);
	end if;
	IF (coalesce(advanceColl,0)>0) then
		v_temp := pbsc_createDemandDetail(idDemand, pbsc_getDemandReason(idInstall, 'SEWERAGEADVANCE', idModule), 0, advanceColl, connectionDate);
	end if;
	--raise notice 'createInstDemandDetail DemandDetails for installment (%) Created ', idInstall;
	return v_temp;
EXCEPTION
WHEN OTHERS THEN
raise notice 'createInstDemandDetail : % %', SQLERRM, SQLSTATE;
END;
$$ LANGUAGE plpgsql;


--createDemandDetail
create or replace FUNCTION pbsc_createDemandDetail(idDemand IN bigint, idDemandRsn IN bigint, taxAmount IN double precision, collAmount IN double precision, connectiondate IN date) 
RETURNS numeric as $$
declare
	v_dmddetpk 	bigint;  
BEGIN 
	--raise notice 'createDemand idDemand, idDemandRsn, taxAmount, collAmount, connectiondate (% % % % %)',idDemand, idDemandRsn, taxAmount, collAmount, connectiondate;

	select nextval('seq_eg_demand_details') into v_dmddetpk;
	INSERT INTO eg_demand_details(id, id_demand, id_demand_reason, amount, amt_collected, modified_date, create_date)
	VALUES (v_dmddetpk, idDemand, idDemandRsn, taxAmount, collAmount, connectiondate, connectiondate);

	--raise notice 'createDemandDetail DemandDetail Created';
return v_dmddetpk;
EXCEPTION
WHEN OTHERS THEN
raise notice 'createDemandDetail : % %', SQLERRM, SQLSTATE;
END;
$$ LANGUAGE plpgsql;


--getDemandReason
create or replace FUNCTION pbsc_getDemandReason(idInstallment IN bigint, dmdRsnCode IN VARCHAR, idModule IN bigint)
RETURNS bigint as $$
declare
	v_idDmdRsn 	bigint;  
BEGIN 
	--raise notice 'getDemandReason idInstallment, dmdRsnCode (% %)',idInstallment, dmdRsnCode;
	select dr.id
	into v_idDmdRsn
	from eg_demand_reason dr, eg_demand_reason_master drm
	where dr.id_demand_reason_master = drm.id
	and drm.module = idModule
	and dr.id_installment = idInstallment
	and drm.code = dmdRsnCode;
	--raise notice 'createDemand v_idDmdRsn (%)',v_idDmdRsn;
return v_idDmdRsn;
EXCEPTION
WHEN OTHERS THEN
raise notice 'getDemandReason : % %', SQLERRM, SQLSTATE;
END;
$$ LANGUAGE plpgsql;

--loadConnectionMaster
CREATE OR REPLACE FUNCTION pbsc_loadConnectionMaster()
  RETURNS character varying AS
$BODY$
declare
	v_isassmasterloaded bigint default 1;
	v_usagepk 			bigint;
	v_sewerage_rates 	bigint;

	usageType egswtax_stg_usagetype%ROWTYPE;
	sewerageRates egswtax_stg_seweragecharge_rates%ROWTYPE;
BEGIN 
	--Usage Type
	for usageType in (select * from egswtax_stg_usagetype order by code)
		loop 
			begin
				INSERT INTO egswtax_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby)
				VALUES (nextval('seq_egswtax_usage_type'), usageType.name, usageType.code, true, now(), now(), 1, 1);
				update egswtax_stg_usagetype set ismigrated =true where code=usageType.code;		   
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'loadConnectionMaster, Usage Type migration failed : % %', SQLERRM, SQLSTATE;
			v_isassmasterloaded := 0;
			END;
	END LOOP;
	RAISE NOTICE 'Usage Type migrated';

	--Sewerage rates
	for sewerageRates in (select * from egswtax_stg_seweragecharge_rates order by propertytype)
		loop 
			begin
				INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby)
				VALUES (nextval('seq_egswtax_seweragecharge_rates'), sewerageRates.ratetype, sewerageRates.usagetype, sewerageRates.fromplotsize, sewerageRates.toplotsize, sewerageRates.fromnooftaps, sewerageRates.tonooftaps, sewerageRates.effectivefromdate, sewerageRates.effectivetodate, sewerageRates.billamount, sewerageRates.fixedbillamount, now(), now(), 1, 1);
				update egswtax_stg_seweragecharge_rates set ismigrated =true where ratetype=sewerageRates.ratetype and usagetype=sewerageRates.usagetype and effectivetodate=sewerageRates.effectivetodate;		   
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'loadConnectionMaster, Non-metered water rates migration failed : % %', SQLERRM, SQLSTATE;
			v_isassmasterloaded := 0;
			END;
	END LOOP;
	RAISE NOTICE 'Non-metered water rates migrated';
	return v_isassmasterloaded;
EXCEPTION
WHEN OTHERS THEN
raise notice 'loadConnectionMaster failed : % %', SQLERRM, SQLSTATE;
v_isassmasterloaded := 0;
END;
$BODY$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION pbsc_validateData()
RETURNS boolean AS
$BODY$
DECLARE

	v_validate boolean default false;
	v_usagetypes bigint;
	v_totalconnections bigint;
	v_totaldcbs bigint;

	v_noofownernull bigint;
	v_nooflocalitynull bigint;
	v_noofpincodenull bigint;
	v_noofoldconsumernumbernull bigint;
	v_noofconnectiondatenull bigint;
	v_noofusagetypenull bigint;

	v_invalidlocality bigint;
	v_invalidconnectiontype bigint;
	v_invalidusagetype bigint;

	v_invalidconnectionno bigint;
	v_missingcustombillamt bigint;
	v_duplicatconnection bigint;

BEGIN
	select count(*) into v_usagetypes from egswtax_stg_usagetype;
	select count(*) into v_totalconnections from egswtax_stg_connection;
	select count(*) into v_totaldcbs from egswtax_stg_connection_dcb;

	raise notice '**********************************************';
	raise notice 'Total no.of connections : % ', v_totalconnections;
	raise notice 'Total no.of DCB for connections : % ', v_totaldcbs;
	raise notice 'Total no.of Usage Types : % ', v_usagetypes;
	raise notice '**********************************************';

	if (v_usagetypes = 0) then
		raise notice 'No Usage Type Master';
	end if;
	if (v_totalconnections = 0) then
		raise notice 'No Connections';
	end if;
	if (v_totaldcbs = 0) then
		raise notice 'No Connection DCB';
	end if;

	if (v_usagetypes > 0 and v_totalconnections > 0 and v_totaldcbs > 0) then
		raise notice '*****Master data validation passed*****';
		v_validate=true;
	else
		raise notice '***Failed***Master data validation Failed***Failed***';
		return v_validate;
	end if;

	v_validate=false;
	--Common
	select count(*) into v_noofownernull from egswtax_stg_connection where ownername is null or length(trim(ownername))=0;
	select count(*) into v_nooflocalitynull from egswtax_stg_connection where locality is null or length(trim(locality))=0;
	select count(*) into v_noofpincodenull from egswtax_stg_connection where pincode is null or length(trim(pincode))=0;
	select count(*) into v_noofoldconsumernumbernull from egswtax_stg_connection where oldconsumernumber is null or length(trim(oldconsumernumber))=0;
	select count(*) into v_noofconnectiondatenull from egswtax_stg_connection where connectiondate is null;
	select count(*) into v_noofusagetypenull from egswtax_stg_connection where usagetype is null or length(trim(usagetype))=0;
	select count(*) into v_duplicatconnection from egswtax_stg_connection group by oldconsumernumber having count(oldconsumernumber) > 1;
	v_duplicatconnection := coalesce(v_duplicatconnection, 0);

	if (v_noofownernull > 0) then
		raise notice 'There are % connection(s) where there is no ownername', v_noofownernull;
	end if;
	if (v_nooflocalitynull > 0) then
		raise notice 'There are % connection(s) where there is no locality', v_nooflocalitynull;
	end if;
	if (v_noofpincodenull > 0) then
		raise notice 'There are % connection(s) where there is no pincode', v_noofpincodenull;
	end if;
	if (v_noofoldconsumernumbernull > 0) then
		raise notice 'There are % connection(s) where there is no old consumer number', v_noofoldconsumernumbernull;
	end if;
	if (v_noofconnectiondatenull > 0) then
		raise notice 'There are % connection(s) where there is no connection date', v_noofconnectiondatenull;
	end if;
	if (v_noofusagetypenull > 0) then
		raise notice 'There are % connection(s) where there is no usage type', v_noofusagetypenull;
	end if;
	if (v_duplicatconnection > 0) then
		raise notice 'There are % duplicate connection(s)', v_duplicatconnection;
	end if;

	if (v_noofownernull = 0 and v_nooflocalitynull = 0 and v_noofpincodenull = 0 and v_noofoldconsumernumbernull = 0 and v_noofconnectiondatenull=0 and v_noofusagetypenull = 0 and v_duplicatconnection = 0) then
		raise notice '*****Common validations passed*****';
		v_validate=true;
	else
		raise notice '***Failed***Common validations Failed***Failed***';
		return v_validate;
	end if;

	--Master data reference validations
	v_validate=false;
	select count(*) into v_invalidlocality from egswtax_stg_connection where locality not in (select code from eg_boundary);
	select count(*) into v_invalidusagetype from egswtax_stg_connection where usagetype not in (select name from egswtax_stg_usagetype);

	if (v_invalidlocality > 0) then
		raise notice 'There are % connection(s) with invalid locality', v_invalidlocality;
	end if;
	if (v_invalidusagetype > 0) then
		raise notice 'There are % connection(s) with invalid usage', v_invalidusagetype;
	end if;

	if (v_invalidlocality = 0 and v_invalidusagetype = 0) then
		raise notice '*****Master reference data validations passed*****';
		v_validate=true;
	else
		raise notice '***Failed***Master data reference validations Failed***Failed***';
		return v_validate;
	end if;

	--DCB data reference
	v_validate=false;
	select count(*) into v_invalidconnectionno from egswtax_stg_connection_dcb where oldconsumernumber not in (select oldconsumernumber from egswtax_stg_connection);
	if (v_invalidconnectionno > 0) then
		raise notice 'There are % connection(s) without dcb data', v_invalidconnectionno;
	end if;

	if (v_invalidconnectionno = 0) then
		raise notice '*****DCB data validations passed*****';
		v_validate=true;
	else
		raise notice '***Failed***DCB validations Failed***Failed***';
		return v_validate;
	end if;

	--Others
	v_validate=false;
	select count(*) into v_missingcustombillamt from egswtax_stg_connection where billingtype='CUSTOM' and (custombillamount is null or custombillamount=0);
	if (v_missingcustombillamt > 0) then
		raise notice 'There are % connection(s) with Billing type Custom and no Bill Amount provided', v_missingcustombillamt;
	end if;

	if (v_missingcustombillamt = 0) then
		raise notice '*****Other data validations passed*****';
		v_validate=true;
	else
		raise notice '***Failed***Others validations Failed***Failed***';
		return v_validate;
	end if;
	return v_validate;
END;
$BODY$ LANGUAGE plpgsql;
