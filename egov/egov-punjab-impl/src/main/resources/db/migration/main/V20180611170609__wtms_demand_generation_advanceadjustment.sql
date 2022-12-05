CREATE OR REPLACE FUNCTION wtms_demand_genaration_for_non_metered_connections(batch_name varchar,boundary_type varchar,curr_installment_description varchar)
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
	select id, start_date, start_date - INTERVAL '1 SECOND' into v_curr_inst_id, v_curr_inst_start_date, v_prev_inst_end_date from eg_installment_master where id_module=(select id from eg_module where name = 'Water Tax Management') and description=curr_installment_description and installment_type ='Quarterly';

	select id into v_curr_inst_id_temp from eg_installment_master where id_module=(select id from eg_module where name = 'Water Tax Management') and start_date <= now() and end_date >= now() and installment_type ='Quarterly';

	select id into v_prev_inst_id from eg_installment_master where id_module=(select id from eg_module where name = 'Water Tax Management') and end_date = v_prev_inst_end_date and installment_type ='Quarterly';

	raise notice 'wtms_demand_genaration_for_non_metered_connections % % % % %', v_curr_inst_id, v_curr_inst_start_date, v_prev_inst_end_date, v_curr_inst_id_temp, v_prev_inst_id;
	if(v_curr_inst_id != v_curr_inst_id_temp) then
	raise notice 'wtms_demand_genaration_for_non_metered_connections inside if';
	for props in (select id,name from eg_boundary where id in (select boundary from egwtr_billgeneration where batchName=batch_name and boundaryType=boundary_type))
	loop 
		begin
			raise notice 'Started demand generation for location: %',props.name;
			v_temp  := wtms_demand_genaration_for_non_metered_connections_for_boundary(boundary_type, props.id, v_curr_inst_id, v_prev_inst_id);
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

CREATE OR REPLACE FUNCTION wtms_demand_genaration_for_non_metered_connections_for_boundary(boundary_type varchar, in_location_id bigint, in_curr_inst_id bigint, in_prev_inst_id bigint)
RETURNS numeric AS
$BODY$
DECLARE
props record;
v_temp integer;
v_curr_inst_end_date date;
BEGIN

	select end_date into v_curr_inst_end_date from eg_installment_master where id = in_curr_inst_id;
	raise notice 'wtms_demand_genaration_for_non_metered_connections_for_boundary %',v_curr_inst_end_date;

	if(boundary_type is not null and boundary_type = 'Locality') then 
		for props in (select distinct conn.consumercode, conndet.id from egwtr_connection conn, egwtr_connectiondetails conndet, egw_status status where conn.id=conndet.connection and conn.locality=in_location_id and conndet.connectionstatus='ACTIVE' and conndet.connectiontype='NON_METERED' and conndet.statusid=status.id and status.moduletype='WATERTAXAPPLICATION' and status.code='SANCTIONED' and conndet.executiondate<=v_curr_inst_end_date)
		loop 
			begin
				raise notice 'Started demand generation for consumercode: %',props.consumercode;
				v_temp  := wtms_demand_generation_for_consumer_code(props.consumercode,props.id, in_curr_inst_id, in_prev_inst_id);
				raise notice 'Done demand generation for consumercode: %',props.consumercode;
			exception
			when others then
				raise notice 'Error in demand generation for consumercode: % % %',props.consumercode,SQLERRM, SQLSTATE;
			end;
		end loop;
	end if;

	if(boundary_type is not null and boundary_type = 'Block') then 
		for props in (select distinct conn.consumercode,conndet.id  from egwtr_connection conn,egwtr_connectiondetails conndet, egw_status status where conn.id=conndet.connection and conn.block=in_location_id and  conndet.connectionstatus='ACTIVE' and conndet.connectiontype='NON_METERED' and conndet.statusid=status.id and status.moduletype='WATERTAXAPPLICATION' and status.code='SANCTIONED' and conndet.executiondate<=v_curr_inst_end_date)
		loop 
			begin
				raise notice 'Started demand generation for consumercode: %',props.consumercode;
				v_temp  := wtms_demand_generation_for_consumer_code(props.consumercode,props.id, in_curr_inst_id, in_prev_inst_id);
				raise notice 'Done demand generation for consumercode: %',props.consumercode;
			exception
			when others then
				raise notice 'Error in demand generation for consumercode: % % %',props.consumercode,SQLERRM, SQLSTATE;
			end;
		end loop;
	end if;

	raise notice 'wtms demand generation completed for boundary: % and boundary type: %', in_location_id, boundary_type;
	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION wtms_demand_generation_for_consumer_code(in_consumer_code varchar,in_idconndetail bigint, in_curr_inst_id bigint, in_prev_inst_id bigint)
RETURNS numeric AS
$BODY$
DECLARE
v_olddemandid bigint;
v_newdemandid bigint;
v_currdemandid bigint;
v_temp integer;
v_demandAmountfromWtRate double precision;
v_curr_instl_end_date date;
v_prev_bill_id bigint;
v_instdiffinsecs bigint;
v_connlatestinstid bigint;

BEGIN
 
	raise notice 'wtms_demand_generation_for_consumer_code, in_consumer_code, in_idconndetail, in_curr_inst_id, in_prev_inst_id % % % %',in_consumer_code, in_idconndetail, in_curr_inst_id, in_prev_inst_id;
	
	--validation for sequence of billing cycles starts
	select inst.id into v_connlatestinstid from eg_demand d, egwtr_demand_connection dc, eg_installment_master inst where dc.connectiondetails=in_idconndetail and dc.demand=d.id and inst.id=d.id_installment order by inst.start_date desc limit 1;
	select abs(extract(epoch from (currinst.start_date-previnst.end_date))) into v_instdiffinsecs from eg_installment_master previnst, eg_installment_master currinst where previnst.id=v_connlatestinstid and currinst.id=in_curr_inst_id;

	if(v_instdiffinsecs>1)then
		raise notice 'The difference between end date of previous billing cycle and start date of current billing cycle provide is (in secs) %',v_instdiffinsecs;
		raise exception 'Demand generation is not allowed as the billing cycles are not in sequencial order';
	end if;
	--validation for sequence of billing cycles ends

	select d.id into v_olddemandid from eg_demand d, egwtr_demand_connection dc where dc.connectiondetails=in_idconndetail and dc.demand=d.id and d.id_installment=in_prev_inst_id;
	select d.id into v_currdemandid from eg_demand d, egwtr_demand_connection dc where dc.connectiondetails=in_idconndetail and dc.demand=d.id and d.id_installment=in_curr_inst_id;
	select b.id into v_prev_bill_id from eg_bill b where b.id_demand = v_olddemandid and is_cancelled='N';

	raise notice 'wtms_demand_generation_for_consumer_code,  v_olddemandid, v_currdemandid, v_prev_bill_id % % %',v_olddemandid, v_currdemandid, v_prev_bill_id;

	if(v_currdemandid is null) then
		if(v_olddemandid is not null) then
			raise notice 'wtms_demand_generation_for_consumer_code, v_olddemandid is not null';
			select end_date into v_curr_instl_end_date from eg_installment_master where id = in_curr_inst_id;
			raise notice 'wtms_demand_generation_for_consumer_code, v_curr_instl_end_date % ', v_curr_instl_end_date;
			select wtms_rates_by_connectiondetails_id(in_idconndetail,v_curr_instl_end_date) into v_demandAmountfromWtRate;

			raise notice 'Rate:% for consumercode: %',v_demandAmountfromWtRate,in_consumer_code;

			if(v_demandAmountfromWtRate is not null and v_demandAmountfromWtRate > 0) then

				select nextval('SEQ_EG_DEMAND') into v_newdemandid;

				if (v_olddemandid IS NOT NULL) then 
					raise notice 'eg_demand created from old demand for consumercode: %',in_consumer_code;
					insert into eg_demand (id, id_installment, base_demand, is_history, create_date, modified_date, amt_collected, status, min_amt_payable, amt_rebate) select v_newdemandid, in_curr_inst_id, base_demand, is_history, now(), now(),amt_collected, status, null, 0 from eg_demand where id = v_olddemandid;
					--copying old demand_demand_details to new eg_demand.
					raise notice 'wtms_demand_generation_for_consumer_code, copying old demand_demand_details to new eg_demand.';
					insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no, remarks, amount, modified_date, create_date, amt_collected, amt_rebate) select nextval('seq_eg_demand_details'), v_newdemandid, id_demand_reason, id_status, file_reference_no, remarks, amount, modified_date, create_date, amt_collected, amt_rebate from eg_demand_details where id_demand = v_olddemandid and id_demand_reason not in (select id from eg_demand_reason where id_demand_reason_master = (select id from eg_demand_reason_master where code = 'WTADVANCE'));
					raise notice 'copied old demand details to new eg_demand for consumer code: %',in_consumer_code;
			
					update eg_demand set is_history='Y' where id=v_olddemandid;
				else
			 		raise notice 'eg_demand created for consumercode: %',in_consumer_code;
					insert into eg_demand (id, id_installment, base_demand, is_history, create_date, modified_date, amt_collected, status, min_amt_payable, amt_rebate) values (v_newdemandid, in_curr_inst_id, 0, 'N', now(), now(),0, null, null, 0 );
			
				end if;

				insert into egwtr_demand_connection (id,demand, connectiondetails,createdby,createddate,lastmodifieddate,lastmodifiedby,version) values (nextval('seq_egwtr_demand_connection'),v_newdemandid,in_idconndetail,1,now(),now(),1,0);

		 		raise notice 'egwtr_demand_connection created for consumercode: %',in_consumer_code;

				v_temp := wtms_demand_detail_generation_for_consumer_code(v_demandAmountfromWtRate, v_olddemandid,v_newdemandid, in_curr_inst_id, in_prev_inst_id);
	
			else
				raise notice 'No Water Rates present for cousumer code: %',in_consumer_code ;
			end if;
		else
			raise notice 'Bill is not generated for previous billing cycle: %',in_consumer_code ;
		end if;
	else
		raise notice 'Demand is already generated for given billing cycle: %',in_consumer_code ;
	end if;

	if(v_newdemandid is not null) then
		v_temp := wtms_serveadvance(v_olddemandid, v_newdemandid, in_curr_inst_id);
	end if;

	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION wtms_demand_detail_generation_for_consumer_code(v_demandAmountfromWtRate double precision,in_olddemandid bigint, in_newdemandid bigint, in_curr_inst_id bigint, in_prev_inst_id bigint)
RETURNS numeric AS
$BODY$
DECLARE
v_demand_reason_id bigint;
BEGIN
	select id into v_demand_reason_id from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='WTAXCHARGES') and id_installment=in_curr_inst_id;

	if(v_demandAmountfromWtRate > 0) then 
		insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no,remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (nextval('seq_eg_demand_details'), in_newdemandid, v_demand_reason_id, null, null, null,v_demandAmountfromWtRate, now(),now(), 0, 0);
		raise notice 'eg_demand_details created for same consumer code ';
	end if;

 	update eg_demand set base_demand= base_demand+(v_demandAmountfromWtRate) where id=in_newdemandid;
	raise notice 'Updated base demand for same consumer code';

return 1;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION wtms_rates_by_connectiondetails_id(conn_detail_id bigint,in_curr_instl_end_date date)
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

	select billingType, billAmount, connectionType, plotSize, nooftaps, usageType into v_billingtype, v_billamount, v_connectiontype, v_plotsize, v_numberoftaps, v_usagetype from egwtr_connectiondetails where id = conn_detail_id;

	if(v_billingtype is not null and v_billingtype = 'CUSTOM') then 
		v_rate = v_billamount;
	else 
		if(v_connectiontype is not null and v_connectiontype = 'NON_METERED') then
			select value into v_ratetype from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Water Tax Management') and key_name = 'TAX_RATETYPE');
	
			raise notice 'Rate type from app conf is  %',v_ratetype;
			raise notice 'Input plot size: %, number of taps: %',v_plotsize,v_numberoftaps;

			if(v_ratetype is not null and v_ratetype = 'PLOT_BASED' and (v_plotsize is null or v_plotsize = 0)) then
				v_ratetype := 'FIXED';
			end if;

			if(v_ratetype is not null and v_ratetype = 'TAP_BASED' and (v_numberoftaps is null or v_numberoftaps = 0)) then
				v_ratetype := 'FIXED';
			end if;

			if(v_ratetype is not null and v_ratetype = 'PLOT_BASED') then
				v_numberoftaps := null;
			end if;

			if(v_ratetype is not null and v_ratetype = 'TAP_BASED') then
				v_plotsize := null;
			end if;

			if(v_ratetype is not null and v_ratetype = 'FIXED') then
				v_numberoftaps := null;
				v_plotsize := null;
			end if;

			if(v_ratetype is not null and v_ratetype = 'PLOT_BASED') then
				select rateAmount into v_rate from egwtr_watercharge_rates where usagetype = v_usagetype and ratetype = v_ratetype and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date and ((fromPlotArea<= v_plotsize and toPlotArea >= v_plotsize) or (fromPlotArea<= v_plotsize and toPlotArea is null));
				raise notice 'Got data from rates master by plot based is:%',v_rate;
			end if;

			if(v_ratetype is not null and v_ratetype = 'FIXED') then
				select fixedCharges into v_rate from egwtr_watercharge_rates where usagetype = v_usagetype and ratetype = v_ratetype and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date ;
				raise notice 'Got data from rates master by fixed is:%',v_rate;
			end if;

			if(v_ratetype is not null and v_ratetype = 'TAP_BASED') then
				for rates in (select fromNoOfTaps,toNoOfTaps,rateAmount from egwtr_watercharge_rates where usagetype = v_usagetype and ratetype = v_ratetype and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date)
				loop
					begin
						if(rates.fromNoOfTaps is not null and rates.fromNoOfTaps <= v_numberoftaps and rates.toNoOfTaps is not null and rates.toNoOfTaps <= v_numberoftaps) then
							v_diff := ( rates.toNoOfTaps - rates.fromNoOfTaps) + 1;
							v_temprate := v_temprate + (v_diff * rates.rateAmount);
						end if;
					
						if(rates.fromNoOfTaps is not null and rates.fromNoOfTaps <= v_numberoftaps and rates.toNoOfTaps is not null and rates.toNoOfTaps > v_numberoftaps) then
							v_diff := ( v_numberoftaps - rates.fromNoOfTaps) + 1;
							v_temprate := v_temprate + (v_diff * rates.rateAmount);
						end if;

						if(rates.fromNoOfTaps is not null and rates.fromNoOfTaps <= v_numberoftaps and rates.toNoOfTaps is null) then
							v_diff := ( v_numberoftaps - rates.fromNoOfTaps) + 1;
							v_temprate := v_temprate + (v_diff * rates.rateAmount);
						end if;
					end;
				end loop;
				v_rate := v_temprate;
				raise notice 'Got data from rates master by tap based is:%',v_rate;
			end if;
		end if;
	end if;
	return v_rate;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION wtms_serveadvance(in_olddemandid bigint, in_newdemandid bigint, in_currinstid bigint)
RETURNS numeric AS
$BODY$
DECLARE
demanddets record;
v_ddid 			integer;
v_tax 			double precision;
v_collection 	double precision;
v_balance 		double precision;
v_advancecoll 	double precision;
v_temp 			integer;
BEGIN
	raise notice 'wtms_serveadvance : in_olddemandid, in_newdemandid (% %)', in_olddemandid, in_newdemandid;
	select dd.amt_collected into v_advancecoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=in_olddemandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id and drm.code='WTADVANCE';
	raise notice 'wtms_serveadvance : v_advancecoll (%)', v_advancecoll;

	if (v_advancecoll>0) then
	  for demanddets in (select dd.id ddid, dd.amount, dd.amt_collected from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm, eg_installment_master inst where dd.id_demand=in_newdemandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id and dr.id_installment=inst.id and drm.code!='WTADVANCE' and (dd.amount-dd.amt_collected)>0 order by inst.start_date, drm."order")
	    loop 
		  v_ddid := demanddets.ddid;
		  v_tax := demanddets.amount;
		  v_collection := demanddets.amt_collected;
		  v_balance := v_tax-v_collection;
		  --raise notice 'wtms_serveadvance : v_ddid, v_tax, v_collection, v_balance (% % % %)', v_ddid, v_tax, v_collection, v_balance;
		  begin
			  raise notice 'wtms_serveadvance : inside loop start v_advancecoll (%)', v_advancecoll;
			  if(v_advancecoll=0)then
				  return v_temp; 
			  end if;
			  if(v_advancecoll>v_balance)then
				  update eg_demand_details set amt_collected=amt_collected+v_balance where id=v_ddid;
				  v_advancecoll := v_advancecoll - v_balance;
			  else
				  update eg_demand_details set amt_collected=amt_collected+v_advancecoll where id=v_ddid;
				  v_advancecoll := 0;
			  end if;
			  raise notice 'wtms_serveadvance : inside loop end v_advancecoll (%)', v_advancecoll;
		  EXCEPTION
		  WHEN OTHERS THEN
		  raise notice 'rolloverward : % %', SQLERRM, SQLSTATE;
		  END;
	    END LOOP;
	  if (v_advancecoll > 0) then
	    Insert into eg_demand_details (ID, ID_DEMAND, ID_DEMAND_REASON, ID_STATUS, FILE_REFERENCE_NO, REMARKS, AMOUNT, modified_date, create_date, AMT_COLLECTED, AMT_REBATE) 
	    values (nextval('seq_eg_demand_details'), in_newdemandid, (select id from eg_demand_reason where id_installment = in_currinstid and id_demand_reason_master = (select id from eg_demand_reason_master where code = 'WTADVANCE')), 1, null, null, 0, now(), now(), v_advancecoll,0);
	  end if;
	end if;
	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;
