CREATE OR REPLACE FUNCTION stms_bill_genaration(batch_name varchar,boundary_type varchar,curr_installment_description varchar)
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

	select id,start_date,start_date - INTERVAL '1 SECOND' into v_curr_inst_id,v_curr_inst_start_date,v_prev_inst_end_date from eg_installment_master where id_module=(select id from eg_module where name = 'Sewerage Tax Management') and description=curr_installment_description and installment_type ='Quarterly';

	select id into v_curr_inst_id_temp from eg_installment_master where id_module=(select id from eg_module where name = 'Sewerage Tax Management') and start_date <= now() and end_date >= now() and installment_type ='Quarterly';

	select id into v_prev_inst_id from eg_installment_master where id_module=(select id from eg_module where name = 'Sewerage Tax Management') and end_date = v_prev_inst_end_date and installment_type ='Quarterly';

	if(v_curr_inst_id != v_curr_inst_id_temp) then

		for props in (select id,name from eg_boundary where id in (select boundary from egswtax_billgeneration where batchName=batch_name and boundaryType=boundary_type))
		loop 
			begin
				raise notice 'Started bill generation for location: %',props.name;

			v_temp := stms_bill_genaration_for_location(boundary_type,props.id,v_curr_inst_id,v_prev_inst_id,curr_installment_description);

				raise notice 'Done bill generation for location: %',props.name;

			exception
			when others then
			raise notice ' rollover locality bill generation for full ulb  % %',SQLERRM, SQLSTATE;
			end;
		end loop;
	else
		raise notice 'Given installment % is current installment so we cannot process',curr_installment_description;
	end if;
	
END;
$BODY$ LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------------------



----------------procedure for Add eg_bill and eg_bill_details entry
create or replace function stms_bill_genaration_for_location(boundary_type varchar,in_location_id bigint,in_curr_inst_id bigint,in_prev_inst_id bigint,curr_installment_description varchar)
returns numeric as 
$BODY$
declare
rec record;
v_temp integer;
begin

	if(boundary_type is not null and boundary_type = 'Locality') then
		
		for rec in (select distinct conn.shsc_number, conndet.id as conndetid,conn.id as connid ,conn.locality as locationid, appdet.id as appdetid from egswtax_connection conn,egswtax_connectiondetail conndet,egswtax_applicationdetails appdet,egswtax_demand_connection conndem, eg_demand dem, eg_demand_details demdet,egw_status status WHERE conn.id=appdet.connection and conndet.id=appdet.connectiondetail and conn.status='ACTIVE' and appdet.status=status.id and status.moduletype='SEWERAGETAXAPPLICATION' and status.code='SANCTIONED' and appdet.id=conndem.applicationdetail and conndem.demand = dem.id and conn.locality = in_location_id and demdet.id_demand=dem.id and dem.is_history='N' and demdet.amount>0 and demdet.amount != demdet.amt_collected)
	  	loop
			begin
				raise notice 'Started bill generation for consumercode: %',rec.shsc_number;

	    			v_temp := stms_bill_genaration_for_consumer_code(rec.shsc_number,rec.connid, in_curr_inst_id, in_prev_inst_id,curr_installment_description,rec.locationid,rec.appdetid);
			
				raise notice 'Done bill generation for consumercode: %',rec.shsc_number;
				exception
				when others then
				raise notice 'Error in bill generation for consumer code :% % %',rec.shsc_number, SQLERRM, SQLSTATE;
			end;
		end loop;  
	
	end if;

	if(boundary_type is not null and boundary_type = 'Block') then 
		for rec in (select distinct conn.shsc_number, conndet.id as conndetid,conn.id as connid ,conn.locality as locationid, appdet.id as appdetid from egswtax_connection conn,egswtax_connectiondetail conndet,egswtax_applicationdetails appdet,egswtax_demand_connection conndem, eg_demand dem, eg_demand_details demdet,egw_status status WHERE conn.id=appdet.connection and conndet.id=appdet.connectiondetail and conn.status='ACTIVE' and appdet.status=status.id and status.moduletype='SEWERAGETAXAPPLICATION' and status.code='SANCTIONED' and appdet.id=conndem.applicationdetail and conndem.demand = dem.id and conn.block = in_location_id and demdet.id_demand=dem.id and dem.is_history='N' and demdet.amount>0 and demdet.amount != demdet.amt_collected)
	  	loop
			begin
				raise notice 'Started bill generation for consumercode: %',rec.shsc_number;

	    			v_temp := stms_bill_genaration_for_consumer_code(rec.shsc_number, rec.connid, in_curr_inst_id, in_prev_inst_id,curr_installment_description,rec.locationid,rec.appdetid);
			
				raise notice 'Done bill generation for consumercode: %',rec.shsc_number;
				exception
				when others then
				raise notice 'Error in bill generation for consumer code :% % %',rec.shsc_number, SQLERRM, SQLSTATE;
			end;
		end loop; 
	end if;
	raise notice 'stms bill generation completed for location: (%)', in_location_id;
	return v_temp;	
end;
$BODY$ language plpgsql;




-------------------------------------------------------------------------------------------------------------

create or replace function stms_bill_genaration_for_consumer_code(in_consumercode varchar(16), in_conn_id bigint,in_curr_inst_id bigint,in_prev_inst_id bigint,curr_installment_description varchar,in_location_id bigint, in_appdet_id bigint)
returns numeric  as 
$BODY$
declare
v_billno character varying(10);
v_description character varying(256);
v_bpid bigint;
v_addressid bigint;
v_moduleid bigint;
v_idbillype bigint;
v_currdemand bigint;
v_iduser bigint;
v_propertyid bigint;
v_totalamountcollected double precision;
v_totalamount double precision;
citycode character varying(4);
v_temp integer;
v_demandbill bigint;
v_ownername character varying(256);
v_billpk bigint;
v_bpropId bigint;
v_olddemand bigint;
v_houseno character varying(256);
v_streetaddress character varying(256);
v_penalty double precision;

begin
	select id into v_moduleid from eg_module where name='Sewerage Tax Management';
	select id into v_idbillype from eg_bill_type where name='MANUAL';
	select id into v_currdemand from eg_demand where id in (select demand from egswtax_demand_connection where applicationdetail=in_appdet_id) and id_installment = in_curr_inst_id;

	if(v_currdemand is not null) then

		select id into v_demandbill from eg_bill where consumer_id=in_consumercode and module_id = v_moduleid and id_bill_type=v_idbillype and is_cancelled='N' and id_demand = v_currdemand;
	
		if(v_demandbill is null) then
			select id into v_iduser from eg_user where username='egovernments';
			select code into citycode from eg_city;
	 		select citycode || lpad(nextval('seq_eg_bill')::text,6,'0') into v_billno;
			select 'Sewerage Tax Consumer No: ' || in_consumercode into v_description;
			select u.name into v_ownername from egswtax_connection_owner_info info,eg_user u where u.id = info.owner and info.connection = in_conn_id limit 1;
			select address.housenobldgapt into v_houseno from egswtax_address wtraddress ,eg_address address, egswtax_connection conn where conn.id = in_conn_id and conn.address = wtraddress.id and wtraddress.id = address.id ;
			select id into v_olddemand from eg_demand where id in (select demand from egswtax_demand_connection where applicationdetail=in_appdet_id) and id_installment = in_prev_inst_id order by id desc limit 1;
			select nextval('seq_eg_bill') into v_billpk;

			v_penalty := stms_penalty_and_interest_generate_for_consumercode(in_consumercode, in_curr_inst_id,in_prev_inst_id);

	 	 	raise notice 'Penalty calculated for consumer code % and penalty is: %', in_consumercode,v_penalty;

			insert into eg_bill(id, id_demand, citizen_name, citizen_address, bill_no, id_bill_type, issue_date, last_date, module_id, user_id, create_date, modified_date, is_history, is_cancelled, fundcode, functionary_code,fundsource_code, department_code, coll_modes_not_allowed, boundary_num, boundary_type,total_amount, total_collected_amount, service_code, part_payment_allowed, override_accountheads_allowed,description, min_amt_payable, consumer_id, dspl_message, callback_for_apportion,penalty) values (v_billpk, v_currdemand, v_ownername,v_houseno, v_billno, v_idbillype, now(), now(), v_moduleid, v_iduser, now(), now(), 'N', 'N', '01', '1', '01', 'REV', null, in_location_id, null, v_totalamount, v_totalamountcollected, 'STAX', 'Y', 'N', v_description, 0, in_consumercode, 'Sewerage Tax Collection', 'N',v_penalty);
		
			v_temp := stms_bill_detail_genaration_for_consumer_code (v_billpk,v_currdemand,v_olddemand,in_curr_inst_id,in_prev_inst_id,
	curr_installment_description);

	 	 	raise notice 'eg_bill created for consumer code %', in_consumercode;
	  	else
	  		raise notice 'Bill allready present for this cosumer code (%)',in_consumercode;
	  	end if;
	else
		raise notice 'Demand does not exist for current installment %', in_consumercode;
	end if;

	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION stms_bill_detail_genaration_for_consumer_code(v_billpk bigint, in_demandid bigint,v_olddemand bigint, in_curr_inst_id bigint,in_prev_inst_id bigint,curr_installment_description varchar)
RETURNS numeric AS
$BODY$
DECLARE
v_installmentDesc character varying(256);
v_billDesc character varying(256);
v_sw_chargers_demandreason bigint;
v_penalty_demandreason bigint;
v_interest_demandreason bigint;
v_wt_chargers_glcodeid bigint;
v_penalty_glcodeid bigint;
v_interest_glcodeid bigint;
v_wt_chargers_glcode character varying(50);
v_penalty_glcode character varying(50);
v_interest_glcode character varying(50);
v_function_code character varying(50);
v_module_id bigint;
v_arrear_amount double precision;
v_penalty_amount double precision;
v_interest_amount double precision;
BEGIN
	select id into v_module_id from eg_module where name='Sewerage Tax Management';

	select id,glcodeid into v_sw_chargers_demandreason,v_wt_chargers_glcodeid from eg_demand_reason where id_demand_reason_master in (select id from eg_demand_reason_master where code='SEWERAGETAX' and module = v_module_id) and id_installment=in_curr_inst_id;

	select id,glcodeid into v_penalty_demandreason,v_penalty_glcodeid from eg_demand_reason where id_demand_reason_master in (select id from eg_demand_reason_master where code='PENALTY' and module = v_module_id) and id_installment=in_curr_inst_id;

	select id,glcodeid into v_interest_demandreason,v_interest_glcodeid from eg_demand_reason where id_demand_reason_master in (select id from eg_demand_reason_master where code='INTEREST' and module = v_module_id) and id_installment=in_curr_inst_id;

	select glcode into v_wt_chargers_glcode from chartofaccounts where id = v_wt_chargers_glcodeid;
	select glcode into v_penalty_glcode from chartofaccounts where id = v_penalty_glcodeid;
	select glcode into v_interest_glcode from chartofaccounts where id = v_interest_glcodeid;

	select value into v_function_code from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Sewerage Tax Management') and key_name = 'SEWERAGE_FUNCTION_CODE');

	select description into v_installmentDesc from eg_installment_master where id=in_curr_inst_id;

	select 'Sewerage Tax -' || v_installmentDesc into v_billDesc;

	insert into eg_bill_details(id,id_demand_reason,create_date,modified_date,id_bill,collected_amount,order_no,glcode,function_code, cr_amount ,dr_amount,description ,id_installment ,  additional_flag,purpose) select nextval('seq_eg_bill_details'),  v_sw_chargers_demandreason, now(),now(), v_billpk,0, 1,v_wt_chargers_glcode,v_function_code,amount, 0,v_billDesc,in_curr_inst_id,1,'CURRENT_AMOUNT' from eg_demand_details dd where dd.id_demand=in_demandid and dd.amount>0 and dd.id_demand_reason=v_sw_chargers_demandreason ;

	-- old bill-details entry for demand_details where amount is not paid

-- arrear amount

	select sum(dd.amount - dd.amt_collected) into v_arrear_amount from eg_demand_details dd,eg_demand_reason dr ,eg_demand_reason_master drm where dd.id_demand_reason=dr.id and dd.id_demand_reason = dr.id and dr.id_demand_reason_master = drm.id and drm.code = 'SEWERAGETAX' and drm.module = v_module_id and dr.id_installment not in (in_curr_inst_id) and dd.id_demand=in_demandid ;

	if(v_arrear_amount is not null and v_arrear_amount > 0) then 
		insert into eg_bill_details(id, id_demand_reason, create_date, modified_date,id_bill, collected_amount, order_no, glcode, function_code, cr_amount, dr_amount, description, id_installment, additional_flag,purpose) values(nextval('seq_eg_bill_details'), v_sw_chargers_demandreason, now(), now(), v_billpk, 0, 2, v_wt_chargers_glcode, v_function_code,v_arrear_amount, 0, v_billDesc, in_curr_inst_id, 1,'ARREAR_AMOUNT');
	end  if;


-- penalty amount

	select sum(dd.amount - dd.amt_collected) into v_penalty_amount from eg_demand_details dd,eg_demand_reason dr ,eg_demand_reason_master drm where dd.id_demand_reason=dr.id and dd.id_demand_reason = dr.id and dr.id_demand_reason_master = drm.id and drm.code = 'PENALTY' and drm.module = v_module_id and dr.id_installment not in (in_curr_inst_id) and dd.id_demand=in_demandid ;

	if(v_penalty_amount is not null and v_penalty_amount > 0) then 
		insert into eg_bill_details(id, id_demand_reason, create_date, modified_date,id_bill, collected_amount, order_no, glcode, function_code, cr_amount, dr_amount, description, id_installment, additional_flag,purpose) values(nextval('seq_eg_bill_details'), v_penalty_demandreason, now(), now(), v_billpk, 0, 2,v_penalty_glcode, v_function_code, v_penalty_amount, 0, v_billDesc, in_curr_inst_id, 1,'PENALTY');
	end  if;


-- interest amount

	select sum(dd.amount - dd.amt_collected) into v_interest_amount from eg_demand_details dd,eg_demand_reason dr ,eg_demand_reason_master drm where dd.id_demand_reason=dr.id and dd.id_demand_reason = dr.id and dr.id_demand_reason_master = drm.id and drm.code = 'INTEREST' and drm.module = v_module_id and dr.id_installment not in (in_curr_inst_id) and dd.id_demand=in_demandid ;

	if(v_interest_amount is not null and v_interest_amount > 0) then 
		insert into eg_bill_details(id, id_demand_reason, create_date, modified_date,id_bill, collected_amount, order_no, glcode, function_code, cr_amount, dr_amount, description, id_installment, additional_flag,purpose) values(nextval('seq_eg_bill_details'), v_interest_demandreason, now(), now(), v_billpk, 0, 2,v_interest_glcode, v_function_code, v_interest_amount, 0, v_billDesc, in_curr_inst_id, 1,'INTEREST');
	end  if;

	 	raise notice 'eg_bill_details created for same consumer code';
		
		update eg_bill_details set description=description || ' # ' || curr_installment_description where id_bill=v_billpk and  description not like '%#%' ;
		return v_billpk;
END;
$BODY$ LANGUAGE plpgsql;


create or replace function stms_penalty_and_interest_generate_for_consumercode(in_consumercode varchar(16), in_curr_inst_id bigint,in_prev_inst_id bigint)
	returns double precision as 
$BODY$
declare
v_moduleid bigint;
v_idbillype bigint;
v_conn_id bigint;
v_applicationdetail_id bigint;
v_billdate date;
v_penalty_date date;
v_penalty double precision;
v_previousChargesBal double precision;
v_previousdemandid bigint;
v_penalty_demand_reason_id bigint;
v_demand_detail_id bigint;
v_currdemandid bigint;
v_interest double precision;
v_interest_date date;
v_interest_months bigint;
v_interest_demand_reason_id bigint;
v_penalty_period bigint;
v_interest_period bigint;
v_penalty_percentage bigint;
v_interest_percentage bigint;

begin
	v_penalty := 0;
	select id into v_moduleid from eg_module where name ='Sewerage Tax Management';
	select id into v_idbillype from eg_bill_type where name='MANUAL';
	select id into v_conn_id from egswtax_connection where status ='ACTIVE' and shsc_number=in_consumercode;
	select id into v_applicationdetail_id from egswtax_applicationdetails where connection = v_conn_id;
	select dem.id into v_currdemandid from eg_demand dem, egswtax_demand_connection conn where dem.id=conn.demand and conn.applicationdetail=v_applicationdetail_id and dem.id_installment=in_curr_inst_id;
	select dem.id into v_previousdemandid from eg_demand dem, egswtax_demand_connection conn where dem.id=conn.demand and conn.applicationdetail=v_applicationdetail_id and dem.id_installment=in_prev_inst_id;
	select issue_date into v_billdate from eg_bill where consumer_id=in_consumercode and module_id = v_moduleid and id_bill_type = v_idbillype and is_cancelled = 'N' and id_demand=v_previousdemandid;
	select sum(dd.amount-dd.amt_collected) into v_previousChargesBal from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_previousdemandid and dd.id_demand_reason=dr.id and drm.id=dr.id_demand_reason_master and dr.id_installment=in_prev_inst_id and  drm.code='SEWERAGETAX' and drm.module = v_moduleid;
	
	if(v_billdate is not null) then

		select value into v_penalty_period from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Sewerage Tax Management') and key_name = 'PANALTY_PERIOD');

		select value into v_interest_period from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Sewerage Tax Management') and key_name = 'INTEREST_PERIOD'); 

		select value into v_penalty_percentage from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Sewerage Tax Management') and key_name = 'PANALTY_PERCENTAGE'); 

		select value into v_interest_percentage from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Sewerage Tax Management') and key_name = 'INTEREST_PERCENTAGE');

		select 	v_billdate + INTERVAL '1 DAY' * v_penalty_period   into v_penalty_date;
		select 	v_billdate + INTERVAL '1 DAY' * (v_penalty_period + v_interest_period) into v_interest_date;
		select abs(EXTRACT(year FROM age(v_interest_date::date,now()::date))*12 + EXTRACT(month FROM age(v_interest_date::date,now()::date))) into v_interest_months;
		v_interest_months = v_interest_months + 1;

		if(v_penalty_date < now() and v_previousChargesBal>0) then

			v_penalty := (v_previousChargesBal * v_penalty_percentage)/100;

			select nextval('seq_eg_demand_details') into v_demand_detail_id;

			select id into v_penalty_demand_reason_id from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='PENALTY' and module = v_moduleid) and id_installment=in_prev_inst_id;

			insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no,remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (v_demand_detail_id, v_currdemandid, v_penalty_demand_reason_id, null, null, null,v_penalty, now(),now(), 0, 0);

		end if;

		if(v_interest_date < now() and v_previousChargesBal>0) then

			v_interest := (v_previousChargesBal * (v_interest_percentage * v_interest_months))/100;

			select nextval('seq_eg_demand_details') into v_demand_detail_id;

			select id into v_interest_demand_reason_id from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='INTEREST' and module = v_moduleid) and id_installment=in_prev_inst_id;

			insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no,remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (v_demand_detail_id, v_currdemandid, v_interest_demand_reason_id, null, null, null,v_interests, now(),now(), 0, 0);

		end if;
	else
		raise notice 'Bill does not exist for previous installment %',in_consumercode;
	end if;

	return v_penalty;

end;
$BODY$ language plpgsql;