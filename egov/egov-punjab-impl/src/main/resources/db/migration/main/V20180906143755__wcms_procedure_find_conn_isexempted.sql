create or replace FUNCTION pbwc_isconnexempted(in_connectionNo IN varchar(50))  
RETURNS boolean as $$
declare
	v_usage 	bigint;  
	v_plotarea	double precision;
	v_billingtype varchar(50);
	v_billamount  double precision;
	v_plotsize	double precision;
	is_exempted boolean default false;
BEGIN 
	--raise notice 'pbwc_isconnexempted in_connectionNo (%)', in_connectionNo;
	select cd.usagetype, cd.billingtype, coalesce(billamount, 0), plotsize into v_usage, v_billingtype, v_billamount, v_plotsize from egwtr_connection conn, egwtr_connectiondetails cd where cd.connection=conn.id and conn.consumercode=in_connectionNo;
	select coalesce(toplotarea, 0)::double precision into v_plotarea from egwtr_watercharge_rates where usagetype=v_usage and rateamount=0 limit 1;
	raise notice 'pbwc_isconnexempted v_usage, v_billingtype, v_billamount, v_plotsize, v_plotarea (% % % % %)', v_usage, v_billingtype, v_billamount, v_plotsize, v_plotarea;
	if (v_billingtype='CUSTOM') then
		if (v_billamount=0) then
			is_exempted := true;
		end if;
	elsif (v_billingtype='STANDARD') then
		if (v_plotsize<=v_plotarea) then
			is_exempted := true;
		end if;
	end if;
	return is_exempted;
EXCEPTION
WHEN OTHERS THEN
raise notice 'pbwc_isconnexempted : % %', SQLERRM, SQLSTATE;
END;  
$$ LANGUAGE plpgsql;
