--migrateCityConnections
CREATE OR REPLACE FUNCTION pbwc_migrateCityConnections()
RETURNS void AS
$BODY$
DECLARE
connections egwtr_stg_connection%ROWTYPE;

v_currinst bigint;
v_currinstdesc varchar(50);
v_moduleid bigint;
v_oldconnectionno varchar(60);
v_temp integer;
v_isdatavalid boolean default false;
BEGIN
	v_isdatavalid := pbwc_validateData();
	if (v_isdatavalid) then
		select id into v_moduleid from eg_module where name='Water Tax Management';
		select id, description into v_currinst, v_currinstdesc from eg_installment_master where id_module=v_moduleid and (select (start_date - INTERVAL '1 DAY') from eg_installment_master where id_module=v_moduleid and now() between start_date and end_date) between start_date and end_date;

		for connections in (select * from egwtr_stg_connection where (ismigrated=false or ismigrated is null))
		loop 
			begin
				--raise notice 'migrateCityConnections : Started for assessment no (%)', v_connectionno;
				v_temp  := pbwc_migrateConnection(connections.oldconsumernumber, connections.connectiondate::date, v_currinst, v_currinstdesc, v_moduleid, connections.corraddress);
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'migrateCityConnections : % %', SQLERRM, SQLSTATE;
			END;
		END LOOP;
	end if;
END;
$BODY$ LANGUAGE plpgsql;

--migrateLocalityConnections
CREATE OR REPLACE FUNCTION pbwc_migrateLocalityConnections(localityCode IN varchar(16))
RETURNS void AS
$BODY$
DECLARE
connections egwtr_stg_connection%ROWTYPE;

v_currinst bigint;
v_currinstdesc varchar(50);
v_moduleid bigint;
v_temp integer;
v_isdatavalid boolean default false;
BEGIN
	v_isdatavalid := pbwc_validateData();
	if (v_isdatavalid) then
		select id into v_moduleid from eg_module where name='Water Tax Management';
		select id, description into v_currinst, v_currinstdesc from eg_installment_master where id_module=v_moduleid and (select (start_date - INTERVAL '1 DAY') from eg_installment_master where id_module=v_moduleid and now() between start_date and end_date) between start_date and end_date;

		for connections in (select * from egwtr_stg_connection where (ismigrated=false or ismigrated is null) and locality=localityCode)
		loop 
			begin
				--raise notice 'migrateLocalityConnections : Started for Old connectionno (%)', connections.oldconsumernumber;
				v_temp  := pbwc_migrateConnection(connections.oldconsumernumber, connections.connectiondate::date, v_currinst, v_currinstdesc, v_moduleid, connections.corraddress);
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'migrateLocalityConnections : % %', SQLERRM, SQLSTATE;
			END;
		END LOOP;
	end if;
END;
$BODY$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION pbwc_migrateConnection(oldConnectionNo IN varchar(60), connectionDate IN date, currinst IN bigint, currinstdesc IN varchar(50), idModule IN bigint, corrAddress IN varchar(256))
RETURNS bigint AS
$BODY$
DECLARE

v_idconnection 		bigint;
v_idconnectiondet 	bigint;
v_addressid			bigint;
v_idowner 			bigint;
v_idownerlk			bigint;
v_iddmd				bigint;
v_totaltax			double precision;

BEGIN
	begin
		--raise notice 'migrateConnection : Started for Old connectionno (% % % % %)', oldConnectionNo, currinst, currinstdesc, idModule;
		v_idowner := pbwc_createOwner(oldConnectionNo, corrAddress, v_addressid);
		--raise notice 'migrateConnection : owner created (%)', v_idowner;
		v_addressid := pbwc_createAddress(oldConnectionNo, v_idowner);
		--raise notice 'migrateConnection : address created (%)', v_addressid;
		v_idconnectiondet := pbwc_createConnection(oldConnectionNo, v_addressid);
		--raise notice 'migrateConnection : Connection created (%)', v_idconnection;
		select connection into v_idconnection from egwtr_connectiondetails where id=v_idconnectiondet;
		v_idownerlk := pbwc_linkOwner(v_idconnection, connectionDate, v_idowner);
		--raise notice 'migrateConnection : Owner linked (%)', v_idownerlk;
		select sum(coalesce(chargeamount, 0) + coalesce(penaltyamount, 0) + coalesce(interestamount, 0)) into v_totaltax from egwtr_stg_connection conn, egwtr_stg_connection_dcb dcb where conn.oldconsumernumber=dcb.oldconsumernumber and conn.oldconsumernumber=oldConnectionNo;
		if(v_totaltax>0)then
			v_iddmd := pbwc_createDemand(oldConnectionNo, v_idconnectiondet, currinst, connectionDate, idModule, currinstdesc);
			--raise notice 'migrateConnection : Demand created';
		end if;
		update egwtr_stg_connection set ismigrated=true where oldconsumernumber=oldConnectionNo;
		return v_idconnectiondet;
	EXCEPTION
	WHEN OTHERS THEN
	raise notice 'migrateConnection : % %', SQLERRM, SQLSTATE;
	update egwtr_stg_connection set error = SQLSTATE || '-' || SQLERRM where oldconsumernumber=oldConnectionNo;
	END;
END;
$BODY$ LANGUAGE plpgsql;


--generateUsername
create or replace FUNCTION pbwc_generateUsername(name IN varchar(100))
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
create or replace FUNCTION pbwc_createAddress(oldConnectionNo IN varchar(50), userid IN bigint)  
RETURNS numeric as $$
declare
	v_addresspk 	bigint;  
BEGIN 
	--raise notice 'createAddress oldConnectionNo (%)', oldConnectionNo;
	select nextval('seq_eg_address') into v_addresspk;
	INSERT INTO eg_address(housenobldgapt, type, landmark, streetroadline, arealocalitysector, pincode, id, userid, buildingname)
	select houseno, 'WTCONNECTION_ADDRESS', landmark, street, (select name from eg_boundary where code=locality), pincode, v_addresspk, userid, buildingname from egwtr_stg_connection where oldconsumernumber = oldConnectionNo;
	insert into egwtr_address (id) values (v_addresspk);
	--raise notice 'createAddress Address created';
return v_addresspk;
EXCEPTION
WHEN OTHERS THEN
raise notice 'createAddress : % %', SQLERRM, SQLSTATE;
END; 
$$ LANGUAGE plpgsql;

--createOwner
create or replace FUNCTION pbwc_createOwner(oldConnectionNo IN varchar(50), corraddress IN varchar(256), addressid IN bigint)  
RETURNS numeric as $$
declare
	v_userpk 	bigint;  
	v_addresspk	bigint;
BEGIN 
	--raise notice 'createOwner oldConnectionNo, corraddr1, corraddr2, addressid (% % % % %)', oldConnectionNo, corraddr1, corraddr2, addressid;
	select nextval('seq_eg_address') into v_addresspk;
	select nextval('seq_eg_user') into v_userpk;
	INSERT INTO eg_user(id, locale, username, password, mobilenumber, emailid, createddate, lastmodifieddate, createdby, lastmodifiedby, active, name, gender, type, aadhaarnumber, guardian, guardianrelation, dob)
    select v_userpk, 'en_IN', pbwc_generateUsername(ownername), 'NOT SET', mobileno, emailid, connectiondate, connectiondate, 1, 1, TRUE, ownername, (CASE WHEN gender = 'Female' THEN 0 ELSE 1 END), 'CITIZEN', aadharno, guardian, guardianrelation, dob from egwtr_stg_connection where oldconsumernumber = oldConnectionNo;

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
create or replace FUNCTION pbwc_createConnection(oldConnectionNo IN varchar(50), addressid bigint)  
RETURNS numeric as $$
declare
	v_connectionpk 		bigint;
	v_connectiondetpk 	bigint;    
	v_connectionno 		varchar(10);
BEGIN
	select nextval('SEQ_CONSUMER_NUMBER') into v_connectionno;
	select code||lpad(v_connectionno,6,'0') into v_connectionno from eg_city;
	select nextval('seq_egwtr_connection') into v_connectionpk;
	select nextval('seq_egwtr_connectiondetails') into v_connectiondetpk;

	--raise notice 'createConnection oldConnectionNo, addressid (% %)',oldConnectionNo, addressid;
INSERT INTO egwtr_connection(id, oldconsumernumber, consumercode, propertyidentifier, address, sewerageidentifier, zone, ward, block, locality, createdby, createddate, lastmodifieddate, lastmodifiedby, version)
	select v_connectionpk, oldconsumernumber, v_connectionno, propertyidentifier, addressid, sewerageconnectionnumber, (select parent from eg_boundary where id= (select parent from eg_boundary where code=locality)), null, (select parent from eg_boundary where code=locality), (select id from eg_boundary where code=locality), 1, connectiondate, connectiondate, 1, 0 from egwtr_stg_connection where oldconsumernumber = oldConnectionNo;
	--raise notice 'createConnection connection created';
INSERT INTO  egwtr_connectiondetails (id, connection, applicationdate, executiondate, applicationtype, billingtype, billamount, plotsize, nooftaps, ledgernumber, billgroupnumber, connectiontype, watersource, propertytype, category, usagetype, pipesize, donationcharges, connectionstatus, legacy, statusid, createdby, createddate, lastmodifieddate, lastmodifiedby, approvalnumber, connectionreason, isplotsizeactual, currentoccupier, currentbillingcycle, lastbilldate, version)
	select v_connectiondetpk, v_connectionpk, connectiondate, connectiondate, (select id from egwtr_application_type where code='NEWCONNECTION'), upper(billingtype), custombillamount, plotsize, nooftaps, ledgerid, billgroupid, connectiontype, (select id from egwtr_water_source where watersourcetype=watersource), (select id from egwtr_property_type where name=propertytype), (select id from egwtr_category where name=category), (select id from egwtr_usage_type where name=usagetype), (select id from egwtr_pipesize where code=pipesize), coalesce(securitydeposit,0), coalesce(status,'ACTIVE'), true, (select id from egw_status where moduletype='WATERTAXAPPLICATION' and code='SANCTIONED'), 1, connectiondate, connectiondate, 1, 'Migrated Connection', 'Migrated Connection', (CASE WHEN isplotsizeactual = 'Yes' THEN TRUE ELSE FALSE END), currentoccupier, currentbillingcycle, lastbilldate, 0 from egwtr_stg_connection where oldconsumernumber = oldConnectionNo;
	--raise notice 'createConnection connection details created';
return v_connectiondetpk;
EXCEPTION
WHEN OTHERS THEN
raise notice 'createConnection : % %', SQLERRM, SQLSTATE;
END; 
$$ LANGUAGE plpgsql;

--Link Owner to Property
create or replace FUNCTION pbwc_linkOwner(connection IN bigint, connectiondate IN date, idUser IN bigint)  
RETURNS numeric as $$
declare
	v_ownerlkpk 	bigint;  
BEGIN 
	--raise notice 'linkOwner idBasiprop, idUser (% % %)', idBasiprop, idUser;
	select nextval('seq_egwtr_connection_owner_info') into v_ownerlkpk;
	INSERT INTO egwtr_connection_owner_info(id, connection, orderno, owner, createdby, createddate, lastmodifieddate, lastmodifiedby)
    VALUES (v_ownerlkpk, connection, 1, idUser, 1, connectiondate, connectiondate, 1);
	--raise notice 'linkOwner Owner linked';
	return 1;
EXCEPTION
WHEN OTHERS THEN
raise notice 'linkOwner : % %', SQLERRM, SQLSTATE;
END;
$$ LANGUAGE plpgsql;

--Demand
create or replace FUNCTION pbwc_createDemand(oldConnectionNo IN varchar(50), idConnectionDet IN bigint, currInst IN bigint, connectiondate IN date, idModule IN bigint, currInstDesc varchar(16)) 
RETURNS numeric as $$
declare
	v_demandpk 		bigint; 
	v_dmddet 		bigint; 
	v_temp 			bigint; 
	v_idinst		bigint; 
	connectionDCB 	egwtr_stg_connection_dcb%ROWTYPE;
BEGIN 
	--raise notice 'createDemand oldConnectionNo, idConnectionDet, currInst, connectiondate, idModule (% % % %)',oldConnectionNo, idConnectionDet, currInst, connectiondate, idModule;

	select nextval('seq_eg_demand') into v_demandpk;
	INSERT INTO eg_demand(id, id_installment, base_demand, is_history, create_date, modified_date, amt_collected)
    VALUES (v_demandpk, currInst, 0, 'N', connectiondate, connectiondate, 0);

	insert into egwtr_demand_connection (id, demand, connectiondetails, createdby, createddate, lastmodifieddate, lastmodifiedby, version) values (nextval('seq_egwtr_demand_connection'), v_demandpk, idConnectionDet, 1, connectiondate, connectiondate, 1, 0);
	--raise notice 'createDemand Demand Created';
	for connectionDCB in (select * from egwtr_stg_connection_dcb where oldconsumernumber =oldConnectionNo and (ismigrated='N' or ismigrated is null))
	loop 
		select id into v_idinst from eg_installment_master where id_module=idModule and description=connectionDCB.billingcycle;
		v_temp := pbwc_createInstDemandDetail(v_demandpk, v_idinst, coalesce(connectionDCB.chargeamount, 0), coalesce(connectionDCB.chargecollection, 0), coalesce(connectionDCB.penaltyamount, 0), coalesce(connectionDCB.penaltycollection, 0), coalesce(connectionDCB.interestamount, 0), coalesce(connectionDCB.interestcollection, 0), coalesce(connectionDCB.advancecollection, 0), idModule, connectiondate);
	END LOOP;
return v_demandpk;
EXCEPTION
WHEN OTHERS THEN
raise notice 'createDemand : % %', SQLERRM, SQLSTATE;
END;
$$ LANGUAGE plpgsql;

--createInstDemandDetail
create or replace FUNCTION pbwc_createInstDemandDetail(idDemand IN bigint, idInstall IN bigint, chargeAmt IN double precision, chargeColl IN double precision, penaltyAmt IN double precision, penaltyColl IN double precision, interestAmt IN double precision, interestColl IN double precision, advanceColl IN double precision, idModule IN bigint, connectionDate IN date) 
RETURNS numeric as $$
declare
	v_temp 	bigint;  
BEGIN 
	--raise notice 'createInstDemandDetail idDemand, idInstall, propTax, eduCess, libCess, unAuthPenalty, idModule, connectionDate (% % % % % % % % % % %)',idDemand, idInstall, chargeAmt, chargeColl, penaltyAmt, penaltyColl, interestAmt, interestColl, interestColl, idModule, connectionDate;

	if (coalesce(chargeAmt,0)>0) then
		v_temp := pbwc_createDemandDetail(idDemand, pbwc_getDemandReason(idInstall, 'WTAXCHARGES', idModule), chargeAmt, chargeColl, connectionDate);
	end if;
	if (coalesce(penaltyAmt,0)>0) then
		v_temp := pbwc_createDemandDetail(idDemand, pbwc_getDemandReason(idInstall, 'PENALTY', idModule), penaltyAmt, penaltyColl, connectionDate);
	end if;
	if (coalesce(interestAmt,0)>0) then
		v_temp := pbwc_createDemandDetail(idDemand, pbwc_getDemandReason(idInstall, 'INTEREST', idModule), interestAmt, interestColl, connectionDate);
	end if;
	if (coalesce(advanceColl,0)>0) then
		v_temp := pbwc_createDemandDetail(idDemand, pbwc_getDemandReason(idInstall, 'WTADVANCE', idModule), 0, advanceColl, connectionDate);
	end if;
	--raise notice 'createInstDemandDetail DemandDetails for installment (%) Created ', idInstall;
	return v_temp;
EXCEPTION
WHEN OTHERS THEN
raise notice 'createInstDemandDetail : % %', SQLERRM, SQLSTATE;
END;
$$ LANGUAGE plpgsql;


--createDemandDetail
create or replace FUNCTION pbwc_createDemandDetail(idDemand IN bigint, idDemandRsn IN bigint, taxAmount IN double precision, collAmount IN double precision, connectiondate IN date) 
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
create or replace FUNCTION pbwc_getDemandReason(idInstallment IN bigint, dmdRsnCode IN VARCHAR, idModule IN bigint)
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
CREATE OR REPLACE FUNCTION pbwc_loadConnectionMaster()
  RETURNS character varying AS
$BODY$
declare
	v_isassmasterloaded bigint default 1;
	v_propertytypepk 	bigint; 
	v_usagepk 			bigint;
	v_pipeziepk 		bigint;
	v_categorypk 		bigint;
	v_ptype_usage_pk 	bigint;
	v_ptype_pipesize_pk bigint;
	v_ptype_category_pk bigint;
	v_nonmetered_rates 	bigint;
	v_metered_rates 	bigint;

	propertyType egwtr_stg_propertytype%ROWTYPE;
	usageType egwtr_stg_usagetype%ROWTYPE;
	pipeSize egwtr_stg_pipesize%ROWTYPE;
	cagtegory egwtr_stg_category%ROWTYPE;
	ptypeUsageType egwtr_stg_proptype_usage%ROWTYPE;
	ptypePipeSize egwtr_stg_proptype_pipesize%ROWTYPE;
	ptypeCategory egwtr_stg_category%ROWTYPE;
	nonMeteredRates egwtr_stg_nonmetered_rates%ROWTYPE;
	meteredRates egwtr_stg_metered_rates%ROWTYPE;
BEGIN 
	--Property Type
	for propertyType in (select * from egwtr_stg_propertytype order by code)
		loop 
			begin
				INSERT INTO egwtr_property_type(id, name, code, connectioneligibility, active, createddate, lastmodifieddate, createdby, lastmodifiedby)
				VALUES (nextval('seq_egwtr_property_type'), propertyType.name, propertyType.code, 'Y', true, now(), now(), 1, 1);
				update egwtr_stg_propertytype set ismigrated =true where code=propertyType.code;		   
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'loadConnectionMaster, Property Type migration failed : % %', SQLERRM, SQLSTATE;
			v_isassmasterloaded := 0;
			END;
	END LOOP;
	RAISE NOTICE 'Property Type migrated';

	--Usage Type
	for usageType in (select * from egwtr_stg_usagetype order by code)
		loop 
			begin
				INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby)
				VALUES (nextval('seq_egwtr_usage_type'), usageType.name, usageType.code, true, now(), now(), 1, 1);
				update egwtr_stg_usagetype set ismigrated =true where code=usageType.code;		   
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'loadConnectionMaster, Usage Type migration failed : % %', SQLERRM, SQLSTATE;
			v_isassmasterloaded := 0;
			END;
	END LOOP;
	RAISE NOTICE 'Usage Type migrated';

	--Pipe Size
	for pipeSize in (select * from egwtr_stg_pipesize order by code)
		loop 
			begin
				INSERT INTO egwtr_pipesize(id, code, sizeininch, sizeinmilimeter, active, createddate, lastmodifieddate, createdby, lastmodifiedby)
				VALUES (nextval('seq_egwtr_pipesize'), pipeSize.code, pipeSize.sizeininch, pipeSize.sizeinmilimeter, true, now(), now(), 1, 1);
				update egwtr_stg_pipesize set ismigrated =true where code=pipeSize.code;		   
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'loadConnectionMaster, Pipe Size migration failed : % %', SQLERRM, SQLSTATE;
			v_isassmasterloaded := 0;
			END;
	END LOOP;
	RAISE NOTICE 'Pipe Size migrated';

	--cagtegory
	for cagtegory in (select * from egwtr_stg_category order by code)
		loop 
			begin
				INSERT INTO egwtr_category(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby)
				VALUES (nextval('seq_egwtr_category'), cagtegory.name, cagtegory.code, true, now(), now(), 1, 1);
				update egwtr_stg_category set ismigrated =true where code=cagtegory.code;		   
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'loadConnectionMaster, category migration failed : % %', SQLERRM, SQLSTATE;
			v_isassmasterloaded := 0;
			END;
	END LOOP;
	RAISE NOTICE 'category migrated';

	--proptype - usage
	for ptypeUsageType in (select * from egwtr_stg_proptype_usage order by propertytype)
		loop 
			begin
				INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby)
				VALUES (nextval('seq_egwtr_property_usage'), ptypeUsageType.propertytype, ptypeUsageType.usagetype, true, now(), now(), 1, 1);
				update egwtr_stg_proptype_usage set ismigrated =true where propertytype=ptypeUsageType.propertytype and usagetype=ptypeUsageType.usagetype;		   
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'loadConnectionMaster, property type usage mapping migration failed : % %', SQLERRM, SQLSTATE;
			v_isassmasterloaded := 0;
			END;
	END LOOP;
	RAISE NOTICE 'property type usage mapping migrated';

	--proptype - pipesize
	for ptypePipeSize in (select * from egwtr_stg_proptype_pipesize order by propertytype)
		loop 
			begin
				INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby)
				VALUES (nextval('seq_egwtr_property_pipesize'), ptypePipeSize.propertytype, ptypePipeSize.pipesize, true, now(), now(), 1, 1);
				update egwtr_stg_proptype_usage set ismigrated =true where propertytype=ptypePipeSize.propertytype and pipesize=ptypePipeSize.pipesize;		   
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'loadConnectionMaster, property type pipesize mapping migration failed : % %', SQLERRM, SQLSTATE;
			v_isassmasterloaded := 0;
			END;
	END LOOP;
	RAISE NOTICE 'property type pipesize mapping migrated';

	--proptype - category
	for ptypeCategory in (select * from egwtr_stg_proptype_category order by propertytype)
		loop 
			begin
				INSERT INTO egwtr_property_category(id, propertytype, categorytype, active, createddate, lastmodifieddate, createdby, lastmodifiedby)
				VALUES (nextval('seq_egwtr_property_category'), ptypeCategory.propertytype, ptypeCategory.category, true, now(), now(), 1, 1);
				update egwtr_stg_proptype_category set ismigrated =true where propertytype=ptypeCategory.propertytype and category=ptypeCategory.category;		   
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'loadConnectionMaster, property type category mapping migration failed : % %', SQLERRM, SQLSTATE;
			v_isassmasterloaded := 0;
			END;
	END LOOP;
	RAISE NOTICE 'property type category mapping migrated';

	--Non Metred water rates
	for nonMeteredRates in (select * from egwtr_stg_nonmetered_rates order by propertytype)
		loop 
			begin
				INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby)
				VALUES (nextval('seq_egwtr_watercharge_rates'), nonMeteredRates.propertytype, nonMeteredRates.ratetype, nonMeteredRates.usagetype, nonMeteredRates.fromplotsize, nonMeteredRates.toplotsize, nonMeteredRates.fromnooftaps, nonMeteredRates.tonooftaps, nonMeteredRates.effectivefromdate, nonMeteredRates.effectivetodate, nonMeteredRates.billamount, nonMeteredRates.fixedbillamount, now(), now(), 1, 1);
				update egwtr_stg_nonmetered_rates set ismigrated =true where ratetype=nonMeteredRates.ratetype and usagetype=nonMeteredRates.usagetype and effectivetodate=nonMeteredRates.effectivetodate;		   
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

CREATE OR REPLACE FUNCTION pbwc_validateData()
RETURNS boolean AS
$BODY$
DECLARE

	v_validate boolean default false;
	v_proptypes bigint;
	v_usagetypes bigint;
	v_propusages bigint;
	v_pipesizes bigint;
	v_proppipes bigint;
	v_categories bigint;
	v_propcategories bigint;
	v_totalconnections bigint;
	v_totaldcbs bigint;

	v_noofownernull bigint;
	v_nooflocalitynull bigint;
	v_noofpincodenull bigint;
	v_noofoldconsumernumbernull bigint;
	v_noofconnectiondatenull bigint;
	v_noofconnectiontypenull bigint;
	v_noofwatersourcenull bigint;
	v_noofpropertytypenull bigint;
	v_noofcategorynull bigint;
	v_noofusagetypenull bigint;
	v_noofpipesizenull bigint;

	v_invalidlocality bigint;
	v_invalidconnectiontype bigint;
	v_invalidwatersource bigint;
	v_invalidpropertytype bigint;
	v_invalidcategory bigint;
	v_invalidusagetype bigint;
	v_invalidpipesize bigint;

	v_invalidconnectionno bigint;
	v_missingcustombillamt bigint;

	v_noofmeterserialnonull bigint;
	v_noofpreviousreadingnull bigint;
	v_nooflatestreadingnull bigint;
	v_nooflatestreadingdatenull bigint;
	v_noofavglastthreereadingnull bigint;
	v_noofismeterfunctionalnull bigint;

	v_duplicatconnection bigint;


BEGIN
	select count(*) into v_proptypes from egwtr_stg_propertytype;
	select count(*) into v_usagetypes from egwtr_stg_usagetype;
	select count(*) into v_propusages from egwtr_stg_proptype_usage;
	select count(*) into v_pipesizes from egwtr_stg_pipesize;
	select count(*) into v_proppipes from egwtr_stg_proptype_pipesize;
	select count(*) into v_categories from egwtr_stg_category;
	select count(*) into v_propcategories from egwtr_stg_proptype_category;
	select count(*) into v_totalconnections from egwtr_stg_connection;
	select count(*) into v_totaldcbs from egwtr_stg_connection_dcb;

	raise notice '**********************************************';
	raise notice 'Total no.of connections : % ', v_totalconnections;
	raise notice 'Total no.of DCB for connections : % ', v_totaldcbs;
	raise notice 'Total no.of Property Types : % ', v_proptypes;
	raise notice 'Total no.of Usage Types : % ', v_usagetypes;
	raise notice 'Total no.of Property Usages : % ', v_propusages;
	raise notice 'Total no.of Pipe Sizes : % ', v_pipesizes;
	raise notice 'Total no.of Property Pipes : % ', v_proppipes;
	raise notice 'Total no.of Categories : % ', v_categories;
	raise notice 'Total no.of Property Categories : % ', v_propcategories;
	raise notice '**********************************************';

	if (v_proptypes = 0) then
		raise notice 'No Property Type Master';
	end if;
	if (v_usagetypes = 0) then
		raise notice 'No Usage Type Master';
	end if;
	if (v_propusages = 0) then
		raise notice 'No Property Usage Master';
	end if;
	if (v_pipesizes = 0) then
		raise notice 'No Pipe Size Master';
	end if;
	if (v_proppipes = 0) then
		raise notice 'No Property Pipe Master';
	end if;
	if (v_categories = 0) then
		raise notice 'No Category Master';
	end if;
	if (v_propcategories = 0) then
		raise notice 'No Property Category Master';
	end if;

	if (v_proptypes > 0 and v_usagetypes > 0 and v_propusages > 0 and v_pipesizes > 0 and v_proppipes > 0 and v_categories > 0 and v_propcategories > 0) then
		raise notice '*****Master data validation passed*****';
		v_validate=true;
	else
		raise notice '***Failed***Master data validation Failed***Failed***';
		v_validate=false;
	end if;

	v_validate=false;
	--Common
	select count(*) into v_noofownernull from egwtr_stg_connection where ownername is null or length(trim(ownername))=0;
	select count(*) into v_nooflocalitynull from egwtr_stg_connection where locality is null or length(trim(locality))=0;
	select count(*) into v_noofpincodenull from egwtr_stg_connection where pincode is null or length(trim(pincode))=0;
	select count(*) into v_noofoldconsumernumbernull from egwtr_stg_connection where oldconsumernumber is null or length(trim(oldconsumernumber))=0;
	select count(*) into v_noofconnectiondatenull from egwtr_stg_connection where connectiondate is null;
	select count(*) into v_noofconnectiontypenull from egwtr_stg_connection where connectiontype is null or length(trim(connectiontype))=0;
	select count(*) into v_noofwatersourcenull from egwtr_stg_connection where watersource is null or length(trim(watersource))=0;
	select count(*) into v_noofpropertytypenull from egwtr_stg_connection where propertytype is null or length(trim(propertytype))=0;
	select count(*) into v_noofcategorynull from egwtr_stg_connection where category is null or length(trim(category))=0;
	select count(*) into v_noofusagetypenull from egwtr_stg_connection where usagetype is null or length(trim(usagetype))=0;
	select count(*) into v_noofpipesizenull from egwtr_stg_connection where pipesize is null or length(trim(pipesize))=0;
	select count(*) into v_duplicatconnection from egwtr_stg_connection group by oldconsumernumber having count(oldconsumernumber) > 1;

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
	if (v_noofconnectiontypenull > 0) then
		raise notice 'There are % connection(s) where there is no connection type', v_noofconnectiontypenull;
	end if;
	if (v_noofwatersourcenull > 0) then
		raise notice 'There are % connection(s) where there is no water source', v_noofwatersourcenull;
	end if;
	if (v_noofpropertytypenull > 0) then
		raise notice 'There are % connection(s) where there is no property type', v_noofpropertytypenull;
	end if;
	if (v_noofcategorynull > 0) then
		raise notice 'There are % connection(s) where there is no category', v_noofcategorynull;
	end if;
	if (v_noofusagetypenull > 0) then
		raise notice 'There are % connection(s) where there is no usage type', v_noofusagetypenull;
	end if;
	if (v_noofpipesizenull > 0) then
		raise notice 'There are % connection(s) where there is no pipe size', v_noofpipesizenull;
	end if;
	if (v_duplicatconnection > 0) then
		raise notice 'There are % duplicate connection(s)', v_duplicatconnection;
	end if;

	if (v_noofownernull = 0 and v_nooflocalitynull = 0 and v_noofpincodenull = 0 and v_noofoldconsumernumbernull = 0 and v_noofconnectiondatenull=0 and v_noofconnectiontypenull = 0 and v_noofwatersourcenull = 0 and v_noofpropertytypenull = 0 and v_noofcategorynull = 0 and v_noofusagetypenull = 0 and v_noofpipesizenull = 0  and v_duplicatconnection = 0) then
		raise notice '*****Common validations passed*****';
		v_validate=true;
	else
		raise notice '***Failed***Common validations Failed***Failed***';
		v_validate=false;
	end if;

	--Master data reference validations
	v_validate=false;
	select count(*) into v_invalidlocality from egwtr_stg_connection where locality not in (select code from eg_boundary);
	select count(*) into v_invalidconnectiontype from egwtr_stg_connection where connectiontype not in ('METERED','NON_METERED');
	select count(*) into v_invalidwatersource from egwtr_stg_connection where watersource not in (select watersourcetype from egwtr_water_source);
	select count(*) into v_invalidpropertytype from egwtr_stg_connection where propertytype not in (select name from egwtr_stg_propertytype);
	select count(*) into v_invalidcategory from egwtr_stg_connection where category not in (select name from egwtr_stg_category);
	select count(*) into v_invalidusagetype from egwtr_stg_connection where usagetype not in (select name from egwtr_stg_usagetype);
	select count(*) into v_invalidpipesize from egwtr_stg_connection where pipesize not in (select code from egwtr_stg_pipesize);

	if (v_invalidlocality > 0) then
		raise notice 'There are % connection(s) with invalid locality', v_invalidlocality;
	end if;
	if (v_invalidconnectiontype > 0) then
		raise notice 'There are % connection(s) with invalid connection type', v_invalidconnectiontype;
	end if;
	if (v_invalidwatersource > 0) then
		raise notice 'There are % connection(s) with invalid water source', v_invalidwatersource;
	end if;
	if (v_invalidpropertytype > 0) then
		raise notice 'There are % connection(s) with invalid property type', v_invalidpropertytype;
	end if;
	if (v_invalidcategory > 0) then
		raise notice 'There are % connection(s) with invalid category', v_invalidcategory;
	end if;
	if (v_invalidusagetype > 0) then
		raise notice 'There are % connection(s) with invalid usage', v_invalidusagetype;
	end if;
	if (v_invalidpipesize > 0) then
		raise notice 'There are % connection(s) with invalid pipe size', v_invalidpipesize;
	end if;

	if (v_invalidlocality = 0 and v_invalidconnectiontype = 0 and v_invalidwatersource = 0 and v_invalidpropertytype = 0 and v_invalidcategory = 0 and v_invalidusagetype = 0 and v_invalidpipesize = 0) then
		raise notice '*****Master reference data validations passed*****';
		v_validate=true;
	else
		raise notice '***Failed***Master data reference validations Failed***Failed***';
		v_validate=false;
	end if;

	--DCB data reference
	v_validate=false;
	select count(*) into v_invalidconnectionno from egwtr_stg_connection where oldconsumernumber not in (select oldconsumernumber from egwtr_stg_connection_dcb);
	if (v_invalidconnectionno > 0) then
		raise notice 'There are % connection(s) without dcb data', v_invalidconnectionno;
	end if;

	if (v_invalidconnectionno = 0) then
		raise notice '*****DCB data validations passed*****';
		v_validate=true;
	else
		raise notice '***Failed***DCB validations Failed***Failed***';
		v_validate=false;
	end if;

	--Others
	v_validate=false;
	select count(*) into v_missingcustombillamt from egwtr_stg_connection where billingtype='CUSTOM' and (custombillamount is null or custombillamount=0);
	if (v_missingcustombillamt > 0) then
		raise notice 'There are % connection(s) with Billing type Custom and no Bill Amount provided', v_missingcustombillamt;
	end if;

	if (v_missingcustombillamt = 0) then
		raise notice '*****Other data validations passed*****';
		v_validate=true;
	else
		raise notice '***Failed***Others validations Failed***Failed***';
		v_validate=false;
	end if;

	--v_validate=false;
	--Metered
	select count(*) into v_noofmeterserialnonull from egwtr_stg_connection where connectiontype='METERED' and (meterserialno is null or length(trim(meterserialno))=0);
	select count(*) into v_noofpreviousreadingnull from egwtr_stg_connection where connectiontype='METERED' and (previousreading is null or previousreading=0);
	select count(*) into v_nooflatestreadingnull from egwtr_stg_connection where connectiontype='METERED' and (latestreading is null or latestreading=0);
	select count(*) into v_nooflatestreadingdatenull from egwtr_stg_connection where connectiontype='METERED' and latestreadingdate is null;
	select count(*) into v_noofavglastthreereadingnull from egwtr_stg_connection where connectiontype='METERED' and (avglastthreereading is null or avglastthreereading=0);
	select count(*) into v_noofismeterfunctionalnull from egwtr_stg_connection where connectiontype='METERED' and (ismeterfunctional is null or length(trim(ismeterfunctional))=0);
	return v_validate;
END;
$BODY$ LANGUAGE plpgsql;
