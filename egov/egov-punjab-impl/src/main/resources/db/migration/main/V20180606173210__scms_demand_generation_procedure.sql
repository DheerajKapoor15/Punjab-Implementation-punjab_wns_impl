CREATE OR REPLACE FUNCTION stms_demand_genaration(batch_name varchar,boundary_type varchar,curr_installment_description varchar)
RETURNS void AS
$BODY$
DECLARE
props record;
v_temp bigint;
v_curr_inst_id bigint;
v_prev_inst_id bigint;
v_curr_inst_id_temp bigint;
v_curr_inst_start_date timestamp without time zone;
v_prev_inst_end_date timestamp without time zone;

BEGIN
	select id, start_date, start_date - INTERVAL '1 SECOND' into v_curr_inst_id, v_curr_inst_start_date, v_prev_inst_end_date from eg_installment_master where id_module=(select id from eg_module where name = 'Sewerage Tax Management') and description=curr_installment_description and installment_type ='Quarterly';

	select id into v_curr_inst_id_temp from eg_installment_master where id_module=(select id from eg_module where name = 'Sewerage Tax Management') and start_date <= now() and end_date >= now() and installment_type ='Quarterly';

	select id into v_prev_inst_id from eg_installment_master where id_module=(select id from eg_module where name = 'Sewerage Tax Management') and end_date = v_prev_inst_end_date and installment_type ='Quarterly';

	raise notice 'stms_demand_genaration % % % % %', v_curr_inst_id, v_curr_inst_start_date, v_prev_inst_end_date, v_curr_inst_id_temp, v_prev_inst_id;
	if(v_curr_inst_id != v_curr_inst_id_temp) then
	raise notice 'stms_demand_genaration inside if';
	for props in (select id,name from eg_boundary where id in (select boundary from egswtax_billgeneration where batchName=batch_name and boundaryType=boundary_type))
	loop 
		begin
			raise notice 'Started demand generation for location: %',props.name;
			v_temp  := stms_demand_genaration_for_boundary(boundary_type, props.id, v_curr_inst_id, v_prev_inst_id);
			raise notice 'Done demand generation for location: %',props.name;
		exception
		when others then
		raise notice 'Error in demand generation for ulb % % %',props.name,SQLERRM, SQLSTATE;
		end;
	end loop;
		
	else
		raise notice 'Given installment % is current installment so we cannot process',curr_installment_description;
	end if;
	
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION stms_demand_genaration_for_boundary(boundary_type varchar, in_boundary bigint, in_curr_inst_id bigint, in_prev_inst_id bigint)
RETURNS numeric AS
$BODY$
DECLARE
props record;
v_temp integer;
v_curr_inst_end_date date;
BEGIN

	select end_date into v_curr_inst_end_date from eg_installment_master where id = in_curr_inst_id;
	raise notice 'stms_demand_genaration_for_boundary %',v_curr_inst_end_date;

	if(boundary_type is not null and boundary_type = 'Locality') then 
		for props in (select distinct conn.shsc_number, appdet.id as appdetid from egswtax_connection conn, egswtax_connectiondetail conndet, egswtax_applicationdetails appdet, egw_status status WHERE conn.id=appdet.connection and conndet.id=appdet.connectiondetail and conn.status='ACTIVE' and appdet.status=status.id and status.moduletype='SEWERAGETAXAPPLICATION' and status.code='SANCTIONED' and conn.locality = in_boundary)
		loop 
			begin
				raise notice 'Started demand generation for shsc_number: %',props.shsc_number;
				v_temp  := stms_demand_generation_for_consumer_code(props.shsc_number, props.appdetid, in_curr_inst_id, in_prev_inst_id);
				raise notice 'Done demand generation for shsc_number: %',props.shsc_number;
			exception
			when others then
				raise notice 'Error in demand generation for shsc_number: % % %',props.shsc_number, SQLERRM, SQLSTATE;
			end;
		end loop;
	end if;

	if(boundary_type is not null and boundary_type = 'Block') then 
		for props in (select distinct conn.shsc_number, appdet.id as appdetid from egswtax_connection conn, egswtax_connectiondetail conndet, egswtax_applicationdetails appdet, egw_status status WHERE conn.id=appdet.connection and conndet.id=appdet.connectiondetail and conn.status='ACTIVE' and appdet.status=status.id and status.moduletype='SEWERAGETAXAPPLICATION' and status.code='SANCTIONED' and conn.block = in_boundary)
		loop 
			begin
				raise notice 'Started demand generation for shsc_number: %',props.shsc_number;
				v_temp  := stms_demand_generation_for_consumer_code(props.shsc_number, props.appdetid, in_curr_inst_id, in_prev_inst_id);
				raise notice 'Done demand generation for shsc_number: %',props.shsc_number;
			exception
			when others then
				raise notice 'Error in demand generation for shsc_number: % % %', props.shsc_number, SQLERRM, SQLSTATE;
			end;
		end loop;
	end if;

	raise notice 'wtms demand generation completed for boundary: % and boundary type: %', in_boundary, boundary_type;
	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION stms_demand_generation_for_consumer_code(in_consumercode varchar, in_idappdetail bigint, in_curr_inst_id bigint, in_prev_inst_id bigint)
RETURNS numeric AS
$BODY$
DECLARE
v_olddemandid bigint;
v_newdemandid bigint;
v_currdemandid bigint;
v_temp integer;
v_demandAmountfromSWRate double precision;
v_curr_instl_end_date date;
v_prev_bill_id bigint;
v_instdiffinsecs bigint;
v_latestinststartdate timestamp without time zone;

BEGIN
 
	raise notice 'stms_demand_generation_for_consumer_code, in_consumercode, in_idappdetail, in_curr_inst_id, in_prev_inst_id % % % %',in_consumercode, in_idappdetail, in_curr_inst_id, in_prev_inst_id;
	
	--validation for sequence of billing cycles starts
	select max(inst.start_date) into v_latestinststartdate from eg_demand d, egswtax_demand_connection dc, eg_installment_master inst where dc.applicationdetail=in_idappdetail and dc.demand=d.id and inst.id=d.id_installment;
	select abs(extract(epoch from (currinst.start_date-previnst.end_date))) into v_instdiffinsecs from eg_installment_master previnst, eg_installment_master currinst where previnst.start_date=v_latestinststartdate and previnst.id_module=(select id from eg_module where name = 'Sewerage Tax Management') and currinst.id=in_curr_inst_id;

	if(v_instdiffinsecs>1)then
		raise notice 'The difference between end date of previous billing cycle and start date of current billing cycle provide is (in secs) %',v_instdiffinsecs;
		raise exception 'Demand generation is not allowed as the billing cycles are not in sequencial order';
	end if;
	--validation for sequence of billing cycles ends

	select d.id into v_olddemandid from eg_demand d, egswtax_demand_connection dc where dc.applicationdetail=in_idappdetail and dc.demand=d.id and d.id_installment=in_prev_inst_id;
	select d.id into v_currdemandid from eg_demand d, egswtax_demand_connection dc where dc.applicationdetail=in_idappdetail and dc.demand=d.id and d.id_installment=in_curr_inst_id;
	select b.id into v_prev_bill_id from eg_bill b where b.id_demand = v_olddemandid and is_cancelled='N';

	raise notice 'stms_demand_generation_for_consumer_code,  v_olddemandid, v_currdemandid, v_prev_bill_id % % %',v_olddemandid, v_currdemandid, v_prev_bill_id;

	if(v_currdemandid is null) then
			raise notice 'stms_demand_generation_for_consumer_code, v_olddemandid is null';
			select end_date into v_curr_instl_end_date from eg_installment_master where id = in_curr_inst_id;
			raise notice 'stms_demand_generation_for_consumer_code, v_curr_instl_end_date % ', v_curr_instl_end_date;
			select stms_rates_by_connectiondetails_id(in_idappdetail, v_curr_instl_end_date) into v_demandAmountfromSWRate;

			raise notice 'Rate:% for consumercode: %',v_demandAmountfromSWRate,in_consumercode;

			if(v_demandAmountfromSWRate is not null and v_demandAmountfromSWRate > 0) then

				select nextval('SEQ_EG_DEMAND') into v_newdemandid;

				if (v_olddemandid IS NOT NULL) then 
					raise notice 'eg_demand created from old demand for consumercode: %',in_consumercode;
					insert into eg_demand (id, id_installment, base_demand, is_history, create_date, modified_date, amt_collected, status, min_amt_payable, amt_rebate) select v_newdemandid, in_curr_inst_id, base_demand, is_history, now(), now(),amt_collected, status, null, 0 from eg_demand where id = v_olddemandid;
					--copying old demand_demand_details to new eg_demand.
					raise notice 'stms_demand_generation_for_consumer_code, copying old demand_demand_details to new eg_demand.';
					insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no, remarks, amount, modified_date,
				create_date, amt_collected, amt_rebate) select nextval('seq_eg_demand_details'), v_newdemandid, id_demand_reason, id_status,
				file_reference_no, remarks, amount, modified_date, create_date, amt_collected, amt_rebate from eg_demand_details where id_demand = v_olddemandid;
					raise notice 'copied old demand details to new eg_demand for consumer code: %',in_consumercode;
			
					update eg_demand set is_history='Y' where id=v_olddemandid;
				else
			 		raise notice 'eg_demand created for consumercode: %',in_consumercode;
					insert into eg_demand (id, id_installment, base_demand, is_history, create_date, modified_date, amt_collected, status, min_amt_payable, amt_rebate) values (v_newdemandid, in_curr_inst_id, 0, 'N', now(), now(),0, null, null, 0 );
			
				end if;

				insert into egswtax_demand_connection (id,demand, applicationdetail, createdby, createddate, lastmodifieddate, lastmodifiedby, version) values (nextval('seq_egswtax_demand_connection'),v_newdemandid,in_idappdetail,1,now(),now(),1,0);

		 		raise notice 'egswtax_demand_connection created for consumercode: %',in_consumercode;

				v_temp := stms_demand_detail_generation_for_consumer_code(v_demandAmountfromSWRate, v_olddemandid,v_newdemandid, in_curr_inst_id, in_prev_inst_id);
	
			else
				raise notice 'No Water Rates present for cousumer code: %',in_consumercode ;
			end if;
	else
		raise notice 'Demand is already generated for given billing cycle: %',in_consumercode ;
	end if;

	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION stms_demand_detail_generation_for_consumer_code(v_demandAmountfromSWRate double precision,in_olddemandid bigint, in_newdemandid bigint, in_curr_inst_id bigint, in_prev_inst_id bigint)
RETURNS numeric AS
$BODY$
DECLARE
v_demand_reason_id bigint;
BEGIN
	select id into v_demand_reason_id from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='SEWERAGETAX') and id_installment=in_curr_inst_id;

	if(v_demandAmountfromSWRate > 0) then 
		insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no,remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (nextval('seq_eg_demand_details'), in_newdemandid, v_demand_reason_id, null, null, null,v_demandAmountfromSWRate, now(),now(), 0, 0);
		raise notice 'eg_demand_details created for same consumer code ';
	end if;

 	update eg_demand set base_demand= base_demand+(v_demandAmountfromSWRate) where id=in_newdemandid;
	raise notice 'Updated base demand for same consumer code';

return 1;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION stms_rates_by_connectiondetails_id(app_detail_id bigint, in_curr_instl_end_date date)
RETURNS numeric AS
$BODY$
DECLARE
rates record;
v_diff integer default 0;
v_temprate numeric default 0;
v_rate numeric;
v_billingtype varchar(16);
v_billamount numeric;
v_plotsize numeric;
v_numberofclosets numeric;
v_usagetype bigint;
v_ratetype varchar(16);
BEGIN

	raise notice 'stms_rates_by_connectiondetails_id : app_detail_id, in_curr_instl_end_date  % %',app_detail_id, in_curr_instl_end_date;
	select cd.billingType, cd.billAmount, cd.plotSize, cd.noofclosets_residential, cd.usageType into v_billingtype, v_billamount, v_plotsize, v_numberofclosets, v_usagetype from egswtax_connectiondetail cd, egswtax_applicationdetails app where app.connectiondetail=cd.id and app.id = app_detail_id;
	raise notice 'stms_rates_by_connectiondetails_id : v_billingtype, v_billamount, v_plotsize, v_numberofclosets, v_usagetype  % % % % %',v_billingtype, v_billamount, v_plotsize, v_numberofclosets, v_usagetype;
	if(v_billingtype is not null and v_billingtype = 'CUSTOM') then 
		v_rate = v_billamount;
	else 
		select value into v_ratetype from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Sewerage Tax Management') and key_name = 'TAX_RATETYPE');

		raise notice 'Rate type from app conf is  %',v_ratetype;
		raise notice 'Input plot size: %, number of taps: %',v_plotsize,v_numberofclosets;

		if(v_ratetype is not null and v_ratetype = 'PLOT_BASED' and (v_plotsize is null or v_plotsize = 0)) then
			v_ratetype := 'FIXED';
		end if;

		if(v_ratetype is not null and v_ratetype = 'SEAT_BASED' and (v_numberofclosets is null or v_numberofclosets = 0)) then
			v_ratetype := 'FIXED';
		end if;

		if(v_ratetype is not null and v_ratetype = 'PLOT_BASED') then
			v_numberofclosets := null;
		end if;

		if(v_ratetype is not null and v_ratetype = 'SEAT_BASED') then
			v_plotsize := null;
		end if;

		if(v_ratetype is not null and v_ratetype = 'FIXED') then
			v_numberofclosets := null;
			v_plotsize := null;
		end if;
		raise notice 'Finally v_ratetype is %',v_ratetype;
		if(v_ratetype is not null and v_ratetype = 'PLOT_BASED') then
			select rateAmount into v_rate from egswtax_seweragecharge_rates where usagetype = v_usagetype and ratetype = v_ratetype and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date and ((fromPlotArea<= v_plotsize and toPlotArea >= v_plotsize) or (fromPlotArea<= v_plotsize and toPlotArea is null));
			raise notice 'Got data from rates master by plot based is:%',v_rate;
		end if;

		if(v_ratetype is not null and v_ratetype = 'FIXED') then
			select fixedCharges into v_rate from egswtax_seweragecharge_rates where usagetype = v_usagetype and ratetype = v_ratetype and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date ;
			raise notice 'Got data from rates master by fixed is:%',v_rate;
		end if;

		if(v_ratetype is not null and v_ratetype = 'SEAT_BASED') then
			for rates in (select fromnoofseats, tonoofseats, rateAmount from egswtax_seweragecharge_rates where usagetype = v_usagetype and ratetype = v_ratetype and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date)
			loop
				begin
					if(rates.fromnoofseats is not null and rates.fromnoofseats <= v_numberofclosets and rates.tonoofseats is not null and rates.tonoofseats <= v_numberofclosets) then
						v_diff := ( rates.tonoofseats - rates.fromnoofseats) + 1;
						v_temprate := v_temprate + (v_diff * rates.rateAmount);
					end if;
				
					if(rates.fromnoofseats is not null and rates.fromnoofseats <= v_numberofclosets and rates.tonoofseats is not null and rates.tonoofseats > v_numberofclosets) then
						v_diff := ( v_numberofclosets - rates.fromnoofseats) + 1;
						v_temprate := v_temprate + (v_diff * rates.rateAmount);
					end if;

					if(rates.fromnoofseats is not null and rates.fromnoofseats <= v_numberofclosets and rates.tonoofseats is null) then
						v_diff := ( v_numberofclosets - rates.fromnoofseats) + 1;
						v_temprate := v_temprate + (v_diff * rates.rateAmount);
					end if;
				end;
			end loop;
			v_rate := v_temprate;
			raise notice 'Got data from rates master by tap based is:%',v_rate;
		end if;
	end if;
	return v_rate;
END;
$BODY$ LANGUAGE plpgsql;
