DROP FUNCTION IF EXISTS wtms_demand_detail_generation_for_consumer_code(double precision,bigint,bigint,bigint,bigint,bigint);
DROP FUNCTION IF EXISTS wtms_meterrent(bigint,bigint,bigint,date);
DROP FUNCTION IF EXISTS wtms_demand_generation_for_consumer_code(bigint,varchar,bigint,bigint, bigint, bigint);
			
CREATE OR REPLACE FUNCTION wtms_demand_genaration(connection_type bigint, batch_name varchar,boundary_type varchar,curr_installment_description varchar, batch_id bigint)
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

	raise notice 'wtms_demand_genaration % % % % %', v_curr_inst_id, v_curr_inst_start_date, v_prev_inst_end_date, v_curr_inst_id_temp, v_prev_inst_id;
	if(v_curr_inst_id != v_curr_inst_id_temp) then
	raise notice 'wtms_demand_genaration inside if';
	for props in (select id,name from eg_boundary where id in (select boundary from egwtr_billgeneration where batchName=batch_name and boundaryType=boundary_type))
	loop 
		begin
			raise notice 'Started demand generation for location: %',props.name;
			v_temp  := wtms_demand_genaration_for_boundary(connection_type,boundary_type, props.id, v_curr_inst_id, v_prev_inst_id, batch_id);
			raise notice 'Done demand generation for location: %',props.name;
		exception
		when others then
		if (batch_id is null or batch_id = 0) then
			raise notice 'Error in demand generation for ulb % % %',props.name,SQLERRM, SQLSTATE;
		else
			insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby, errormessage) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, null, 'Failure', 'Error in demand generation for ulb ' || props.name, now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'), SQLERRM || ' ' || SQLSTATE);
		end if;
		end;
	end loop;
		
	else
		if (batch_id is null or batch_id = 0) then
			raise notice 'Given installment % is current installment',curr_installment_description;
		else
			insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, null, 'Failure', 'Given installment ' || curr_installment_description || ' is current installment', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
		end if;
	end if;
	
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION wtms_demand_genaration_for_boundary(connection_type bigint,boundary_type varchar, in_location_id bigint, in_curr_inst_id bigint, in_prev_inst_id bigint, batch_id bigint)
RETURNS numeric AS
$BODY$
DECLARE
props record;
v_temp integer;
v_curr_inst_end_date date;
BEGIN

	select end_date into v_curr_inst_end_date from eg_installment_master where id = in_curr_inst_id;
	raise notice 'wtms_demand_genaration_for_boundary %',v_curr_inst_end_date;

	if(boundary_type is not null and boundary_type = 'Locality') then 
		for props in (select distinct conn.consumercode, conndet.id from egwtr_connection conn, egwtr_connectiondetails conndet, egw_status status where conn.id=conndet.connection and conn.locality=in_location_id and conndet.connectionstatus='ACTIVE' and conndet.connectiontype=connection_type and conndet.statusid=status.id and status.moduletype='WATERTAXAPPLICATION' and status.code='SANCTIONED' and conndet.executiondate<=v_curr_inst_end_date)
		loop 
			begin
				raise notice 'Started demand generation for consumercode: %',props.consumercode;
				v_temp  := wtms_demand_generation_for_consumer_code(connection_type,props.consumercode,props.id, in_curr_inst_id, in_prev_inst_id, batch_id);
				raise notice 'Done demand generation for consumercode: %',props.consumercode;
			exception
			when others then
				if (batch_id is null or batch_id = 0) then
					raise notice 'Error in demand generation for consumer number: % % %',props.consumercode,SQLERRM, SQLSTATE;
				else
					insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby, errormessage) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, null, 'Failure', 'Error in demand generation for consumer number ' || props.consumercode || ' ' || SQLERRM || ' ' || SQLSTATE, now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'), SQLERRM || ' ' || SQLSTATE);
			end if;
			end;
		end loop;
	end if;

	if(boundary_type is not null and boundary_type = 'Block') then 
		for props in (select distinct conn.consumercode,conndet.id  from egwtr_connection conn,egwtr_connectiondetails conndet, egw_status status where conn.id=conndet.connection and conn.block=in_location_id and  conndet.connectionstatus='ACTIVE' and conndet.connectiontype=connection_type and conndet.statusid=status.id and status.moduletype='WATERTAXAPPLICATION' and status.code='SANCTIONED' and conndet.executiondate<=v_curr_inst_end_date)
		loop 
			begin
				raise notice 'Started demand generation for consumercode: %',props.consumercode;
				v_temp  := wtms_demand_generation_for_consumer_code(connection_type,props.consumercode,props.id, in_curr_inst_id, in_prev_inst_id, batch_id);
				raise notice 'Done demand generation for consumercode: %',props.consumercode;
			exception
			when others then
				if (batch_id is null or batch_id = 0) then
					raise notice 'Error in demand generation for consumer number: % % %',props.consumercode,SQLERRM, SQLSTATE;
				else
					insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby, errormessage) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, null, 'Failure', 'Error in demand generation for consumer number ' || props.consumercode, now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'), SQLERRM || ' ' || SQLSTATE);
			end if;
			end;
		end loop;
	end if;

	raise notice 'wtms demand generation completed for boundary: % and boundary type: %', in_location_id, boundary_type;
	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION wtms_demand_generation_for_consumer_code(connection_type bigint,in_consumer_code varchar,in_idconndetail bigint, in_curr_inst_id bigint, in_prev_inst_id bigint, batch_id bigint)
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
v_connectiontype bigint;
v_status boolean default true;
v_is_oldfirstdemand boolean default false;
v_firstdemandid bigint;
v_conn_date date;
v_curr_instl_start_date date;
v_days_btw_conn_date double precision;
v_days_btw_quarter double precision;
v_executiondate double precision;
v_curr_inst_todate double precision;
v_usagetype bigint;
v_connectiontypename varchar;
v_citycode varchar;
	BEGIN		
	select code into v_citycode from eg_city where active = true;
 
	raise notice 'wtms_demand_generation_for_consumer_code, connection_type ,in_consumer_code, in_idconndetail, in_curr_inst_id, in_prev_inst_id % % % % %',connection_type, in_consumer_code, in_idconndetail, in_curr_inst_id, in_prev_inst_id;
	
	select code into v_connectiontypename from egwtr_connection_type where id=connection_type;
	select usagetype into v_usagetype from egwtr_connectiondetails where connection = (select id from egwtr_connection where consumercode = in_consumer_code);
	select id into v_connectiontype from egwtr_connection_type where id = (select connectiontype from egwtr_connectiondetails where id = in_idconndetail);

	--validation for execution date validation starts
	select extract(epoch from executiondate) into v_executiondate from egwtr_connectiondetails where connection = (select id from egwtr_connection where consumercode = in_consumer_code);

	select extract(epoch from end_date) into v_curr_inst_todate from eg_installment_master where id = in_curr_inst_id;

	if (v_executiondate is null) then
		if (batch_id is null or batch_id = 0) then
			raise exception 'Connection is not executed : %',in_consumer_code ;
		else
			v_status := false;
			insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, in_consumer_code, 'Failure', 'Connection is not executed', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
				return -1;
		end if;			
	end if;


	if ( (v_curr_inst_todate-v_executiondate) < 0) then
		if (batch_id is null or batch_id = 0) then
			raise exception 'Billing cycle period is after the execution date for consumer : %',in_consumer_code ;
		else
			v_status := false;
			insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, in_consumer_code, 'Failure', 'Billing cycle period is after the execution date', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
				return -1;
		end if;			
	end if;
			
	--validation for execution date validation ends

	--validation for sequence of billing cycles starts
	select inst.id into v_connlatestinstid from eg_demand d, egwtr_demand_connection dc, eg_installment_master inst, eg_demand_details dd, eg_demand_reason_master dm, eg_demand_reason dr where dc.connectiondetails=in_idconndetail and dc.demand=d.id and inst.id=d.id_installment and d.id=dd.id_demand and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=dm.id and dm.code='WTAXCHARGES' and d.is_history='N' order by inst.start_date desc limit 1;
raise notice 'wtms_demand_generation_for_consumer_code v_connlatestinstid %',v_connlatestinstid;
	if(v_connlatestinstid = in_curr_inst_id) then
		if (batch_id is null or batch_id = 0) then
			raise exception 'Demand is already generated for given billing cycle: %',in_consumer_code ;
		else
			v_status := false;
			insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, in_consumer_code, 'Failure', 'Demand is already generated for given billing cycle', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
		end if;
	else	
		select abs(extract(epoch from (currinst.start_date-previnst.end_date))) into v_instdiffinsecs from eg_installment_master previnst, eg_installment_master currinst where previnst.id=v_connlatestinstid and currinst.id=in_curr_inst_id;

	if(v_instdiffinsecs>1)then
		raise notice 'The difference between end date of previous billing cycle and start date of current billing cycle provide is (in secs) %',v_instdiffinsecs;
		if (batch_id is null or batch_id = 0) then
			raise exception 'Demand generation is not allowed as the billing cycles are not in sequencial order';
		else
			v_status := false;
			insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, in_consumer_code, 'Failure', 'Demand generation is not allowed as the billing cycles are not in sequencial order', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
		end if;
	--validation for sequence of billing cycles ends
	else 
	select min(d.id) into v_firstdemandid from eg_demand d, egwtr_demand_connection dc where dc.connectiondetails=in_idconndetail and dc.demand=d.id;
	--raise notice 'v_firstdemandid----- %', v_firstdemandid;
	select d.id into v_olddemandid from eg_demand d, egwtr_demand_connection dc where dc.connectiondetails=in_idconndetail and dc.demand=d.id and d.is_history='N' and d.id_installment=in_prev_inst_id;
	select d.id into v_currdemandid from eg_demand d, egwtr_demand_connection dc where dc.connectiondetails=in_idconndetail and dc.demand=d.id and d.is_history='N' and d.id_installment=in_curr_inst_id;
	select b.id into v_prev_bill_id from eg_bill b where b.id_demand = v_olddemandid and is_cancelled='N';

	if(v_firstdemandid=v_olddemandid)then
	    v_is_oldfirstdemand := true;
	end if;
	--raise notice 'v_is_oldfirstdemand----- %', v_is_oldfirstdemand;
	raise notice 'wtms_demand_generation_for_consumer_code,  v_olddemandid, v_currdemandid, v_prev_bill_id % % %',v_olddemandid, v_currdemandid, v_prev_bill_id;

	if(v_currdemandid is null) then
		if((v_olddemandid is not null and (v_prev_bill_id is not null or v_is_oldfirstdemand)) or (v_olddemandid is null)) then
			raise notice 'wtms_demand_generation_for_consumer_code, v_olddemandid is not null';
			select end_date into v_curr_instl_end_date from eg_installment_master where id = in_curr_inst_id;
			raise notice 'wtms_demand_generation_for_consumer_code, v_curr_instl_end_date % ', v_curr_instl_end_date;
			
			--prorating logic starts
			
				if(connection_type is not null and connection_type = v_connectiontype and v_connectiontypename='NON_METERED') then
				select executiondate into v_conn_date from egwtr_connectiondetails where id = in_idconndetail;
				select start_date into v_curr_instl_start_date from eg_installment_master where id = in_curr_inst_id;
				if (v_curr_instl_start_date <= v_conn_date and v_curr_instl_end_date >= v_conn_date) then
					select wtms_rates_by_connectiondetails_id_for_non_metered(in_idconndetail,v_curr_instl_end_date) into v_demandAmountfromWtRate;
					v_days_btw_conn_date := abs(v_curr_instl_end_date - v_conn_date) + 1;
					v_days_btw_quarter := abs(v_curr_instl_end_date - v_curr_instl_start_date) + 1;
					v_demandAmountfromWtRate := round(v_days_btw_conn_date * (v_demandAmountfromWtRate / v_days_btw_quarter));
					
				else 
					select wtms_rates_by_connectiondetails_id_for_non_metered(in_idconndetail,v_curr_instl_end_date) into v_demandAmountfromWtRate;
				end if;
				
				--prorating logic ends
			else
				select wtms_rates_by_connectiondetails_id_for_metered(in_idconndetail,in_curr_inst_id,v_curr_instl_end_date,batch_id) into v_demandAmountfromWtRate;
			end if;

			raise notice 'Rate:% for consumercode: %',v_demandAmountfromWtRate,in_consumer_code;

		--exempted case validation starts
			if(v_demandAmountfromWtRate is not null and v_demandAmountfromWtRate = 0) then
				if (batch_id is null or batch_id = 0) then
					raise exception 'Connection with consumer number: % is exempted. Hence the water charges is zero.',in_consumer_code ;					
				else
					v_status := false;
					insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, in_consumer_code, 'Success', 'Connection with consumer number: ' || in_consumer_code || ' is exempted. Hence the water charges is zero.', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
				end if;

		--exempted case validation ends
			else

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

				v_temp := wtms_demand_detail_generation_for_consumer_code(v_demandAmountfromWtRate, v_olddemandid,v_newdemandid, in_curr_inst_id, in_prev_inst_id, in_idconndetail);
	
			else
				if (batch_id is null or batch_id = 0) then
					raise exception 'No water rates present for consumer number: %',in_consumer_code ;				
					else
					v_status := false;
					insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, in_consumer_code, 'Failure', 'No water rates present for consumer number: ' || in_consumer_code, now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
				end if;
			end if;
			
		end if;
		else
			if (batch_id is null or batch_id = 0) then
				raise exception 'Bill is not generated for previous billing cycle: %',in_consumer_code ;			
			else
				v_status := false;
				insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, in_consumer_code, 'Failure', 'Bill is not generated for previous billing cycle', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
			end if;
		end if;
	else
		----------Apply Demand Creation starts
		select d.id into v_currdemandid from eg_demand d, egwtr_demand_connection dc, eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master dm where dc.connectiondetails=in_idconndetail and dc.demand=d.id and d.id_installment=in_curr_inst_id and d.id=dd.id_demand and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=dm.id and dm.code not in ('WTAXCHARGES') and d.is_history='N';

		if(v_currdemandid is not null) then
			
			select end_date into v_curr_instl_end_date from eg_installment_master where id = in_curr_inst_id;
			raise notice 'wtms_demand_generation_for_consumer_code, v_curr_instl_end_date % ', v_curr_instl_end_date;
			
			--prorating logic starts
			
			if(connection_type is not null and connection_type = v_connectiontype) then
				select executiondate into v_conn_date from egwtr_connectiondetails where id = in_idconndetail;
				select start_date into v_curr_instl_start_date from eg_installment_master where id = in_curr_inst_id;
				if (v_curr_instl_start_date <= v_conn_date and v_curr_instl_end_date >= v_conn_date) then
					select wtms_rates_by_connectiondetails_id_for_non_metered(in_idconndetail,v_curr_instl_end_date) into v_demandAmountfromWtRate;
					v_days_btw_conn_date := abs(v_curr_instl_end_date - v_conn_date) + 1;
					v_days_btw_quarter := abs(v_curr_instl_end_date - v_curr_instl_start_date) + 1;
					v_demandAmountfromWtRate := round(v_days_btw_conn_date * (v_demandAmountfromWtRate / v_days_btw_quarter));
					
				else 
					select wtms_rates_by_connectiondetails_id_for_non_metered(in_idconndetail,v_curr_instl_end_date) into v_demandAmountfromWtRate;
				end if;
				
				--prorating logic ends
			else
				select wtms_rates_by_connectiondetails_id_for_metered(in_idconndetail,in_curr_inst_id,v_curr_instl_end_date,batch_id) into v_demandAmountfromWtRate;
			end if;

			raise notice 'Rate:% for consumercode: %',v_demandAmountfromWtRate,in_consumer_code;

		--exempted case validation starts
			if(v_demandAmountfromWtRate is not null and v_demandAmountfromWtRate = 0) then
				if (batch_id is null or batch_id = 0) then
					raise exception 'Connection with consumer number: % is exempted. Hence the water charges is zero.',in_consumer_code ;					
				else
					v_status := false;
					insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, in_consumer_code, 'Success', 'Connection with consumer number: ' || in_consumer_code || ' is exempted. Hence the water charges is zero.', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
				end if;

		--exempted case validation ends
			else

			if(v_demandAmountfromWtRate is not null and v_demandAmountfromWtRate > 0) then

				v_temp := wtms_demand_detail_generation_for_consumer_code(v_demandAmountfromWtRate, v_olddemandid,v_currdemandid, in_curr_inst_id, in_prev_inst_id, in_idconndetail);
	
			else
				if (batch_id is null or batch_id = 0) then
					raise exception 'No water rates present for consumer number: %',in_consumer_code ;				
				else
					v_status := false;
					insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, in_consumer_code, 'Failure', 'No water rates present for consumer number: ' || in_consumer_code, now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
				end if;
			end if;
			
		end if;
			
		----------------Apply Demand Creation ends
		else
			if (batch_id is null or batch_id = 0) then
				raise exception 'Demand is already generated for given billing cycle: %',in_consumer_code ;
			else
				v_status := false;
				insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, in_consumer_code, 'Failure', 'Demand is already generated for given billing cycle', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
			end if;
		end if;
	end if;
		if(v_connectiontypename = 'METERED' and v_citycode = '1407') then
			v_temp := wtms_meterrent(v_olddemandid, v_newdemandid, in_curr_inst_id, v_usagetype,v_curr_instl_end_date);
			end if;

	if(v_newdemandid is not null) then
		v_temp := wtms_serveadvance(v_olddemandid, v_newdemandid, in_curr_inst_id);
	end if;
	end if;
	end if;
	
	--success state
	if (batch_id is not null and batch_id <> 0 and v_status) then
		insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, in_consumer_code, 'Success', 'Demand is generated successfully for consumer number: ' || in_consumer_code, now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
	end if;
	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION wtms_demand_detail_generation_for_consumer_code(v_demandAmountfromWtRate double precision,in_olddemandid bigint, in_newdemandid bigint, in_curr_inst_id bigint, in_prev_inst_id bigint , in_idconndetail bigint)
RETURNS numeric AS
$BODY$
DECLARE
v_demand_reason_id bigint;
v_curr_meterstatus character varying(50);
v_prev_meterstatus character varying(50);
v_connectiontype character varying(50);
v_module_id bigint;
v_bd_penalty double precision;
BEGIN

	select id into v_module_id from eg_module where name='Water Tax Management';
	select id into v_demand_reason_id from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='WTAXCHARGES') and id_installment=in_curr_inst_id;

	select code into v_connectiontype from egwtr_connection_type where id = (select connectiontype from egwtr_connectiondetails where id = in_idconndetail);

	if(v_demandAmountfromWtRate > 0) then 
		insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no,remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (nextval('seq_eg_demand_details'), in_newdemandid, v_demand_reason_id, null, null, null,v_demandAmountfromWtRate, now(),now(), 0, 0);
		raise notice 'eg_demand_details created for same consumer code ';

		select meterstatus into v_curr_meterstatus from egwtr_meter_reading_details where connectiondetails = in_idconndetail and installment = in_curr_inst_id;
		select meterstatus into v_prev_meterstatus from egwtr_meter_reading_details where connectiondetails = in_idconndetail and installment = in_prev_inst_id;

		if(v_connectiontype = 'METERED' and v_curr_meterstatus is not null and v_curr_meterstatus = 'Breakdown' and v_prev_meterstatus is not null and v_prev_meterstatus = 'Breakdown') then
		
			raise notice ' inside v_connectiontype, v_curr_meterstatus, v_prev_meterstatus (% % %)',v_connectiontype, v_curr_meterstatus, v_prev_meterstatus;
		
			v_bd_penalty := wtms_breakdown_penalty_for_consumercode(v_demandAmountfromWtRate,v_module_id,in_newdemandid,in_curr_inst_id);

			update eg_demand set base_demand= base_demand+(v_bd_penalty) where id=in_newdemandid;
			
			raise notice ' v_bd_penalty (%)',v_bd_penalty;

		end if;

	end if;

 	update eg_demand set base_demand= base_demand+(v_demandAmountfromWtRate) where id=in_newdemandid;
	raise notice 'Updated base demand for same consumer code';

return 1;
END;
$BODY$ LANGUAGE plpgsql;

create or replace function wtms_breakdown_penalty_for_consumercode(in_cramount double precision,in_moduleid bigint,in_currdemand bigint,in_curr_inst_id bigint)
	returns double precision as 
$BODY$
declare
v_breakdown_penalty_multiplier bigint;
v_bd_penalty_demand_reason_id bigint;
v_bd_penalty double precision;

begin
	select value into v_breakdown_penalty_multiplier from eg_appconfig_values where key_id in (select id from eg_appconfig where module = in_moduleid and key_name = 'BREAKDOWN_PENALTY_MULTIPLIER');

	if(v_breakdown_penalty_multiplier is not null) then

		v_bd_penalty :=  (v_breakdown_penalty_multiplier-1) * in_cramount;

		select id into v_bd_penalty_demand_reason_id from eg_demand_reason where id_demand_reason_master in (select id from eg_demand_reason_master where code='BREAKDOWN_PENALTY' and module = in_moduleid) and id_installment=in_curr_inst_id;

		insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no,remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (nextval('seq_eg_demand_details'), in_currdemand, v_bd_penalty_demand_reason_id, null, null, null,v_bd_penalty, now(),now(), 0, 0);
		
	end if;
	
	return v_bd_penalty;

end;
$BODY$ language plpgsql;


CREATE OR REPLACE FUNCTION wtms_rates_by_connectiondetails_id_for_non_metered(conn_detail_id bigint,in_curr_instl_end_date date)
RETURNS numeric AS
$BODY$
DECLARE
rates record;
v_diff integer default 0;
v_temprate numeric default 0;
v_rate numeric;
v_billingtype varchar(16);
v_billamount numeric;
v_connectiontype bigint;
v_connectiontypeid bigint;
v_plotsize numeric;
v_numberoftaps numeric;
v_usagetype bigint;
v_ratetype varchar(16);
BEGIN
	
	select id into v_connectiontypeid from egwtr_connection_type where code = 'NON_METERED';

	select billingType, billAmount, connectionType, plotSize, nooftaps, usageType into v_billingtype, v_billamount, v_connectiontype, v_plotsize, v_numberoftaps, v_usagetype from egwtr_connectiondetails where id = conn_detail_id;

	if(v_billingtype is not null and v_billingtype = 'CUSTOM') then 
		v_rate = v_billamount;
	else 
		if(v_connectiontype is not null and v_connectiontype = v_connectiontypeid) then
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
	return round(v_rate);
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION wtms_rates_by_connectiondetails_id_for_metered(conn_detail_id bigint,in_curr_inst_id bigint,in_curr_instl_end_date date,batch_id bigint)
RETURNS numeric AS
$BODY$
DECLARE
v_unitsconsumed numeric default 0;
v_rate numeric;
v_minAmount numeric;
v_rateAmount numeric;
v_averageMeterReading numeric;
v_billingtype varchar(16);
v_connectiontype varchar(16);
v_connectiontypeid varchar(16);
v_usagetype bigint;
v_toVolume bigint;
v_meterstatus varchar(16);
v_consumercode varchar(32);
v_diff numeric default 0;
v_citycode character varying(4);
v_temprate numeric default 0;
rates record;
BEGIN
	
	select code into v_citycode from eg_city where active = true;
	select id into v_connectiontypeid from egwtr_connection_type where code = 'METERED';
	select c.consumercode, cd.billingType, cd.connectionType, cd.usageType, cd.averageMeterReading into v_consumercode, v_billingtype, v_connectiontype, v_usagetype, v_averageMeterReading from egwtr_connectiondetails cd,egwtr_connection c where cd.connection = c.id and cd.id = conn_detail_id;

	if(v_connectiontype is not null and v_connectiontype = v_connectiontypeid and v_billingtype is not null and v_billingtype = 'STANDARD' ) then

		select unitsconsumed,meterstatus into v_unitsconsumed,v_meterstatus from egwtr_meter_reading_details where legacy = false and connectionDetails=conn_detail_id and installment=in_curr_inst_id;
		if((v_unitsconsumed is not null and v_unitsconsumed > 0 ) or v_meterstatus = 'Locked' or v_meterstatus = 'Breakdown' or v_meterstatus = 'No_Meter') then
			select minimumamount into v_minAmount from egwtr_watermeteredcharge_rates where usagetype = v_usagetype and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date and minimumamount is not null and fromVolume is null and toVolume is null;
			if(v_meterstatus is not null and v_meterstatus = 'Locked') then
				v_rateAmount = v_minAmount;
			elsif(v_meterstatus is not null and ( v_meterstatus = 'Breakdown' or v_meterstatus = 'No_Meter' )) then
				--anandpursahib meter logic changes
				if (v_citycode = '2001') then
					for rates in (select fromVolume,toVolume,rateAmount from egwtr_watermeteredcharge_rates where usagetype = v_usagetype and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date)
					loop
						begin
							if(rates.fromVolume is not null and rates.fromVolume <= v_averageMeterReading and rates.toVolume is not null and rates.toVolume <= v_averageMeterReading) then
								v_diff := ( rates.toVolume - rates.fromVolume) + 0.01;
								v_temprate := v_temprate + (v_diff * rates.rateAmount);
							end if;
						
							if(rates.fromVolume is not null and rates.fromVolume <= v_averageMeterReading and rates.toVolume is not null and rates.toVolume > v_averageMeterReading) then
								v_diff := ( v_averageMeterReading - rates.fromVolume) + 0.01;
								v_temprate := v_temprate + (v_diff * rates.rateAmount);
							end if;

							if(rates.fromVolume is not null and rates.fromVolume <= v_averageMeterReading and rates.toVolume is null) then
								v_diff := ( v_averageMeterReading - rates.fromVolume) + 0.01;
								v_temprate := v_temprate + (v_diff * rates.rateAmount);
							end if;
						end;
					end loop;
					v_rate := v_temprate;
					v_rateAmount = 	v_rate;
				else
					select rateAmount into v_rate from egwtr_watermeteredcharge_rates where usagetype = v_usagetype and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date and ((fromVolume<= v_averageMeterReading and toVolume >= v_averageMeterReading) or (fromVolume<= v_averageMeterReading and toVolume is null));
					v_rateAmount = v_rate * v_averageMeterReading;

				end if;
				
				if(v_minAmount is not null and v_minAmount > 0 and v_minAmount > v_rateAmount) then
					v_rateAmount = v_minAmount;
				end if;
			else

				--anandpursahib meter logic changes
				if (v_citycode = '2001') then
					for rates in (select fromVolume,toVolume,rateAmount,minimumAmount  from egwtr_watermeteredcharge_rates where usagetype = v_usagetype and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date	)
					loop
						begin
							if(rates.fromVolume is not null and rates.fromVolume <= v_unitsconsumed and rates.toVolume is not null and rates.toVolume <= v_unitsconsumed) then
									v_diff := ( rates.toVolume - rates.fromVolume) + 0.01;
									v_temprate := v_temprate + (v_diff * rates.rateAmount);
							end if;
						
							if(rates.fromVolume is not null and rates.fromVolume <= v_unitsconsumed and rates.toVolume is not null and rates.toVolume > v_unitsconsumed) then
								v_diff := ( v_unitsconsumed - rates.fromVolume) + 0.01;
								v_temprate := v_temprate + (v_diff * rates.rateAmount);
							end if;

							if(rates.fromVolume is not null and rates.fromVolume <= v_unitsconsumed and rates.toVolume is null) then
								v_diff := ( v_unitsconsumed - rates.fromVolume) + 0.01;
								v_temprate := v_temprate + (v_diff * rates.rateAmount);
							end if;
						end;
					end loop;
					v_rate := v_temprate;	
					v_rateAmount = v_rate;	
				else
					select rateAmount into v_rate from egwtr_watermeteredcharge_rates where usagetype = v_usagetype and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date and ((fromVolume<= v_unitsconsumed and toVolume >= v_unitsconsumed) or (fromVolume<= v_unitsconsumed and toVolume is null));
					v_rateAmount = v_rate * v_unitsconsumed;
				
				end if;

				
				if(v_minAmount is not null and v_minAmount > 0 and v_minAmount > v_rateAmount) then
					v_rateAmount = v_minAmount;
				end if;
			end if;
		else
			v_rateAmount =null;
			if (batch_id is null or batch_id = 0) then
				raise exception 'Meter reading entry not present for selected Billing Cycle' ;
			else
				insert into egwtr_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egwtr_batchjobdetailslog'), batch_id, v_consumercode, 'Failure', 'Meter reading entry not present for selected Billing Cycle', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
			end if;

		end if;
	else
		v_rateAmount =null;
	end if;
	return round(v_rateAmount);
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

--for meter rent
			CREATE OR REPLACE FUNCTION wtms_meterrent(in_olddemandid bigint, in_newdemandid bigint, in_currinstid bigint, in_usagetype bigint,in_curr_instl_end_date date)
			RETURNS numeric AS
			$BODY$
			DECLARE
			v_temp integer;
			v_meterrent bigint;
			BEGIN
			raise notice 'wtms_meterrent : in_olddemandid, in_newdemandid (% %)', in_olddemandid, in_newdemandid;
			select rate into v_meterrent from egwtr_meter_rent where usagetype=in_usagetype and fromdate<=in_curr_instl_end_date and todate>=in_curr_instl_end_date ;
			Insert into eg_demand_details (ID, ID_DEMAND, ID_DEMAND_REASON, ID_STATUS, FILE_REFERENCE_NO, REMARKS, AMOUNT, modified_date, create_date, AMT_COLLECTED, AMT_REBATE)
			values (nextval('seq_eg_demand_details'), in_newdemandid, (select id from eg_demand_reason where id_installment = in_currinstid and id_demand_reason_master = (select id from eg_demand_reason_master where code = 'METERRENT')), 1, null, null, v_meterrent, now(), now(), 0,0);
			return v_temp;
	END;	
	$BODY$ LANGUAGE plpgsql;
