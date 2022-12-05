--Sewerage cancel demand
create or replace FUNCTION pbsc_cancelseweragedemand(in_consumercode IN varchar(50), in_billingcycle IN varchar(50))  
RETURNS numeric as $$
declare
	v_seq_cancelreq			bigint;
	v_retval				bigint default 1;
	v_moduleid				bigint;
	v_inputinstid 			bigint;  
	v_nextinstid			bigint;
	v_nextbc				character varying(50);
	v_previousinstid		bigint;
	v_previousdemandid		bigint;
	v_appldetid				bigint;
	v_inputdemandid 		bigint;

	v_inputbillavailable 	boolean default false;
	v_inputrcptavailable 	boolean default false;
	v_nextdemandavailable 	boolean default false;
	v_nextbillavailable 	boolean default false;
	v_nextrcptavailable 	boolean default false;

	v_inputbillnumber 		character varying(50);
	v_inputbilldate 		date;
	v_inputrcptnumber 		character varying(50);
	v_inputrcptdate 		date;
	v_nextdemandid	  		bigint;
	v_nextbillnumber  		character varying(50);
	v_nextbilldate 			date;
	v_nextrcptnumber 		character varying(50);
	v_nextrcptdate 			date;

	v_errormessage	 		character varying(1000);
	temp	bigint;
BEGIN 
	raise notice 'Request received to cancel sewerage demand for consumer number : % for billing cycle : %', in_consumercode, in_billingcycle;

	select id into v_moduleid from eg_module where name = 'Sewerage Tax Management';
	select ad.id into v_appldetid from egswtax_connection conn, egswtax_applicationdetails ad where ad.connection=conn.id and shsc_number=in_consumercode;
	insert into egwtr_connection(id, createdby, createddate, lastmodifieddate, lastmodifiedby, version) values (10000, 1, now(), now(), 1, 0);
	if(v_appldetid is null)then
		raise exception 'There is no sewerage connection with given consumer number : %', in_billingcycle;
	end if;

	select id into v_inputinstid from eg_installment_master where id_module=v_moduleid and description=in_billingcycle and installment_type ='Quarterly';

	if(v_inputinstid is null)then
		raise exception 'There is no Billing cycle defined in sewerage system for given value : %', in_billingcycle;
	end if;

	select d.id into v_inputdemandid from eg_demand d, egswtax_demand_connection dc where dc.demand=d.id and d.is_history='N' and dc.applicationdetail=v_appldetid and d.id_installment=v_inputinstid;

	if(v_inputdemandid is null)then
		raise exception 'The is no active demand available for given billing cycle';
	end if;

	--getting previous billing cycle
	select id into v_previousinstid from eg_installment_master where id_module=v_moduleid and installment_type ='Quarterly' and end_date = (select start_date - INTERVAL '1 SECOND' from eg_installment_master where id_module=v_moduleid and id=v_inputinstid and installment_type ='Quarterly');

	--getting next billing cycle
	select id, description into v_nextinstid, v_nextbc from eg_installment_master where id_module=v_moduleid and installment_type ='Quarterly' and start_date = (select end_date + INTERVAL '1 SECOND' from eg_installment_master where id_module=v_moduleid and id=v_inputinstid and installment_type ='Quarterly');

	--getting previous demand
	select d.id into v_previousdemandid from eg_demand d, egswtax_demand_connection dc where dc.demand=d.id and dc.applicationdetail=v_appldetid and d.id_installment=v_previousinstid order by id desc limit 1;

	if(v_previousdemandid is null)then
		raise exception 'The connection is either migrated or created with given billing cycle, hence demand cannot be cancelled';
	end if;

	--getting input billing cycle bill
	select bill.bill_no, bill.issue_date::date into v_inputbillnumber, v_inputbilldate from eg_bill bill where bill.id_demand=v_inputdemandid and bill.is_cancelled='N' and bill.module_id=v_moduleid and bill.id_bill_type!=2;

	if (v_inputbillnumber is not null) then 
		v_inputbillavailable:=true;
	end if;

	--getting input billing cycle receipts
	select rcpt.receipt_number, rcpt.receipt_date::date into v_inputrcptnumber, v_inputrcptdate from eg_demand_details dd, egdm_collected_receipts rcpt where dd.id_demand=v_inputdemandid and dd.id=rcpt.id_demand_detail order by rcpt.receipt_date limit 1;

	if (v_inputrcptnumber is not null) then 
		v_inputrcptavailable:=true;
	end if;

	--getting next billing cycle demand
	select d.id into v_nextdemandid from eg_demand d, egswtax_demand_connection dc where dc.demand=d.id and d.is_history='N' and dc.applicationdetail=v_appldetid and d.id_installment=v_nextinstid order by id desc limit 1;

	if (v_nextdemandid is not null) then 
		v_nextdemandavailable:=true;

		--getting next billing cycle bill
		select bill.bill_no, bill.issue_date::date into v_nextbillnumber, v_nextbilldate from eg_bill bill where bill.id_demand=v_nextdemandid and bill.is_cancelled='N' and bill.module_id=v_moduleid and bill.id_bill_type!=2;

		if (v_nextbillnumber is not null) then 
			v_nextbillavailable:=true;
		end if;

		--getting input billing cycle receipts
		select rcpt.receipt_number, rcpt.receipt_date::date into v_nextrcptnumber, v_nextrcptdate from eg_demand_details dd, egdm_collected_receipts rcpt where dd.id_demand=v_nextdemandid and dd.id=rcpt.id_demand_detail order by rcpt.receipt_date limit 1;

		if (v_nextrcptnumber is not null) then 
			v_nextrcptavailable:=true;
		end if;
	end if;

	--checks before cancelling a demand
	if (v_inputbillavailable=true) then
		raise notice 'There is active bill for given billing cycle : % with bill number : % generated on : %', in_billingcycle, v_inputbillnumber, v_inputbilldate;
		v_errormessage := v_errormessage || 'There is active bill for given billing cycle : '||in_billingcycle||' with bill number : '||v_inputbillnumber||' generated on : '||v_inputbilldate;
		v_retval:=0;
	end if;
	if (v_inputrcptavailable=true) then
		raise notice 'There is active receipt for given billing cycle : % with receipt number : % paid on : %', in_billingcycle, v_inputrcptnumber, v_inputrcptdate;
		v_errormessage := v_errormessage || 'There is active receipt for given billing cycle : '||in_billingcycle||' with receipt number : '||v_inputrcptnumber||' paid on : '||v_inputrcptdate;
		v_retval:=0;
	end if;
	if (v_nextdemandavailable=true) then
		raise notice 'There is demand generated for next billing cycle';
		v_errormessage := v_errormessage || 'There is demand generated for next billing cycle';
		v_retval:=0;
	end if;
	if (v_nextbillavailable=true) then
		raise notice 'There is active bill for next billing cycle : % with bill number : % generated on : %', v_nextbc, v_nextbillnumber, v_nextbilldate;
		v_errormessage := v_errormessage || 'There is active bill for next billing cycle : '||v_nextbc||' with bill numbe : '||v_nextbillnumber||' generated on : '||v_nextbilldate;
		v_retval:=0;
	end if;
	if (v_nextrcptavailable=true) then
		raise notice 'There is active receipt for next billing cycle : % with receipt number : % paid on : %', v_nextbc, v_nextrcptnumber, v_nextrcptdate;
		v_errormessage := v_errormessage || 'There is active receipt for next billing cycle : '||v_nextbc||' with receipt number : '||v_nextrcptnumber||' paid on : '||v_nextrcptdate;
		v_retval:=0;
	end if;

	if (v_inputbillavailable=true and v_inputrcptavailable=true and v_nextdemandavailable=true and v_nextbillavailable=true and v_nextbillavailable=true and v_nextrcptavailable=true) then
		raise notice 'Please resolve all above mentioned to proceed to cancel the demand for given consumer number';
		return 0;
	end if;

	if (v_inputbillavailable=false and v_inputrcptavailable=false and v_nextdemandavailable=false and v_nextbillavailable=false and v_nextbillavailable=false and v_nextrcptavailable=false) then
		update eg_demand set is_history='N' where id=v_previousdemandid;
		update eg_demand set is_history='Y' where id=v_inputdemandid;
		raise notice 'Requested demand succesfully cancelled and made previous billing cycle demand as active';
	end if;
	
	return v_retval;
END;
$$ LANGUAGE plpgsql;

create or replace FUNCTION pbsc_cancelseweragebill(in_consumercode IN varchar(50), in_billingcycle IN varchar(50))  
RETURNS numeric as $BODY$
declare
	v_seq_cancelreq			bigint;
	v_retval				bigint default 1;
	v_moduleid				bigint;
	v_inputinstid 			bigint;  
	v_nextinstid			bigint;
	v_nextbc				character varying(50);
	v_appldetid				bigint;
	v_inputdemandid 		bigint;

	v_inputrcptavailable 	boolean default false;
	v_nextdemandavailable 	boolean default false;
	v_nextbillavailable 	boolean default false;
	v_nextrcptavailable 	boolean default false;

	v_inputbillnumber 		character varying(50);
	v_inputbilldate 		date;
	v_inputrcptnumber 		character varying(50);
	v_inputrcptdate 		date;
	v_nextdemandid	  		bigint;
	v_nextbillnumber  		character varying(50);
	v_nextbilldate 			date;
	v_nextrcptnumber 		character varying(50);
	v_nextrcptdate 			date;

	v_errormessage	 		character varying(1000);
BEGIN 
	raise notice 'Request received to cancel sewerage bill for consumer number : % for billing cycle : %', in_consumercode, in_billingcycle;

	select id into v_moduleid from eg_module where name = 'Sewerage Tax Management';
	select ad.id into v_appldetid from egswtax_connection conn, egswtax_applicationdetails ad where ad.connection=conn.id and shsc_number=in_consumercode;

	if(v_appldetid is null)then
		raise exception 'There is no sewerage connection with given consumer number : %', in_billingcycle;
	end if;

	select id into v_inputinstid from eg_installment_master where id_module=v_moduleid and description=in_billingcycle and installment_type ='Quarterly';

	if(v_inputinstid is null)then
		raise exception 'There is no Billing cycle defined in sewerage system for given value : %', in_billingcycle;
	end if;

	select d.id into v_inputdemandid from eg_demand d, egswtax_demand_connection dc where dc.demand=d.id and d.is_history='N' and dc.applicationdetail=v_appldetid and d.id_installment=v_inputinstid;

	if(v_inputdemandid is null)then
		raise exception 'There is no demand available or bill is not generated for given billing cycle';
	else
		--getting input billing cycle bill
		select bill.bill_no into v_inputbillnumber from eg_bill bill where bill.id_demand=v_inputdemandid and bill.is_cancelled='N' and bill.module_id=v_moduleid and bill.id_bill_type!=2;

		if (v_inputbillnumber is null) then 
			raise exception 'There is no active bill available for given billing cycle';
		end if;
	end if;

	--getting next billing cycle
	select id, description into v_nextinstid, v_nextbc from eg_installment_master where id_module=v_moduleid and installment_type ='Quarterly' and start_date = (select end_date + INTERVAL '1 SECOND' from eg_installment_master where id_module=v_moduleid and id=v_inputinstid and installment_type ='Quarterly');

	--getting input billing cycle receipts
	select rcpt.receipt_number, rcpt.receipt_date::date into v_inputrcptnumber, v_inputrcptdate from eg_demand_details dd, egdm_collected_receipts rcpt where dd.id_demand=v_inputdemandid and dd.id=rcpt.id_demand_detail order by rcpt.receipt_date limit 1;

	if (v_inputrcptnumber is not null) then 
		v_inputrcptavailable:=true;
	end if;

	--getting next billing cycle demand
	select d.id into v_nextdemandid from eg_demand d, egswtax_demand_connection dc where dc.demand=d.id and d.is_history='N' and dc.applicationdetail=v_appldetid and d.id_installment=v_nextinstid order by id desc limit 1;

	if (v_nextdemandid is not null) then 
		v_nextdemandavailable:=true;

		--getting next billing cycle bill
		select bill.bill_no, bill.issue_date::date into v_nextbillnumber, v_nextbilldate from eg_bill bill where bill.id_demand=v_nextdemandid and bill.is_cancelled='N' and bill.module_id=v_moduleid and bill.id_bill_type!=2;

		if (v_nextbillnumber is not null) then 
			v_nextbillavailable:=true;
		end if;

		--getting next billing cycle receipts
		select rcpt.receipt_number, rcpt.receipt_date::date into v_nextrcptnumber, v_nextrcptdate from eg_demand_details dd, egdm_collected_receipts rcpt where dd.id_demand=v_nextdemandid and dd.id=rcpt.id_demand_detail order by rcpt.receipt_date limit 1;

		if (v_nextrcptnumber is not null) then 
			v_nextrcptavailable:=true;
		end if;
	end if;

	--checks before cancelling a bill
	if (v_inputrcptavailable=true) then
		raise notice 'There is active receipt for given billing cycle : % with receipt number : % paid on : %', in_billingcycle, v_inputrcptnumber, v_inputrcptdate;
		v_errormessage := v_errormessage || 'There is active receipt for given billing cycle : '||in_billingcycle||' with receipt number : '||v_inputrcptnumber||' paid on : '||v_inputrcptdate;
		v_retval:=0;
	end if;
	if (v_nextdemandavailable=true) then
		raise notice 'There is demand generated for next billing cycle';
		v_errormessage := v_errormessage || 'There is demand generated for next billing cycle';
		v_retval:=0;
	end if;
	if (v_nextbillavailable=true) then
		raise notice 'There is active bill for next billing cycle : % with bill number : % generated on : %', v_nextbc, v_nextbillnumber, v_nextbilldate;
		v_errormessage := v_errormessage || 'There is active bill for next billing cycle : '||v_nextbc||' with bill numbe : '||v_nextbillnumber||' generated on : '||v_nextbilldate;
		v_retval:=0;
	end if;
	if (v_nextrcptavailable=true) then
		raise notice 'There is active receipt for next billing cycle : % with receipt number : % paid on : %', v_nextbc, v_nextrcptnumber, v_nextrcptdate;
		v_errormessage := v_errormessage || 'There is active receipt for next billing cycle : '||v_nextbc||' with receipt number : '||v_nextrcptnumber||' paid on : '||v_nextrcptdate;
		v_retval:=0;
	end if;

	if (v_inputrcptavailable=true and v_nextdemandavailable=true and v_nextbillavailable=true and v_nextbillavailable=true and v_nextrcptavailable=true) then
		raise notice 'Please resolve all above mentioned to proceed to cancel the demand for given consumer number';
		return 0;
	end if;

	if (v_inputrcptavailable=false and v_nextdemandavailable=false and v_nextbillavailable=false and v_nextbillavailable=false and v_nextrcptavailable=false) then
		update eg_bill set is_cancelled='Y' where bill_no=v_inputbillnumber;
		raise notice 'Requested bill succesfully cancelled';
	end if;
	
	return v_retval;
END;
$BODY$ LANGUAGE plpgsql;
