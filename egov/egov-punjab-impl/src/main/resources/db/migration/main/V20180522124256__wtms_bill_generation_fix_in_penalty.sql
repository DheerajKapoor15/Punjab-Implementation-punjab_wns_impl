CREATE OR REPLACE FUNCTION wtms_bill_genaration_for_non_metered_connections(batch_name varchar,curr_installment_description varchar)
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

raise notice 'v_curr_inst_id,v_curr_inst_id_temp % %',v_curr_inst_id,v_curr_inst_id_temp;

	if(v_curr_inst_id != v_curr_inst_id_temp) then

		for props in (select id,name from eg_boundary where boundarynum in (select boundarynum from egwtr_billgeneration where batchName=batch_name))
		loop 
			begin
				raise notice 'Started bill generation for location: %',props.name;

				v_temp  := wtms_bill_genaration_for_location(props.id,v_curr_inst_id,v_prev_inst_id,curr_installment_description);

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
create or replace function wtms_bill_genaration_for_location(in_wardid bigint,in_curr_inst_id bigint,in_prev_inst_id bigint,curr_installment_description varchar)
returns numeric as 
$BODY$
declare
rec record;
v_temp integer;
begin
	for rec in (select distinct conn.consumercode, conndet.id as conndetid,conn.id as connid from egwtr_connection conn,egwtr_connectiondetails conndet,egwtr_demand_connection conndem, eg_demand dem, eg_demand_details demdet,egw_status status WHERE conn.id=conndet.connection and conndet.id=conndem.connectiondetails and conndet.connectionstatus='ACTIVE' and conndet.connectiontype='NON_METERED' and conndem.demand = dem.id and conn.locality = in_wardid and conndet.statusid=status.id and conndet.statusid=status.id and status.moduletype='WATERTAXAPPLICATION' and status.code='SANCTIONED' and conndem.demand = dem.id and demdet.id_demand=dem.id and dem.is_history='N' and demdet.amount>0 and demdet.amount != demdet.amt_collected)
  	loop
		begin
			raise notice 'Started bill generation for consumercode: %',rec.consumercode;

    			v_temp := wtms_bill_genaration_for_consumer_code(rec.consumercode,rec.connid,rec.conndetid, in_curr_inst_id, in_prev_inst_id,curr_installment_description);
			
			raise notice 'Done bill generation for consumercode: %',rec.consumercode;
			exception
			when others then
			raise notice 'Error in bill generation for consumer code :% % %',rec.consumercode, SQLERRM, SQLSTATE;
		end;
	end loop;  
	raise notice 'wtms bill generation completed for location: (%)', in_wardid;
	return v_temp;	
end;
$BODY$ language plpgsql;




-------------------------------------------------------------------------------------------------------------

create or replace function wtms_bill_genaration_for_consumer_code(v_consumercode varchar(16), in_conn_id bigint,in_conn_det_id bigint,in_curr_inst_id bigint,in_prev_inst_id bigint,curr_installment_description varchar)
returns numeric  as 
$BODY$
declare
v_billno character varying(10);
v_description character varying(256);
v_bpid bigint;
v_addressid bigint;
v_ward_adm_id bigint;
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
	select id into v_moduleid from eg_module where name='Water Tax Management';
	select id into v_idbillype from eg_bill_type where name='MANUAL';
	select id into v_currdemand from eg_demand where id in (select demand from egwtr_demand_connection where connectiondetails=in_conn_det_id) and id_installment = in_curr_inst_id;

	if(v_currdemand is not null) then

		select id into v_demandbill from eg_bill where consumer_id=v_consumercode and module_id = v_moduleid and id_bill_type=v_idbillype and is_cancelled='N' and id_demand in(select id from eg_demand where id in (select demand from egwtr_demand_connection where connectiondetails=in_conn_det_id) and id_installment = in_curr_inst_id);
	
		if(v_demandbill is null) then
			select id into v_iduser from eg_user where username='egovernments';
			select code into citycode from eg_city;
	 		select citycode || lpad(nextval('seq_eg_bill')::text,6,'0') into v_billno;
			select 'Water Charge H.S.C No: ' || v_consumercode into v_description;
			select u.name into v_ownername from egwtr_connection_owner_info info,eg_user u where u.id = info.owner and info.connection = in_conn_id limit 1;
			select address.housenobldgapt into v_houseno from egwtr_address wtraddress ,eg_address address, egwtr_connection conn where conn.id = in_conn_id and conn.address = wtraddress.id and wtraddress.id = address.id ;
			select locality into v_ward_adm_id from egwtr_connection where id = in_conn_id;
			select id into v_olddemand from eg_demand where id in (select demand from egwtr_demand_connection where connectiondetails=in_conn_det_id) and id_installment = in_prev_inst_id order by id desc limit 1;
			select base_demand,amt_collected into v_totalamount,v_totalamountcollected from eg_demand where id=v_currdemand;
			select nextval('seq_eg_bill') into v_billpk;

			v_penalty := wtms_penalty_and_interest_generate_for_consumercode(v_consumercode, in_curr_inst_id,in_prev_inst_id);
	 	 	raise notice 'Penalty calculated for consumer code % and penalty is: %', v_consumercode,v_penalty;
			insert into eg_bill(id, id_demand, citizen_name, citizen_address, bill_no, id_bill_type, issue_date, last_date, module_id, user_id, create_date, modified_date, is_history, is_cancelled, fundcode, functionary_code,fundsource_code, department_code, coll_modes_not_allowed, boundary_num, boundary_type,total_amount, total_collected_amount, service_code, part_payment_allowed, override_accountheads_allowed,description, min_amt_payable, consumer_id, dspl_message, callback_for_apportion,penalty) values (v_billpk, v_currdemand, v_ownername,v_houseno, v_billno, v_idbillype, now(), now(), v_moduleid, v_iduser, now(), now(), 'N', 'N', '01', 1, '01', 'REV', null, v_ward_adm_id, 'Ward', v_totalamount, v_totalamountcollected, 'WT', 'Y', 'N', v_description, 0, v_consumercode, 'Water Charge Collection', 'N',v_penalty);
		
			v_temp := wtms_bill_detail_genaration_for_consumer_code (v_billpk,v_currdemand,v_olddemand,in_curr_inst_id,in_prev_inst_id,
	curr_installment_description);

	 	 	raise notice 'eg_bill created for consumer code %', v_consumercode;
	  	else
	  		raise notice 'Bill allready present for this cosumer code (%)',v_consumercode;
	  	end if;
	else
		raise notice 'Demand does not exist for current installment %', v_consumercode;
	end if;

	return v_temp;
END;
$BODY$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION wtms_bill_detail_genaration_for_consumer_code(v_billpk bigint, in_demandid bigint,v_olddemand bigint, in_curr_inst_id bigint,in_prev_inst_id bigint,curr_installment_description varchar)
RETURNS numeric AS
$BODY$
DECLARE
v_installmentDesc character varying(256);
v_billDesc character varying(256);
v_wt_chargers_demandreason bigint;
v_penalty_demandreason bigint;
v_interest_demandreason bigint;
v_module_id bigint;
v_arrear_amount double precision;
v_penalty_amount double precision;
v_interest_amount double precision;
BEGIN
	select id into v_module_id from eg_module where name='Water Tax Management';

	select id into v_wt_chargers_demandreason from eg_demand_reason where id_demand_reason_master in (select id from eg_demand_reason_master where code='WTAXCHARGES' and module = v_module_id) and id_installment=in_curr_inst_id;

	select id into v_penalty_demandreason from eg_demand_reason where id_demand_reason_master in (select id from eg_demand_reason_master where code='PENALTY' and module = v_module_id) and id_installment=in_curr_inst_id;

	select id into v_interest_demandreason from eg_demand_reason where id_demand_reason_master in (select id from eg_demand_reason_master where code='INTEREST' and module = v_module_id) and id_installment=in_curr_inst_id;

	select description into v_installmentDesc from eg_installment_master where id=in_curr_inst_id;

	select 'Water Charges -' || v_installmentDesc into v_billDesc;

	insert into eg_bill_details(id,id_demand_reason,create_date,modified_date,id_bill,collected_amount,order_no,glcode,function_code, cr_amount ,dr_amount,description ,id_installment ,  additional_flag,purpose) select nextval('seq_eg_bill_details'),  v_wt_chargers_demandreason, now(),now(), v_billpk,0, 1,'1806006','50515100',amount, 0,v_billDesc,in_curr_inst_id,1,'CURRENT_AMOUNT' from eg_demand_details dd where dd.id_demand=in_demandid and dd.amount>0 and dd.id_demand_reason=v_wt_chargers_demandreason ;

	-- old bill-details entry for demand_details where amount is not paid

-- arrear amount

	select sum(dd.amount - dd.amt_collected) into v_arrear_amount from eg_demand_details dd,eg_demand_reason dr ,eg_demand_reason_master drm where dd.id_demand_reason=dr.id and dd.id_demand_reason = dr.id and dr.id_demand_reason_master = drm.id and drm.code = 'WTAXCHARGES' and module = v_module_id and dr.id_installment not in (in_curr_inst_id) and dd.id_demand=in_demandid ;

	if(v_arrear_amount is not null and v_arrear_amount > 0) then 
		insert into eg_bill_details(id, id_demand_reason, create_date, modified_date,id_bill, collected_amount, order_no, glcode, function_code, cr_amount, dr_amount, description, id_installment, additional_flag,purpose) values(nextval('seq_eg_bill_details'), v_wt_chargers_demandreason, now(), now(), v_billpk, 0, 2, '1806006', '50515100',v_arrear_amount, 0, v_billDesc, in_curr_inst_id, 1,'ARREAR_AMOUNT');
	end  if;


-- penalty amount

	select sum(dd.amount - dd.amt_collected) into v_penalty_amount from eg_demand_details dd where dd.id_demand_reason= v_penalty_demandreason and dd.id_demand=in_demandid ;

	if(v_penalty_amount is not null and v_penalty_amount > 0) then 
		insert into eg_bill_details(id, id_demand_reason, create_date, modified_date,id_bill, collected_amount, order_no, glcode, function_code, cr_amount, dr_amount, description, id_installment, additional_flag,purpose) values(nextval('seq_eg_bill_details'), v_penalty_demandreason, now(), now(), v_billpk, 0, 2, 
'1806006', '50515100', v_penalty_amount, 0, v_billDesc, in_curr_inst_id, 1,'PENALTY');
	end  if;


-- interest amount

	select sum(dd.amount - dd.amt_collected) into v_interest_amount from eg_demand_details dd where dd.id_demand_reason= v_interest_demandreason and dd.id_demand=in_demandid ;

	if(v_interest_amount is not null and v_interest_amount > 0) then 
		insert into eg_bill_details(id, id_demand_reason, create_date, modified_date,id_bill, collected_amount, order_no, glcode, function_code, cr_amount, dr_amount, description, id_installment, additional_flag,purpose) values(nextval('seq_eg_bill_details'), v_interest_demandreason, now(), now(), v_billpk, 0, 2,'1806006', '50515100', v_interest_amount, 0, v_billDesc, in_curr_inst_id, 1,'INTEREST');
	end  if;

	 	raise notice 'eg_bill_details created for same consumer code';
		
		update eg_bill_details set description=description || ' # ' || curr_installment_description where id_bill=v_billpk and  description not like '%#%' ;
		return v_billpk;
END;
$BODY$ LANGUAGE plpgsql;


create or replace function wtms_penalty_and_interest_generate_for_consumercode(in_consumercode varchar(16), in_curr_inst_id bigint,in_prev_inst_id bigint)
	returns double precision as 
$BODY$
declare
v_moduleid bigint;
v_idbillype bigint;
v_conn_det_id bigint;
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
	select id into v_moduleid from eg_module where name ='Water Tax Management';
	select id into v_idbillype from eg_bill_type where name='MANUAL';
	select id into v_conn_det_id from egwtr_connectiondetails where connectionstatus='ACTIVE' and connectiontype='NON_METERED' and  connection in(select id from egwtr_connection where consumercode=in_consumercode);
	select dem.id into v_currdemandid from eg_demand dem, egwtr_demand_connection conn where dem.id=conn.demand and conn.connectiondetails=v_conn_det_id and dem.id_installment=in_curr_inst_id;
	select dem.id into v_previousdemandid from eg_demand dem, egwtr_demand_connection conn where dem.id=conn.demand and conn.connectiondetails=v_conn_det_id and dem.id_installment=in_prev_inst_id;
	select issue_date into v_billdate from eg_bill where consumer_id=in_consumercode and module_id = v_moduleid and id_bill_type = v_idbillype and is_cancelled = 'N' and id_demand=v_previousdemandid;
	select sum(dd.amount-dd.amt_collected) into v_previousChargesBal from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_previousdemandid and dd.id_demand_reason=dr.id and drm.id=dr.id_demand_reason_master and dr.id_installment=in_prev_inst_id and  drm.code='WTAXCHARGES';
	
	if(v_billdate is not null) then

		select value into v_penalty_period from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Water Tax Management') and key_name = 'PANALTY_PERIOD');

		select value into v_interest_period from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Water Tax Management') and key_name = 'INTEREST_PERIOD'); 

		select value into v_penalty_percentage from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Water Tax Management') and key_name = 'PANALTY_PERCENTAGE'); 

		select value into v_interest_percentage from eg_appconfig_values where key_id in (select id from eg_appconfig where module in (select id from eg_module where name = 'Water Tax Management') and key_name = 'INTEREST_PERCENTAGE');

		select 	v_billdate + INTERVAL '1 DAY' * v_penalty_period   into v_penalty_date;
		select 	v_billdate + INTERVAL '1 DAY' * (v_penalty_period + v_interest_period) into v_interest_date;
		select start_date,end_date, abs(EXTRACT(year FROM age(v_interest_date::date,now()::date))*12 + EXTRACT(month FROM age(v_interest_date::date,now()::date))) into v_interest_months;
		v_interest_months = v_interest_months + 1;

		if(v_penalty_date < now() and v_previousChargesBal>0) then

			v_penalty := (v_previousChargesBal * v_penalty_percentage)/100;

			select nextval('seq_eg_demand_details') into v_demand_detail_id;

			select id into v_penalty_demand_reason_id from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='PENALTY') and id_installment=in_curr_inst_id;

			insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no,remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (v_demand_detail_id, v_currdemandid, v_penalty_demand_reason_id, null, null, null,v_penalty, now(),now(), 0, 0);

		end if;

		if(v_interest_date < now() and v_previousChargesBal>0) then

			v_interest := (v_previousChargesBal * (v_interest_percentage * v_interest_months))/100;

			select nextval('seq_eg_demand_details') into v_demand_detail_id;

			select id into v_interest_demand_reason_id from eg_demand_reason where id_demand_reason_master in(select id from eg_demand_reason_master where code='INTEREST') and id_installment=in_curr_inst_id;

			insert into eg_demand_details(id, id_demand, id_demand_reason, id_status, file_reference_no,remarks, amount, modified_date, create_date, amt_collected, amt_rebate) values (v_demand_detail_id, v_currdemandid, v_interest_demand_reason_id, null, null, null,v_interests, now(),now(), 0, 0);

		end if;
	else
		raise notice 'Bill does not exist for previous installment %',in_consumercode;
	end if;

	return v_penalty;

end;
$BODY$ language plpgsql;
