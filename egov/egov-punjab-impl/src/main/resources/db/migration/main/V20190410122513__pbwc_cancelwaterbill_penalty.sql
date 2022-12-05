CREATE OR REPLACE FUNCTION pbwc_cancelwaterbill(
    in_consumercode character varying,
    in_billingcycle character varying)
  RETURNS numeric AS
$BODY$
declare
	v_seq_cancelreq			bigint;
	v_retval				bigint default 1;
	v_moduleid				bigint;
	v_inputinstid 			bigint;  
	v_nextinstid			bigint;
	v_nextbc				character varying(50);
	v_conndetid				bigint;
	v_inputdemandid 		bigint;

	v_inputrcptavailable 	boolean default false;
	v_nextdemandavailable	boolean default false;
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

	v_penaltydemanddetailid bigint;

	v_errormessage	 		character varying(1000);
BEGIN 
	raise notice 'Request received to cancel water bill for consumer number : % for billing cycle : %', in_consumercode, in_billingcycle;

	--logging request details
	--select nextval('seq_egwtr_backend_cancelrequest') into v_seq_cancelreq;
	--raise notice 'v_seq_cancelreq %', v_seq_cancelreq;
	--insert into egwtr_backend_cancelrequest (id, consumercode, billingcycle, type, status, requestedtime) values (v_seq_cancelreq, in_consumercode, in_billingcycle, 'BILL', 'RECEIVED', now());
	raise notice 'request logged';
	select id into v_moduleid from eg_module where name = 'Water Tax Management';
	select ad.id into v_conndetid from egwtr_connection conn, egwtr_connectiondetails ad where ad.connection=conn.id and consumercode=in_consumercode;

	if(v_conndetid is null)then
		--update egwtr_backend_cancelrequest set status='FAILED', error='There is no water connection with given consumer number' where id=v_seq_cancelreq;
		raise exception 'There is no water connection with given consumer number : %', in_billingcycle;
	end if;

	select id into v_inputinstid from eg_installment_master where id_module=v_moduleid and description=in_billingcycle and installment_type ='Quarterly';

	if(v_inputinstid is null)then
		--update egwtr_backend_cancelrequest set status='FAILED', error='There is no Billing cycle defined in water system for given value' where id=v_seq_cancelreq;
		raise exception 'There is no Billing cycle defined in water system for given value : %', in_billingcycle;
	end if;

	select d.id into v_inputdemandid from eg_demand d, egwtr_demand_connection dc where dc.demand=d.id and d.is_history='N' and dc.connectiondetails=v_conndetid and d.id_installment=v_inputinstid;

	if(v_inputdemandid is null)then
		--update egwtr_backend_cancelrequest set status='FAILED', error='There is no demand available or bill is not generated for given billing cycle' where id=v_seq_cancelreq;
		raise exception 'There is no demand available or bill is not generated for given billing cycle';
	else
		--getting input billing cycle bill
		select bill.bill_no into v_inputbillnumber from eg_bill bill where bill.id_demand=v_inputdemandid and bill.is_cancelled='N' and bill.module_id=v_moduleid and bill.id_bill_type!=2;

		if (v_inputbillnumber is null) then 
			--update egwtr_backend_cancelrequest set status='FAILED', error='There is no active bill available for given billing cycle' where id=v_seq_cancelreq;
			raise exception 'There is no active bill available for given billing cycle';
		end if;
	end if;

	--getting next billing cycle
	select id, description into v_nextinstid, v_nextbc from eg_installment_master where id_module=v_moduleid and installment_type ='Quarterly' and start_date = (select end_date + INTERVAL '1 SECOND' from eg_installment_master where id_module=v_moduleid and id=v_inputinstid and installment_type ='Quarterly');

	--getting input billing cycle receipts
	select rcpt.receipt_number, rcpt.receipt_date::date into v_inputrcptnumber, v_inputrcptdate from eg_demand_details dd, egdm_collected_receipts rcpt where rcpt.status='A' and dd.id_demand=v_inputdemandid and dd.id=rcpt.id_demand_detail order by rcpt.receipt_date limit 1;

	if (v_inputrcptnumber is not null) then 
		v_inputrcptavailable:=true;
	end if;

	--getting next billing cycle demand
	select d.id into v_nextdemandid from eg_demand d, egswtax_demand_connection dc where dc.demand=d.id and d.is_history='N' and dc.applicationdetail=v_conndetid and d.id_installment=v_nextinstid order by id desc limit 1;

	if (v_nextdemandid is not null) then 
		v_nextdemandavailable:=true;

		--getting next billing cycle bill
		select bill.bill_no, bill.issue_date::date into v_nextbillnumber, v_nextbilldate from eg_bill bill where bill.id_demand=v_nextdemandid and bill.is_cancelled='N' and bill.module_id=v_moduleid and bill.id_bill_type!=2;

		if (v_nextbillnumber is not null) then 
			v_nextbillavailable:=true;
		end if;

		--getting next billing cycle receipts
		select rcpt.receipt_number, rcpt.receipt_date::date into v_nextrcptnumber, v_nextrcptdate from eg_demand_details dd, egdm_collected_receipts rcpt where rcpt.status='A' and dd.id_demand=v_nextdemandid and dd.id=rcpt.id_demand_detail order by rcpt.receipt_date limit 1;

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
		--update egwtr_backend_cancelrequest set status='FAILED', error=v_nextrcptnumber where id=v_seq_cancelreq;
		return 0;
	end if;

	if (v_inputrcptavailable=false and v_nextdemandavailable=false and v_nextbillavailable=false and v_nextbillavailable=false and v_nextrcptavailable=false) then

		select dd.id into v_penaltydemanddetailid from eg_demand_details dd,eg_demand d, eg_installment_master inst, eg_demand_reason_master drm, eg_demand_reason dr where dd.id_demand = v_inputdemandid and dd.id_demand_reason = (select id from eg_demand_reason where id_demand_reason_master = (select id from eg_demand_reason_master where code = 'PENALTY' and module = (select id from eg_module where name = 'Water Tax Management')) and id_installment = v_inputinstid );

		if (v_penaltydemanddetailid is not null) then
			update eg_demand_details set amount = 0, remarks = 'made amount 0 as part of bill cancellation from procedure' where id = v_penaltydemanddetailid and amt_collected = 0;
		end if;

		update eg_bill set is_cancelled='Y' where bill_no=v_inputbillnumber;
		--update egwtr_backend_cancelrequest set status='SUCCESS' where id=v_seq_cancelreq;
		raise notice 'Requested bill succesfully cancelled';
	end if;
	
	return v_retval;
END;
$BODY$ LANGUAGE plpgsql;

