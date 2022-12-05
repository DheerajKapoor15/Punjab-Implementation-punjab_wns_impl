CREATE OR REPLACE FUNCTION stms_demand_genaration(batch_name varchar,boundary_type varchar,curr_installment_description varchar, batch_id bigint)
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
			v_temp  := stms_demand_genaration_for_boundary(boundary_type, props.id, v_curr_inst_id, v_prev_inst_id, batch_id);
			raise notice 'Done demand generation for location: %',props.name;
		exception
		when others then
		if (batch_id is null or batch_id = 0) then
			raise notice 'Error in demand generation for ulb % % %',props.name,SQLERRM, SQLSTATE;
		else
			insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby, errormessage) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, null, 'Failure', 'Error in demand generation for ulb ' || props.name, now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'), SQLERRM || ' ' || SQLSTATE);
		end if;
		end;
	end loop;
		
	else
		if (batch_id is null or batch_id = 0) then
			raise notice 'Given installment % is current installment so we cannot process',curr_installment_description;
		else
			insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, null, 'Failure', 'Given installment ' || curr_installment_description || ' is current installment so we cannot process', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
		end if;
	end if;
	
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION stms_demand_genaration_for_boundary(boundary_type varchar, in_boundary bigint, in_curr_inst_id bigint, in_prev_inst_id bigint, batch_id bigint)
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
				v_temp  := stms_demand_generation_for_consumer_code(props.shsc_number, props.appdetid, in_curr_inst_id, in_prev_inst_id, batch_id);
				raise notice 'Done demand generation for shsc_number: %',props.shsc_number;
			exception
			when others then
				if (batch_id is null or batch_id = 0) then
					raise notice 'Error in demand generation for consumer number: % % %',props.shsc_number,SQLERRM, SQLSTATE;
				else
					insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby, errormessage) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, null, 'Failure', 'Error in demand generation for consumer number ' || props.shsc_number, now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'), SQLERRM || ' ' || SQLSTATE);
			end if;
			end;
		end loop;
	end if;

	if(boundary_type is not null and boundary_type = 'Block') then 
		for props in (select distinct conn.shsc_number, appdet.id as appdetid from egswtax_connection conn, egswtax_connectiondetail conndet, egswtax_applicationdetails appdet, egw_status status WHERE conn.id=appdet.connection and conndet.id=appdet.connectiondetail and conn.status='ACTIVE' and appdet.status=status.id and status.moduletype='SEWERAGETAXAPPLICATION' and status.code='SANCTIONED' and conn.block = in_boundary)
		loop 
			begin
				raise notice 'Started demand generation for shsc_number: %',props.shsc_number;
				v_temp  := stms_demand_generation_for_consumer_code(props.shsc_number, props.appdetid, in_curr_inst_id, in_prev_inst_id, batch_id);
				raise notice 'Done demand generation for shsc_number: %',props.shsc_number;
			exception
			when others then
				if (batch_id is null or batch_id = 0) then
					raise notice 'Error in demand generation for consumer number: % % %',props.shsc_number,SQLERRM, SQLSTATE;
				else
					insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby, errormessage) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, null, 'Failure', 'Error in demand generation for consumer number ' || props.shsc_number, now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'), SQLERRM || ' ' || SQLSTATE);
			end if;
			end;
		end loop;
	end if;

	raise notice 'wtms demand generation completed for boundary: % and boundary type: %', in_boundary, boundary_type;
	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION stms_demand_generation_for_consumer_code(in_consumercode varchar, in_idappdetail bigint, in_curr_inst_id bigint, in_prev_inst_id bigint, batch_id bigint)
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
v_connlatestinstid bigint;
v_status boolean default true;
v_is_oldfirstdemand boolean default false;
v_firstdemandid bigint;
v_conn_date date;
v_curr_instl_start_date date;
v_days_btw_conn_date double precision;
v_days_btw_quarter double precision;
v_sc_prev_billingcycle varchar;
v_wc_prev_inst_id bigint;

BEGIN
 
	raise notice 'stms_demand_generation_for_consumer_code, in_consumercode, in_idappdetail, in_curr_inst_id, in_prev_inst_id % % % %',in_consumercode, in_idappdetail, in_curr_inst_id, in_prev_inst_id;
	
	--validation for sequence of billing cycles starts
	select inst.id into v_connlatestinstid from eg_demand d, egswtax_demand_connection dc, eg_installment_master inst, eg_demand_details dd, eg_demand_reason_master dm, eg_demand_reason dr where dc.applicationdetail=in_idappdetail and dc.demand=d.id and inst.id=d.id_installment and d.id=dd.id_demand and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=dm.id and dm.code='SEWERAGETAX' and d.is_history='N' order by inst.start_date desc limit 1;
	if(v_connlatestinstid = in_curr_inst_id) then
		if (batch_id is null or batch_id = 0) then
			raise exception 'Demand is already generated for given billing cycle: %',in_consumercode ;
		else
			v_status := false;
			insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, in_consumercode, 'Failure', 'Demand is already generated for given billing cycle', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
		end if;
	else
		select abs(extract(epoch from (currinst.start_date-previnst.end_date))) into v_instdiffinsecs from eg_installment_master previnst, eg_installment_master currinst where previnst.id=v_connlatestinstid and currinst.id=in_curr_inst_id;

	if(v_instdiffinsecs>1)then
		raise notice 'The difference between end date of previous billing cycle and start date of current billing cycle provide is (in secs) %',v_instdiffinsecs;
		if (batch_id is null or batch_id = 0) then
			raise exception 'Demand generation is not allowed as the billing cycles are not in sequencial order';
		else
			v_status := false;
			insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, in_consumercode, 'Failure', 'Demand generation is not allowed as the billing cycles are not in sequencial order', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
			end if;
	--validation for sequence of billing cycles ends
	else
	select min(d.id) into v_firstdemandid from eg_demand d, egswtax_demand_connection dc where dc.applicationdetail=in_idappdetail and dc.demand=d.id;
	select d.id into v_olddemandid from eg_demand d, egswtax_demand_connection dc where dc.applicationdetail=in_idappdetail and dc.demand=d.id and d.is_history='N' and d.id_installment=in_prev_inst_id;
	select d.id into v_currdemandid from eg_demand d, egswtax_demand_connection dc where dc.applicationdetail=in_idappdetail and dc.demand=d.id and d.is_history='N' and d.id_installment=in_curr_inst_id;
	select b.id into v_prev_bill_id from eg_bill b where b.id_demand = v_olddemandid and is_cancelled='N';

	if(v_prev_bill_id is null) then
		select description into v_sc_prev_billingcycle from eg_installment_master where id=in_prev_inst_id;
		select id into v_wc_prev_inst_id from eg_installment_master where description = v_sc_prev_billingcycle and id_module = (select id from eg_module where name='Water Tax Management');
		select bill.id into v_prev_bill_id from egwtr_connection wconn, egwtr_connectiondetails wcd, egswtax_connection sconn, egswtax_connectiondetail scd, egswtax_applicationdetails sad, egwtr_demand_connection wdc, eg_demand d, eg_bill bill where sconn.id=sad.connection and scd.id=sad.connectiondetail and scd.wateridentifier=wconn.oldconsumernumber and wcd.connection=wconn.id and wcd.id=wdc.connectiondetails and wdc.demand=d.id and d.id=bill.id_demand and bill.is_cancelled='N' and bill.id_bill_type=(select id from eg_bill_type where code='INTEGRATED') and d.id_installment=v_wc_prev_inst_id and sconn.shsc_number=in_consumercode;

		if (v_prev_bill_id is null) then

			select bill.id into v_prev_bill_id from egwtr_connection wconn, egwtr_connectiondetails wcd, egswtax_connection sconn, egswtax_connectiondetail scd, egswtax_applicationdetails sad, egwtr_demand_connection wdc, eg_demand d, eg_bill bill where sconn.id=sad.connection and scd.id=sad.connectiondetail and scd.wateridentifier=wconn.consumercode and wcd.connection=wconn.id and wcd.id=wdc.connectiondetails and wdc.demand=d.id and d.id=bill.id_demand and bill.is_cancelled='N' and bill.id_bill_type=(select id from eg_bill_type where code='INTEGRATED') and d.id_installment=v_wc_prev_inst_id and sconn.shsc_number=in_consumercode;

		end if;

	end if;

	if(v_firstdemandid=v_olddemandid) then
	    v_is_oldfirstdemand := true;
	end if;

	raise notice 'stms_demand_generation_for_consumer_code,  v_olddemandid, v_currdemandid, v_prev_bill_id % % %',v_olddemandid, v_currdemandid, v_prev_bill_id;

	if(v_currdemandid is null) then
		if((v_olddemandid is not null and (v_prev_bill_id is not null or v_is_oldfirstdemand)) or (v_olddemandid is null)) then
			raise notice 'stms_demand_generation_for_consumer_code, v_olddemandid is null';
			select end_date into v_curr_instl_end_date from eg_installment_master where id = in_curr_inst_id;
			raise notice 'stms_demand_generation_for_consumer_code, v_curr_instl_end_date % ', v_curr_instl_end_date;
			
			--prorating logic starts
			
			select executiondate into v_conn_date from egswtax_connection where id = (select connection from egswtax_applicationdetails where id = in_idappdetail);
				select start_date into v_curr_instl_start_date from eg_installment_master where id = in_curr_inst_id;
				if (v_curr_instl_start_date <= v_conn_date and v_curr_instl_end_date >= v_conn_date) then
					select stms_rates_by_connectiondetails_id(in_idappdetail, in_curr_inst_id, v_curr_instl_end_date) into v_demandAmountfromSWRate;
					v_days_btw_conn_date := abs(v_curr_instl_end_date - v_conn_date);
					v_days_btw_quarter := abs(v_curr_instl_end_date - v_curr_instl_start_date);
					v_demandAmountfromSWRate := round(v_demandAmountfromSWRate / (round(v_days_btw_quarter / v_days_btw_conn_date)));
				else
			
			select stms_rates_by_connectiondetails_id(in_idappdetail, in_curr_inst_id, v_curr_instl_end_date) into v_demandAmountfromSWRate;
				end if;

			raise notice 'Rate:% for consumercode: %',v_demandAmountfromSWRate,in_consumercode;

	--exempted case validation starts
		if(v_demandAmountfromSWRate is not null and v_demandAmountfromSWRate = 0) then
			if (batch_id is null or batch_id = 0) then
				raise exception 'Connection with consumer number: % is exempted. Hence the sewerage charges is zero.',in_consumercode ;				else
				v_status := false;
				insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, in_consumercode, 'Success', 'Connection with consumer number: ' || in_consumercode || ' is exempted. Hence the sewerage charges is zero.', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
			end if;

	--exempted case validation ends
		else
			if(v_demandAmountfromSWRate is not null and v_demandAmountfromSWRate > 0) then

				select nextval('SEQ_EG_DEMAND') into v_newdemandid;

				if (v_olddemandid IS NOT NULL) then 
					raise notice 'eg_demand created from old demand for consumercode: %',in_consumercode;
					insert into eg_demand (id, id_installment, base_demand, is_history, create_date, modified_date, amt_collected, status, min_amt_payable, amt_rebate) select v_newdemandid, in_curr_inst_id, base_demand, is_history, now(), now(),amt_collected, status, null, 0 from eg_demand where id = v_olddemandid;
					--copying old demand_demand_details to new eg_demand.
					raise notice 'stms_demand_generation_for_consumer_code, copying old demand_demand_details to new eg_demand.';
					insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no, remarks, amount, modified_date, create_date, amt_collected, amt_rebate) select nextval('seq_eg_demand_details'), v_newdemandid, id_demand_reason, id_status, file_reference_no, remarks, amount, modified_date, create_date, amt_collected, amt_rebate from eg_demand_details where id_demand = v_olddemandid and id_demand_reason not in (select id from eg_demand_reason where id_demand_reason_master = (select id from eg_demand_reason_master where code = 'SEWERAGEADVANCE'));
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
				if (batch_id is null or batch_id = 0) then
					raise exception 'No sewerage rates present for consumer number: %',in_consumercode ;				else
					v_status := false;
					insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, in_consumercode, 'Failure', 'No sewerage rates present for consumer number: ' || in_consumercode, now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
				end if;
			end if;
			end if;
			else
				if (batch_id is null or batch_id = 0) then
				raise exception 'Bill is not generated for previous billing cycle: %',in_consumercode ;			else
				v_status := false;
				insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, in_consumercode, 'Failure', 'Bill is not generated for previous billing cycle', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
			end if;
			end if;
	else
		--------apply demand creation starts
		select d.id into v_currdemandid from eg_demand d, egswtax_demand_connection dc, eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master dm where dc.applicationdetail=in_idappdetail and dc.demand=d.id and d.id_installment=in_curr_inst_id and d.id=dd.id_demand and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=dm.id and dm.code not in ('SEWERAGETAX') and d.is_history='N';

		if(v_currdemandid is not null) then
		
				select end_date into v_curr_instl_end_date from eg_installment_master where id = in_curr_inst_id;
			raise notice 'stms_demand_generation_for_consumer_code, v_curr_instl_end_date % ', v_curr_instl_end_date;
			
			--prorating logic starts
			
			select executiondate into v_conn_date from egswtax_connection where id = (select connection from egswtax_applicationdetails where id = in_idappdetail);
				select start_date into v_curr_instl_start_date from eg_installment_master where id = in_curr_inst_id;
				if (v_curr_instl_start_date <= v_conn_date and v_curr_instl_end_date >= v_conn_date) then
					select stms_rates_by_connectiondetails_id(in_idappdetail, in_curr_inst_id, v_curr_instl_end_date) into v_demandAmountfromSWRate;
					v_days_btw_conn_date := abs(v_curr_instl_end_date - v_conn_date);
					v_days_btw_quarter := abs(v_curr_instl_end_date - v_curr_instl_start_date);
					v_demandAmountfromSWRate := round(v_demandAmountfromSWRate / (round(v_days_btw_quarter / v_days_btw_conn_date)));
				else
			
			select stms_rates_by_connectiondetails_id(in_idappdetail, in_curr_inst_id, v_curr_instl_end_date) into v_demandAmountfromSWRate;
				end if;

			raise notice 'Rate:% for consumercode: %',v_demandAmountfromSWRate,in_consumercode;

	--exempted case validation starts
		if(v_demandAmountfromSWRate is not null and v_demandAmountfromSWRate = 0) then
			if (batch_id is null or batch_id = 0) then
				raise exception 'Connection with consumer number: % is exempted. Hence the sewerage charges is zero.',in_consumercode ;				else
				v_status := false;
				insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, in_consumercode, 'Success', 'Connection with consumer number: ' || in_consumercode || ' is exempted. Hence the sewerage charges is zero.', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
			end if;

	--exempted case validation ends
		else
			if(v_demandAmountfromSWRate is not null and v_demandAmountfromSWRate > 0) then

				v_temp := stms_demand_detail_generation_for_consumer_code(v_demandAmountfromSWRate, v_olddemandid,v_currdemandid, in_curr_inst_id, in_prev_inst_id);
	
			else
				if (batch_id is null or batch_id = 0) then
					raise exception 'No sewerage rates present for consumer number: %',in_consumercode ;				else
					v_status := false;
					insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, in_consumercode, 'Failure', 'No sewerage rates present for consumer number: ' || in_consumercode, now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
				end if;
			end if;
		end if;
			
		--------apply demand creation ends
		else
			if (batch_id is null or batch_id = 0) then
				raise exception 'Demand is already generated for given billing cycle: %',in_consumercode ;
			else
				v_status := false;
				insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, in_consumercode, 'Failure', 'Demand is already generated for given billing cycle', now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
			end if;
		end if;
	end if;
	if(v_newdemandid is not null) then
		v_temp := stms_serveadvance(v_olddemandid, v_newdemandid, in_curr_inst_id);
	end if;
	end if;
	end if;
	--success state
	if (batch_id is not null and batch_id <> 0 and v_status) then
		insert into egswtax_batchjobdetailslog(id, jobdetails, consumercode, status, reason, createddate, lastmodifieddate, createdby, lastmodifiedby) values(nextval('seq_egstax_batchjobdetailslog'), batch_id, in_consumercode, 'Success', 'Demand is generated successfully for consumer number: ' || in_consumercode, now(), now(), (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'));
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

CREATE OR REPLACE FUNCTION stms_rates_by_connectiondetails_id(app_detail_id bigint, in_curr_inst_id bigint, in_curr_instl_end_date date)
RETURNS numeric AS
$BODY$
DECLARE
rates record;
v_diff integer default 0;
v_temprate numeric default 0;
v_rate numeric;
v_billingtype varchar(50);
v_wt_billingtype varchar(50);
v_billamount numeric;
v_plotsize numeric;
v_numberofclosets numeric;
v_usagetype bigint;
v_ratetype varchar(50);
v_wateridentifier varchar(50);
v_connectiontype character varying(50);
v_wt_conn_det_id bigint;
v_wt_chargers_demandreason bigint;
v_wt_amount double precision;
v_meterstatus varchar(50);
v_currdemandid bigint;
wt_curr_inst_id bigint;
BEGIN

	raise notice 'stms_rates_by_connectiondetails_id : app_detail_id, in_curr_instl_end_date  % %',app_detail_id, in_curr_instl_end_date;

	select cd.billingType, cd.billAmount, cd.plotSize, (coalesce(cd.noofclosets_residential, 0)+coalesce(cd.noofclosets_nonresidential,0)), cd.usageType, cd.wateridentifier into v_billingtype, v_billamount, v_plotsize, v_numberofclosets, v_usagetype, v_wateridentifier from egswtax_connectiondetail cd, egswtax_applicationdetails app where app.connectiondetail=cd.id and app.id = app_detail_id;

	raise notice 'v_billingtype, v_billamount, v_plotsize, v_numberofclosets, v_usagetype, v_wateridentifier  % % % % % %',v_billingtype, v_billamount, v_plotsize, v_numberofclosets, v_usagetype, v_wateridentifier;
	
	if(v_wateridentifier is not null) then
		select id into wt_curr_inst_id from eg_installment_master where description = (select description from eg_installment_master where id = in_curr_inst_id) and id_module = (select id from eg_module where name='Water Tax Management');
		select cd.id,cd.billingtype into v_wt_conn_det_id,v_wt_billingtype from egwtr_connectiondetails cd,egwtr_connection c where c.id = cd.connection and c.oldconsumernumber = v_wateridentifier;
		select ct.code into v_connectiontype from egwtr_connection_type ct,egwtr_connectiondetails cd where ct.id = cd.connectiontype and cd.id = v_wt_conn_det_id;
		select id into v_wt_chargers_demandreason from eg_demand_reason where id_demand_reason_master in (select id from eg_demand_reason_master where code='WTAXCHARGES' and module = (select id from eg_module where name='Water Tax Management')) and id_installment=wt_curr_inst_id;
		select d.id into v_currdemandid from eg_demand d, egwtr_demand_connection dc where dc.connectiondetails=v_wt_conn_det_id and dc.demand=d.id and d.id_installment=wt_curr_inst_id;
		select dd.amount into v_wt_amount from eg_demand_details dd where dd.id_demand=v_currdemandid and dd.amount>0 and dd.id_demand_reason=v_wt_chargers_demandreason;
		if(v_connectiontype is not null and v_connectiontype = 'METERED') then
			select meterstatus into v_meterstatus from egwtr_meter_reading_details where connectiondetails = v_wt_conn_det_id and installment=wt_curr_inst_id;
		end if;
		raise notice 'wt_curr_inst_id,v_wt_conn_det_id,v_wt_billingtype,v_connectiontype,v_wt_chargers_demandreason,v_currdemandid,v_wt_amount,v_meterstatus  % % % % % % % % ',wt_curr_inst_id,v_wt_conn_det_id,v_wt_billingtype,v_connectiontype,v_wt_chargers_demandreason,v_currdemandid,v_wt_amount,v_meterstatus;
	end if;

	raise notice 'stms_rates_by_connectiondetails_id : v_billingtype, v_billamount, v_plotsize, v_numberofclosets, v_usagetype  % % % % %',v_billingtype, v_billamount, v_plotsize, v_numberofclosets, v_usagetype;

	select value into v_ratetype from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Sewerage Tax Management') and key_name = 'TAX_RATETYPE');

	if(v_ratetype is not null and v_ratetype = 'SEWERAGE_EQUAL_TO_WATER' and v_wateridentifier is not null) then
		
		if(v_connectiontype is not null and v_connectiontype = 'NON_METERED') then
			if(v_billingtype is not null and v_billingtype = 'CUSTOM' and v_wt_billingtype is not null and v_wt_billingtype = 'CUSTOM') then
				v_rate := v_billamount;
			else
				v_rate := v_wt_amount;
			end if;
		else
		
			if(v_meterstatus is not null and v_meterstatus = 'Locked') then
				select minimumamount into v_rate from egswtax_seweragecharge_rates where usagetype = v_usagetype and ratetype = 'MINIMUM_AMOUNT' and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date;
			else
				v_rate := v_wt_amount;
			end if;
			
		end if;

	end if;

	if(v_ratetype is not null and ( v_ratetype = 'PLOT_BASED' or v_ratetype = 'SEAT_BASED' )) then

		if(v_billingtype is not null and v_billingtype = 'CUSTOM') then
			
			v_rate = v_billamount;
			
		else 
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
	end if;

	if(v_ratetype is not null and v_ratetype = 'FIXED') then
		select fixedcharges into v_rate from egswtax_seweragecharge_rates where usagetype = v_usagetype and ratetype = 'FIXED' and effectiveFromDate<=in_curr_instl_end_date and effectiveToDate>=in_curr_instl_end_date limit 1;
	end if;
	return v_rate;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION stms_serveadvance(in_olddemandid bigint, in_newdemandid bigint, in_currinstid bigint)
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
	raise notice 'stms_serveadvance : in_olddemandid, in_newdemandid (% %)', in_olddemandid, in_newdemandid;
	select dd.amt_collected into v_advancecoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=in_olddemandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id and drm.code='SEWERAGEADVANCE';
	raise notice 'stms_serveadvance : v_advancecoll (%)', v_advancecoll;

	if (v_advancecoll>0) then
	  for demanddets in (select dd.id ddid, dd.amount, dd.amt_collected from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm, eg_installment_master inst where dd.id_demand=in_newdemandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id and dr.id_installment=inst.id and drm.code!='SEWERAGEADVANCE' and (dd.amount-dd.amt_collected)>0 order by inst.start_date, drm."order")
	    loop 
		  v_ddid := demanddets.ddid;
		  v_tax := demanddets.amount;
		  v_collection := demanddets.amt_collected;
		  v_balance := v_tax-v_collection;
		  --raise notice 'stms_serveadvance : v_ddid, v_tax, v_collection, v_balance (% % % %)', v_ddid, v_tax, v_collection, v_balance;
		  begin
			  raise notice 'stms_serveadvance : inside loop start v_advancecoll (%)', v_advancecoll;
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
			  raise notice 'stms_serveadvance : inside loop end v_advancecoll (%)', v_advancecoll;
		  EXCEPTION
		  WHEN OTHERS THEN
		  raise notice 'rolloverward : % %', SQLERRM, SQLSTATE;
		  END;
	    END LOOP;
	  if (v_advancecoll > 0) then
	    Insert into eg_demand_details (ID, ID_DEMAND, ID_DEMAND_REASON, ID_STATUS, FILE_REFERENCE_NO, REMARKS, AMOUNT, modified_date, create_date, AMT_COLLECTED, AMT_REBATE) 
	    values (nextval('seq_eg_demand_details'), in_newdemandid, (select id from eg_demand_reason where id_installment = in_currinstid and id_demand_reason_master = (select id from eg_demand_reason_master where code = 'SEWERAGEADVANCE')), 1, null, null, 0, now(), now(), v_advancecoll,0);
	  end if;
	end if;
	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;
