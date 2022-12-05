DROP FUNCTION wtms_demand_genaration_for_non_metered_connections_for_locality(bigint,bigint,bigint);
DROP FUNCTION wtms_demand_generation_for_consumer_code(bigint,bigint,bigint);

CREATE OR REPLACE FUNCTION wtms_demand_genaration_for_non_metered_connections(location varchar,curr_installment_description varchar)
RETURNS void AS
$BODY$
DECLARE
props record;
v_temp bigint;
v_curr_inst_id bigint;
v_prev_inst_id bigint;
v_curr_inst_id_temp bigint;
v_curr_inst_start_date date;
v_prev_inst_end_date date;

BEGIN
	
	select id,start_date,start_date - INTERVAL '1 DAY' into v_curr_inst_id,v_curr_inst_start_date,v_prev_inst_end_date from eg_installment_master where id_module=(select id from eg_module where name = 'Water Tax Management') and description=curr_installment_description and installment_type ='Quarterly';

	select id into v_curr_inst_id_temp from eg_installment_master where id_module=(select id from eg_module where name = 'Water Tax Management') and start_date <= now() and end_date >= now() and installment_type ='Quarterly';

	select id into v_prev_inst_id from eg_installment_master where id_module=(select id from eg_module where name = 'Water Tax Management') and end_date = v_prev_inst_end_date and installment_type ='Quarterly';

	if(v_curr_inst_id != v_curr_inst_id_temp) then

	for props in (select id,name from eg_boundary where id in (select distinct locality from egwtr_connection conn, egwtr_connectiondetails conndet, egw_status status where conn.id=conndet.connection and conndet.connectionstatus='ACTIVE' and conndet.connectiontype='NON_METERED' and conndet.statusid=status.id and status.moduletype='WATERTAXAPPLICATION' and status.code='SANCTIONED'))
	loop 
		begin
			v_temp  := wtms_demand_genaration_for_non_metered_connections_for_locality(props.id,v_curr_inst_id,v_prev_inst_id);
			
		exception
		when others then
		raise notice 'rolloverward For FULL ULB  % %',SQLERRM, SQLSTATE;
		end;
	end loop;
		
	else
		raise notice 'Given installment % is current installment so we cannot process',curr_installment_description;
	end if;
	
END;
$BODY$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION wtms_demand_genaration_for_non_metered_connections_for_locality(in_wardid bigint,in_curr_inst_id bigint,in_prev_inst_id bigint)
RETURNS numeric AS
$BODY$
DECLARE
props record;
v_temp integer;
BEGIN

	for props in (select distinct conn.consumercode,conndet.id  from egwtr_connection conn,egwtr_connectiondetails conndet, egw_status status where conn.id=conndet.connection and conn.locality=in_wardid and  conndet.connectionstatus='ACTIVE' and conndet.connectiontype='NON_METERED' and conndet.statusid=status.id and status.moduletype='WATERTAXAPPLICATION' and status.code='SANCTIONED')
	loop 
		begin
			v_temp  := wtms_demand_generation_for_consumer_code(props.id, in_curr_inst_id, in_prev_inst_id);
		exception
		when others then
		raise notice ' error......... rollover ward conndetId  and consumercode: % % % %',props.id,props.consumercode,SQLERRM, SQLSTATE;
		end;
	end loop;
	raise notice 'wtms demand generation completed for locality: (%)', in_wardid;
	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;


----------------------------------------


CREATE OR REPLACE FUNCTION wtms_demand_generation_for_consumer_code(in_idconndetail bigint, in_curr_inst_id bigint, in_prev_inst_id bigint)
RETURNS numeric AS
$BODY$
DECLARE
v_olddemandid bigint;
v_newdemandid bigint;
v_newConnDemand bigint;
v_temp integer;
v_demandAmountfromWtRate double precision;

BEGIN
	select d.id into v_olddemandid from eg_demand d where d.id_installment = in_prev_inst_id;

	select wtms_rates_by_connectiondetails_id(in_idconndetail) into v_demandAmountfromWtRate;

	if(v_demandAmountfromWtRate is not null) then

		select nextval('SEQ_EG_DEMAND') into v_newdemandid;

		if (v_olddemandid IS NOT NULL) then 
			insert into eg_demand (id, id_installment, base_demand, is_history, create_date, modified_date, amt_collected, status, min_amt_payable, amt_rebate) select v_newdemandid, in_curr_inst_id, base_demand, is_history, now(), now(),amt_collected, status, null, 0 from eg_demand where id = v_olddemandid;
			--copying old demand_demand_details to new eg_demand.
			
			insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no, remarks, amount, modified_date,
		create_date, amt_collected, amt_rebate) select nextval('seq_eg_demand_details'), v_newdemandid, id_demand_reason, id_status,
		file_reference_no, remarks, amount, modified_date, create_date, amt_collected, amt_rebate from eg_demand_details where id_demand = v_olddemandid;
			raise notice 'copied old demand demand details to new eg_demand of id(%)',v_newdemandid;
			
			--update eg_demand set is_history='Y' where id=v_olddemandid;
		else
		insert into eg_demand (id, id_installment, base_demand, is_history, create_date, modified_date, amt_collected, status, min_amt_payable, amt_rebate) values (v_newdemandid, in_curr_inst_id, 0, 'N', now(), now(),0, null, null, 0 );
			
		end if;

		select nextval('seq_egwtr_demand_connection') into v_newConnDemand;
		insert into egwtr_demand_connection (id,demand, connectiondetails,createdby,createddate,lastmodifieddate,lastmodifiedby,version) values (v_newConnDemand,v_newdemandid,in_idconndetail,1,now(),now(),1,0);
		v_temp := wtms_demand_detail_generation_for_consumer_code(v_demandAmountfromWtRate, v_olddemandid,v_newdemandid, in_curr_inst_id, in_prev_inst_id);
	
	else
        	raise notice 'No Water Rates present so No demand generation';
	end if;

	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;


-------------------------------------------------------


CREATE OR REPLACE FUNCTION wtms_demand_detail_generation_for_consumer_code(v_demandAmountfromWtRate double precision,in_olddemandid bigint, in_newdemandid bigint, in_curr_inst_id bigint, in_prev_inst_id bigint)
RETURNS numeric AS
$BODY$
DECLARE
v_demand_reason_id bigint;
v_demand_detail_id bigint;
BEGIN


	select id into v_demand_reason_id from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='WTAXCHARGES') and id_installment=in_curr_inst_id;

	
	if(v_demandAmountfromWtRate > 0) then 
		select nextval('seq_eg_demand_details') into v_demand_detail_id;
		insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no,remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (v_demand_detail_id, in_newdemandid, v_demand_reason_id, null, null, null,v_demandAmountfromWtRate, now(),now(), 0, 0);
	end if;


 	update eg_demand set base_demand= base_demand+(v_demandAmountfromWtRate) where id=in_newdemandid;

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
