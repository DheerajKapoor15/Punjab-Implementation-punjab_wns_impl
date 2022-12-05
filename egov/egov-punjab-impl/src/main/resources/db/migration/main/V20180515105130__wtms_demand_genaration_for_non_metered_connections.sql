CREATE OR REPLACE FUNCTION wtms_demand_genaration_for_non_metered_connections()
RETURNS void AS
$BODY$
DECLARE
props record;
v_temp bigint;
v_temp1 bigint;
v_new1st_instid bigint;
v_new2nd_instid bigint;
v_moduleid bigint;

BEGIN
	
	--select id into v_moduleid from eg_module where name='Water Tax Management';
	--select id into v_new1st_instid from eg_installment_master where id_module=v_moduleid and start_date=to_date('01/04/2017', 'dd/MM/yyyy');
	--select id into v_new2nd_instid from eg_installment_master where id_module=v_moduleid and start_date=to_date('01/10/2017', 'dd/MM/yyyy');

	for props in (select id,name from eg_boundary where id in (SELECT distinct locality FROM 
	egwtr_connection conn, egwtr_connectiondetails conndet, egw_status status WHERE 
	conn.id=conndet.connection and conndet.connectionstatus='ACTIVE' and 
	conndet.connectiontype='NON_METERED' AND conndet.statusid=status.id 
	and status.moduletype='WATERTAXAPPLICATION' and status.code='SANCTIONED'
	))
	loop 
		begin
			v_temp  := wtms_demand_genaration_for_non_metered_connections_for_locality(props.id,v_new1st_instid,v_new2nd_instid);
			
		EXCEPTION
		WHEN OTHERS THEN
		raise notice ' rolloverward For FULL ULB  % %',SQLERRM, SQLSTATE;
		END;
	END LOOP;
	
END;
$BODY$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION wtms_demand_genaration_for_non_metered_connections_for_locality(in_wardid bigint,v_new1st_instid bigint,v_new2nd_instid bigint)
RETURNS numeric AS
$BODY$
DECLARE
props record;
v_currinstdesc varchar(16);
v_moduleid bigint;
v_newInstId integer;
v_temp integer;
v_rollovercount integer default 0;
BEGIN

	raise notice 'rolloverward : v_new1st_instid, v_new2nd_instid,ward (%  % %)' , v_new1st_instid, v_new2nd_instid,in_wardid;

	for props in (SELECT distinct conn.consumercode,conndet.id  FROM egwtr_connection conn,egwtr_connectiondetails conndet, egw_status status WHERE conn.id=conndet.connection and conn.locality=in_wardid and  conndet.connectionstatus='ACTIVE' and conndet.connectiontype='NON_METERED' AND conndet.statusid=status.id and status.moduletype='WATERTAXAPPLICATION' and status.code='SANCTIONED')
	loop 
		begin
			raise notice 'rolloverward : Started for consumernumber, idconnectiondetail (% %)', props.consumercode, props.id;
			v_temp  := wtms_demand_generation_for_consumer_code(props.id, v_new1st_instid, v_new2nd_instid);
			v_rollovercount := v_rollovercount + 1;
		EXCEPTION
		WHEN OTHERS THEN
		raise notice ' error......... rolloverward conndetId  and consumercode: % % % %',props.id,props.consumercode,SQLERRM, SQLSTATE;
		END;
	END LOOP;
	raise notice 'wtms_demand_collected_RegeDemand_rolloverward completed for Ward: (%)', in_wardid;
	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;


----------------------------------------


CREATE OR REPLACE FUNCTION wtms_demand_generation_for_consumer_code(in_idconndetail bigint, in_new_1stinstid bigint, in_new_2ndinstid bigint)
RETURNS numeric AS
$BODY$
DECLARE
v_olddemandid bigint;
v_newdemandid bigint;
v_newConnDemand bigint;
v_temp integer;
v_newdemand_reason bigint;
v_newdemand_reason2 bigint;
v_demandAmountfromWtRate double precision;
v_newbase_demnd double precision;
v_demandreasoninst1 bigint;
v_demandreasoninst2 bigint;
v_originalDemandId bigint;
v_firstinstallmentAmount1 double precision;
v_firstinstallmentAmountCollected double precision;
v_secondinstallmentAmountCoolected double precision;
v_secondinstallmentAmount double precision;
v_id_installment bigint;

BEGIN
	raise notice 'rollover : in_idconndetail, in_new_1stinstid, in_new_2ndinstid (% % %)', in_idconndetail, in_new_1stinstid, in_new_2ndinstid;

	select max(conndem.demand) into v_olddemandid from eg_demand d, egwtr_demand_connection conndem where d.id = conndem.demand and d.is_history='N' and conndem.connectiondetails = in_idconndetail;

	select wtms_rates_by_connectiondetails_id(in_idconndetail) into v_demandAmountfromWtRate;

	raise notice 'old demand id v_olddemandid and v_originalDemandId  (% %)',v_olddemandid,v_originalDemandId;

	
	raise notice 'Before if :v_firstinstallmentAmount1 and v_demandAmountfromWtRate (% %)',v_firstinstallmentAmount1,v_demandAmountfromWtRate;
	
	
	if(v_demandAmountfromWtRate is not null)then
		if(true)then
			raise notice 'inside IF:v_firstinstallmentAmount1 and v_demandAmountfromWtRate (% %)',v_firstinstallmentAmount1,v_demandAmountfromWtRate;

			if (v_olddemandid IS NOT NULL) then 
			
			
			select sum(amount) into v_newbase_demnd from eg_demand_details where id_demand=v_olddemandid and id_demand_reason not in (select id from eg_demand_reason where id_demand_reason_master in (select id from eg_demand_reason_master where code='WTAXCHARGES' and module in(select id from eg_module where name='Water Tax Management')) and id_installment in(in_new_1stinstid,in_new_2ndinstid));
		
			insert into eg_demand (id, id_installment, base_demand, is_history, create_date, modified_date, amt_collected, status, min_amt_payable, amt_rebate) select v_newdemandid, in_new_2ndinstid, base_demand, is_history, now(), now(),amt_collected, status, null, 0 from eg_demand where id = v_olddemandid;
			--copying old demand_demand_details to new eg_demand.
			
			insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no, remarks, amount, modified_date,
			create_date, amt_collected, amt_rebate) 
			select nextval('seq_eg_demand_details'), v_newdemandid, id_demand_reason, id_status,
			file_reference_no, remarks, amount, modified_date, create_date, amt_collected, amt_rebate 
			from eg_demand_details where id_demand = v_olddemandid;
			raise notice 'copied old demand_demand_details to new eg_demand of id(%)',v_newdemandid;
			
			update eg_demand set is_history='Y' where id=v_olddemandid;

			else
				select id into v_id_installment from eg_installment_master where id_module=(select id from eg_module where name = 'Water Tax Management') and start_date=to_date('01/04/2018', 'dd/MM/yyyy') and installment_type ='Quarterly';
				select nextval('SEQ_EG_DEMAND') into v_newdemandid;
				insert into eg_demand (id, id_installment, base_demand, is_history, create_date, modified_date, amt_collected, status, min_amt_payable, amt_rebate) values (v_newdemandid, v_id_installment, 0, 'N', now(), now(),0, null, null, 0 );
                       end if;


			--creating new egwtr_demand_connection for new demand.
		 	
			SELECT nextval('seq_egwtr_demand_connection') INTO v_newConnDemand;
		 	insert into egwtr_demand_connection (id,demand, connectiondetails,createdby,createddate,lastmodifieddate,lastmodifiedby,version) values (v_newConnDemand,v_newdemandid,in_idconndetail,1,now(),now(),1,0);
			v_temp := wtms_demand_detail_generation_for_consumer_code(v_demandAmountfromWtRate, v_olddemandid,v_newdemandid, in_new_1stinstid, in_new_1stinstid, in_new_2ndinstid);
	    	
		 	else
			raise notice 'rollover : Water rates and current year installemnts amount are equal  for this connection so No demand generation (% % % )',in_idconndetail,v_firstinstallmentAmount1,v_demandAmountfromWtRate;
        	end if;
        	else
        	raise notice 'No Water Rates present so No demand generation';
        end if;
	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;


-------------------------------------------------------


CREATE OR REPLACE FUNCTION wtms_demand_detail_generation_for_consumer_code(v_demandAmountfromWtRate double precision,in_olddemandid bigint, in_newdemandid bigint, in_oldinstid bigint, in_new_1stinstid bigint, in_new_2ndinstid bigint)
RETURNS numeric AS
$BODY$
DECLARE
v_demandreason_1instalment bigint;
v_demandreason_2instalment bigint;
v_demandreason_3instalment bigint;
v_demandreason_4instalment bigint;
v_demandreason_oldinstalment bigint;
v_demandreason_1_old_instalment bigint;
v_demandreason_2_old_instalment bigint;
advnc_demand_reason bigint;
v_ddfirsthalf bigint;
v_ddsecondhalf bigint;
v_ddthirdhalf bigint;
v_ddfourthhalf bigint;
v_advnc_installment bigint;
v_oldddamount double precision;
v_advancedemandamountcollected double precision;
v_firstinstallmentAmountCollected double precision;
v_secondinstallmentAmountCoolected double precision;
v_advancedemanddetailid bigint;
v_differencedemandAmount double precision;
v_advancedemandamountcollected1 double precision;
v_advancedemandamountcollected2 double precision;
in_new_1stinstidnew bigint;
in_new_2ndinstidnew bigint;
in_new_3rdinstidnew bigint;
in_new_4thinstidnew bigint;
v_diffamount double precision;
v_differenceseconddemandAmount double precision;
BEGIN

--select id into v_demandreason_1_old_instalment from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='WTAXCHARGES') and id_installment=in_new_1stinstid;
--select id into v_demandreason_2_old_instalment from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='WTAXCHARGES') and id_installment=in_new_2ndinstid;

select id into in_new_1stinstidnew from eg_installment_master where id_module=(select id from eg_module where name = 'Water Tax Management') and start_date=to_date('01/04/2018', 'dd/MM/yyyy') and installment_type ='Quarterly';
select id into in_new_2ndinstidnew from eg_installment_master where id_module=(select id from eg_module where name = 'Water Tax Management') and start_date=to_date('01/07/2018', 'dd/MM/yyyy') and installment_type ='Quarterly';
select id into in_new_3rdinstidnew from eg_installment_master where id_module=(select id from eg_module where name = 'Water Tax Management') and start_date=to_date('01/10/2018', 'dd/MM/yyyy') and installment_type ='Quarterly';
select id into in_new_4thinstidnew from eg_installment_master where id_module=(select id from eg_module where name = 'Water Tax Management') and start_date=to_date('01/01/2019', 'dd/MM/yyyy') and installment_type ='Quarterly';

select id into v_demandreason_1instalment from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='WTAXCHARGES') and id_installment=in_new_1stinstidnew;

select id into v_demandreason_2instalment from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='WTAXCHARGES') and id_installment=in_new_2ndinstidnew;

select id into v_demandreason_3instalment from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='WTAXCHARGES') and id_installment=in_new_3rdinstidnew;

select id into v_demandreason_4instalment from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='WTAXCHARGES') and id_installment=in_new_4thinstidnew;


	
select amount into v_oldddAmount from  eg_demand_details where id_demand=in_olddemandid and id_demand_reason=v_demandreason_oldinstalment;


--Ist demand creation
if(v_demandAmountfromWtRate > 0) then 
SELECT nextval('seq_eg_demand_details') INTO v_ddfirsthalf;
insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no,remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (v_ddfirsthalf, in_newdemandid, v_demandreason_1instalment, null, null, null,v_demandAmountfromWtRate, now(),now(), 0, 0);
end if;

--2nd demand creation
--if(v_demandAmountfromWtRate > 0  ) then

--SELECT nextval('seq_eg_demand_details') INTO v_ddsecondhalf;

	
	--insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no, remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (v_ddsecondhalf, in_newdemandid, v_demandreason_2instalment, null, null, null,v_demandAmountfromWtRate, now(), now(), 0, 0);
--end if;

--3rd demand creation
--if(v_demandAmountfromWtRate > 0  ) then

--SELECT nextval('seq_eg_demand_details') INTO v_ddthirdhalf;

	
	--insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no, remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (v_ddthirdhalf, in_newdemandid, v_demandreason_3instalment, null, null, null,v_demandAmountfromWtRate, now(), now(), 0, 0);
--end if;

--4th demand creation
--if(v_demandAmountfromWtRate > 0  ) then

--SELECT nextval('seq_eg_demand_details') INTO v_ddfourthhalf;
	--insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no, remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (v_ddfourthhalf, in_newdemandid, v_demandreason_4instalment, null, null, null,v_demandAmountfromWtRate, now(), now(), 0, 0);
--end if;


 update eg_demand set base_demand= base_demand+(v_demandAmountfromWtRate) ,id_installment = in_new_1stinstidnew  where id=in_newdemandid;
	raise notice '2nd half demand detail created with water rate';

return 1;
END;
$BODY$ LANGUAGE plpgsql;
--------------------------------------------------------


CREATE OR REPLACE FUNCTION wtms_rates_by_connectiondetails_id(conn_detail_id bigint)
RETURNS numeric AS
$BODY$
DECLARE
rates record;
v_diff integer default 0;
v_temprate numeric default 0;
v_rate numeric;
v_billingtype varchar(16);
v_billamount numeric;
v_connectiontype varchar(16);
v_plotsize numeric;
v_numberoftaps numeric;
v_usagetype bigint;
v_ratetype varchar(16);
BEGIN


	select billingType,billAmount,connectionType,plotSize,nooftaps,usageType into v_billingtype,v_billamount,v_connectiontype,v_plotsize,v_numberoftaps,v_usagetype from egwtr_connectiondetails where id = conn_detail_id;

	if(v_billingtype is not null and v_billingtype = 'CUSTOM') then 
		v_rate = v_billamount;
	else 
		if(v_connectiontype is not null and v_connectiontype = 'NON_METERED') then
			select value into v_ratetype from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Water Tax Management') and key_name = 'TAX_RATETYPE'); 

			if(v_ratetype is not null and v_ratetype = 'PLOT_BASED' and v_plotsize is null) then
				v_ratetype = 'FIXED';
			end if;

			if(v_ratetype is not null and v_ratetype = 'TAP_BASED' and v_numberoftaps is null) then
				v_ratetype = 'FIXED';
			end if;

			if(v_ratetype is not null and v_ratetype = 'PLOT_BASED') then
				v_numberoftaps = null;
			end if;

			if(v_ratetype is not null and v_ratetype = 'TAP_BASED') then
				v_plotsize = null;
			end if;

			if(v_ratetype is not null and v_ratetype = 'FIXED') then
				v_numberoftaps = null;
				v_plotsize = null;
			end if;

			if(v_ratetype is not null and v_ratetype = 'PLOT_BASED') then
				select rateAmount into v_rate from egwtr_watercharge_rates where usagetype = v_usagetype and ratetype = v_ratetype and effectiveFromDate<=now() and effectiveToDate>=now() and ((fromPlotArea<= v_plotsize and toPlotArea >= v_plotsize) or (fromPlotArea<= v_plotsize and toPlotArea is null));
			end if;

			if(v_ratetype is not null and v_ratetype = 'FIXED') then
				select fixedCharges into v_rate from egwtr_watercharge_rates where usagetype = v_usagetype and ratetype = v_ratetype and effectiveFromDate<=now() and effectiveToDate>=now() ;
			end if;


			if(v_ratetype is not null and v_ratetype = 'TAP_BASED') then
				for rates in (select fromNoOfTaps,toNoOfTaps,rateAmount from egwtr_watercharge_rates where usagetype = v_usagetype and ratetype = v_ratetype and effectiveFromDate<=now() and effectiveToDate>=now())
				loop
					begin
						if(rates.fromNoOfTaps is not null and rates.fromNoOfTaps <= v_numberoftaps and rates.toNoOfTaps is not null and rates.toNoOfTaps <= v_numberoftaps) then
							v_diff = ( rates.toNoOfTaps - rates.fromNoOfTaps) + 1;
							v_temprate = v_temprate + (v_diff * rates.rateAmount);
						end if;
					
						if(rates.fromNoOfTaps is not null and rates.fromNoOfTaps <= v_numberoftaps and rates.toNoOfTaps is not null and rates.toNoOfTaps > v_numberoftaps) then
							v_diff = ( v_numberoftaps - rates.fromNoOfTaps) + 1;
							v_temprate = v_temprate + (v_diff * rates.rateAmount);
						end if;

						if(rates.fromNoOfTaps is not null and rates.fromNoOfTaps <= v_numberoftaps and rates.toNoOfTaps is null) then
							v_diff = ( v_numberoftaps - rates.fromNoOfTaps) + 1;
							v_temprate = v_temprate + (v_diff * rates.rateAmount);
						end if;
					end;
				end loop;
				v_rate = v_temprate;
			end if;


		end if;
	end if;
	return v_rate;
END;
$BODY$ LANGUAGE plpgsql;
