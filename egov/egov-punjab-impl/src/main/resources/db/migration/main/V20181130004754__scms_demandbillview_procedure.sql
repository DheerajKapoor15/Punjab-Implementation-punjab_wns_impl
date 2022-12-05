CREATE OR REPLACE FUNCTION pbsc_loaddemandbillview()
RETURNS bigint AS
$BODY$
DECLARE
connections record;
installments record;

v_applicationdetailid	bigint;
v_installmentid			bigint;
v_demandid				bigint;
v_billingcycle			varchar(50);
v_currentcharges		double precision;
v_currentchargecoll		double precision;
v_arrearcharges			double precision;
v_arrearchargecoll		double precision;
v_penaltycharges		double precision;
v_penaltycoll			double precision;
v_interestcharges		double precision;
v_interestcoll			double precision;
v_advancecoll			double precision;
v_billdate              timestamp without time zone;
v_billduedate           timestamp without time zone;
v_billamount            double precision;
v_billtype              varchar(16);
v_isbillgenerated       boolean default false;
v_billlastupdatedate    timestamp without time zone;
v_demandlastupdatedate  timestamp without time zone;

BEGIN
		for connections in (select conn.shsc_number, conn.id as connid, cd.id as cdid from egswtax_connection conn, egswtax_applicationdetails cd where conn.id=cd.connection and conn.status='ACTIVE' limit 100)
		loop 
			begin
			v_applicationdetailid := connections.cdid;
			for installments in (select distinct d.id_installment, inst.description from egswtax_demand_connection cdemand, eg_demand d, eg_installment_master inst where cdemand.demand=d.id and d.id_installment=inst.id and cdemand.applicationdetail = v_applicationdetailid)
			loop
				begin
					v_isbillgenerated := false;
					v_installmentid := installments.id_installment;
					v_billingcycle := installments.description;
					select demand.id, demand.modified_date into v_demandid, v_demandlastupdatedate from egswtax_demand_connection dc, eg_demand demand where demand.id=dc.demand and demand.id_installment=v_installmentid and dc.applicationdetail = v_applicationdetailid order by demand.id desc;
					--getting current charges
					select sum(dd.amount), sum(dd.amt_collected) into v_currentcharges, v_currentchargecoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_demandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id and dr.id_installment=v_installmentid and drm.code='SEWERAGETAX';
					--getting arrear charges
					select sum(dd.amount), sum(dd.amt_collected) into v_arrearcharges, v_arrearchargecoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_demandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id and dr.id_installment!=v_installmentid and drm.code='SEWERAGETAX';
					--getting penalty
					select sum(dd.amount), sum(dd.amt_collected) into v_penaltycharges, v_penaltycoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_demandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id  and drm.code = 'PENALTY';
					--getting intereset
					select sum(dd.amount), sum(dd.amt_collected) into v_interestcharges, v_interestcoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_demandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id  and drm.code='INTEREST';
					--getting advance collection
					select sum(dd.amt_collected) into v_advancecoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_demandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id  and drm.code='SEWERAGEADVANCE';
					
					--getting bill details
					select issue_date, last_date, total_amount, bt.name, bill.modified_date into v_billdate, v_billduedate, v_billamount, v_billtype, v_billlastupdatedate from eg_bill bill, eg_bill_type bt where bt.id=bill.id_bill_type and bt.code!='AUTO' and is_cancelled='N' and id_demand=v_demandid;
					if(v_billdate is not null) then
						v_isbillgenerated := true;
					end if;
					insert into egwtr_demandbill_view (consumercode, servicetype, billingcycle, currentcharges, arrearcharges, penalty, interest, currentcollection, arrearcollection, penaltycollection, interestcollection, advancecollection, isbillgenerated, billgenerationdate, billduedate, billamount, billtype, demandlastupdatetime, billlastupdatedtime) values (connections.shsc_number, 'STAX', v_billingcycle, v_currentcharges, v_arrearcharges, v_penaltycharges, v_interestcharges, v_currentchargecoll, v_arrearchargecoll, v_penaltycoll, v_interestcoll, v_advancecoll, v_isbillgenerated, v_billdate, v_billduedate, v_billamount, v_billtype, v_demandlastupdatedate, v_billlastupdatedate);
				EXCEPTION
				WHEN OTHERS THEN
				raise notice 'pbsc_loaddemandbillview, installments : % %', SQLERRM, SQLSTATE;
				end;
			end loop;
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'pbsc_loaddemandbillview connections : % %', SQLERRM, SQLSTATE;
			END;
		END LOOP;
	return 1;
END;
$BODY$ LANGUAGE plpgsql;