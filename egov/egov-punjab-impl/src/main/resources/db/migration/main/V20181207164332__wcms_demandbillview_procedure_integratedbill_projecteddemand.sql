CREATE OR REPLACE FUNCTION pbwc_loaddemandbillview()
RETURNS bigint AS
$BODY$
DECLARE
connections record;
installments record;

v_connectiondetailid	bigint;
v_installmentid			bigint;
v_demandid				bigint;
v_billid				bigint;
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
v_zone					varchar(512);
v_block					varchar(512);
v_locality				varchar(512);
v_projecteddemand		double precision;
v_sbillamount			double precision;
v_sconsumercode			varchar(50);
v_sappid				bigint;
v_sdemandid				bigint;
v_sdemandlastupdatedate	timestamp without time zone;
v_scurrentcharges		double precision;
v_scurrentchargecoll	double precision;
v_sarrearcharges		double precision;
v_sarrearchargecoll		double precision;
v_spenaltycharges		double precision;
v_spenaltycoll			double precision;
v_sinterestcharges		double precision;
v_sinterestcoll			double precision;
v_sadvancecoll			double precision;
v_szone					bigint;
v_sblock				bigint;
v_slocality				bigint;
v_szonename				varchar(512);
v_sblockname			varchar(512);
v_slocalityname			varchar(512);
v_sinstallmentid 		bigint;
v_sprojecteddemand		double precision;
v_sinstallmentenddate	timestamp without time zone;

BEGIN
		for connections in (select conn.consumercode, conn.id as connid, cd.id as cdid, conn.zone, conn.locality, conn.block from egwtr_connection conn, egwtr_connectiondetails cd where conn.id=cd.connection and cd.connectionstatus='ACTIVE')
		loop 
			begin
			v_connectiondetailid := connections.cdid;
			select name into v_zone from eg_boundary where id=connections.zone;
			select name into v_block from eg_boundary where id=connections.block;
			select name into v_locality from eg_boundary where id=connections.locality;
			for installments in (select distinct d.id_installment, inst.description, inst.end_date from egwtr_demand_connection cdemand, eg_demand d, eg_installment_master inst where cdemand.demand=d.id and d.id_installment=inst.id and cdemand.connectiondetails = v_connectiondetailid)
			loop
				begin
					v_isbillgenerated := false;
					v_installmentid := installments.id_installment;
					v_billingcycle := installments.description;
					select demand.id, demand.modified_date into v_demandid, v_demandlastupdatedate from egwtr_demand_connection dc, eg_demand demand where demand.id=dc.demand and demand.id_installment=v_installmentid and dc.connectiondetails = v_connectiondetailid order by demand.id desc;
					--getting current charges
					select sum(dd.amount), sum(dd.amt_collected) into v_currentcharges, v_currentchargecoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_demandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id and dr.id_installment=v_installmentid and drm.code='WTAXCHARGES';
					--getting arrear charges
					select sum(dd.amount), sum(dd.amt_collected) into v_arrearcharges, v_arrearchargecoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_demandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id and dr.id_installment!=v_installmentid and drm.code='WTAXCHARGES';
					--getting penalty
					select sum(dd.amount), sum(dd.amt_collected) into v_penaltycharges, v_penaltycoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_demandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id  and drm.code in ('PENALTY', 'BREAKDOWN_PENALTY');
					--getting intereset
					select sum(dd.amount), sum(dd.amt_collected) into v_interestcharges, v_interestcoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_demandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id  and drm.code='INTEREST';
					--getting advance collection
					select sum(dd.amt_collected) into v_advancecoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_demandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id  and drm.code='WTADVANCE';

					--getting projected demand
					v_projecteddemand := wtms_rates_by_connectiondetails_id_for_non_metered(v_connectiondetailid, installments.end_date::date);
					raise notice 'v_connectiondetailid, installments.end_date::date, v_projecteddemand % % %', v_connectiondetailid, installments.end_date::date, v_projecteddemand;
					
					--getting bill details
					select bill.id, issue_date, last_date, total_amount, bt.name, bill.modified_date into v_billid, v_billdate, v_billduedate, v_billamount, v_billtype, v_billlastupdatedate from eg_bill bill, eg_bill_type bt where bt.id=bill.id_bill_type and bt.code!='AUTO' and is_cancelled='N' and id_demand=v_demandid;
					if(v_billdate is not null) then
						v_isbillgenerated := true;
						if (v_billtype='Integrated') then
							select sconn.shsc_number, sapp.id, sconn.zone, sconn.block, sconn.locality into v_sconsumercode, v_sappid, v_szone, v_sblock, v_slocality from egwtr_connection wconn, egswtax_connection sconn, egswtax_applicationdetails sapp, egswtax_connectiondetail scd where sconn.id=sapp.connection and scd.id=sapp.connectiondetail and scd.wateridentifier=wconn.oldconsumernumber and wconn.consumercode=connections.consumercode;
							if(v_sconsumercode is null)then
								select sconn.shsc_number, sapp.id, sconn.zone, sconn.block, sconn.locality into v_sconsumercode, v_sappid, v_szone, v_sblock, v_slocality from egwtr_connection wconn, egswtax_connection sconn, egswtax_applicationdetails sapp, egswtax_connectiondetail scd where sconn.id=sapp.connection and scd.id=sapp.connectiondetail and scd.wateridentifier=connections.consumercode;
							end if;
							if(v_sconsumercode is not null)then
								select sum(bd.cr_amount) into v_billamount from eg_bill_details bd, eg_demand_reason dr, eg_demand_reason_master drm where bd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id and drm.module=(select id from eg_module where name='Water Tax Management') and id_bill=v_billid;
								select sum(bd.cr_amount) into v_sbillamount from eg_bill_details bd, eg_demand_reason dr, eg_demand_reason_master drm where bd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id and drm.module=(select id from eg_module where name='Sewerage Tax Management') and id_bill=v_billid;
								select id, end_date into v_sinstallmentid, v_sinstallmentenddate from eg_installment_master where description=(select description from eg_installment_master where id=v_installmentid) and id_module=(select id from eg_module where name='Sewerage Tax Management');
								select demand.id, demand.modified_date into v_sdemandid, v_sdemandlastupdatedate from egswtax_demand_connection dc, eg_demand demand where demand.id=dc.demand and demand.id_installment=v_sinstallmentid and dc.applicationdetail = v_sappid order by demand.id desc;
								select name into v_szonename from eg_boundary where id=v_szone;
								select name into v_sblockname from eg_boundary where id=v_sblock;
								select name into v_slocalityname from eg_boundary where id=v_slocality;
								raise notice 'v_szonename, v_sblockname, v_slocalityname % % %',v_szonename, v_sblockname, v_slocalityname;
								--getting sewerage current charges
								select sum(dd.amount), sum(dd.amt_collected) into v_scurrentcharges, v_scurrentchargecoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_sdemandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id and dr.id_installment=v_sinstallmentid and drm.code='SEWERAGETAX';
								--getting sewerage arrear charges
								select sum(dd.amount), sum(dd.amt_collected) into v_sarrearcharges, v_sarrearchargecoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_sdemandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id and dr.id_installment!=v_sinstallmentid and drm.code='SEWERAGETAX';
								--getting sewerage penalty
								select sum(dd.amount), sum(dd.amt_collected) into v_spenaltycharges, v_spenaltycoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_sdemandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id  and drm.code in ('PENALTY');
								--getting sewerage ntereset
								select sum(dd.amount), sum(dd.amt_collected) into v_sinterestcharges, v_sinterestcoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_sdemandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id  and drm.code='INTEREST';
								--getting sewerage advance collection
								select sum(dd.amt_collected) into v_sadvancecoll from eg_demand_details dd, eg_demand_reason dr, eg_demand_reason_master drm where dd.id_demand=v_sdemandid and dd.id_demand_reason=dr.id and dr.id_demand_reason_master=drm.id  and drm.code='SEWERAGEADVANCE';
								raise notice 'v_sadvancecoll %',v_sadvancecoll;
								--getting sewerage projected demand
								v_sprojecteddemand := stms_rates_by_connectiondetails_id(v_sappid, v_sinstallmentid, v_sinstallmentenddate::date);

								insert into egwtr_demandbill_view (consumercode, servicetype, billingcycle, currentcharges, arrearcharges, penalty, interest, currentcollection, arrearcollection, penaltycollection, interestcollection, advancecollection, isbillgenerated, billgenerationdate, billduedate, billamount, billtype, demandlastupdatetime, billlastupdatedtime, demandid, zone, block, locality, projecteddemand) values (v_sconsumercode, 'Sewerage Charges', v_billingcycle, v_scurrentcharges, v_sarrearcharges, v_spenaltycharges, v_sinterestcharges, v_scurrentchargecoll, v_sarrearchargecoll, v_spenaltycoll, v_sinterestcoll, v_sadvancecoll, v_isbillgenerated, v_billdate, v_billduedate, v_sbillamount, v_billtype, v_sdemandlastupdatedate, v_billlastupdatedate, v_sdemandid, v_szonename, v_sblockname, v_slocalityname, v_sprojecteddemand);
							end if;
						end if;
					end if;
					insert into egwtr_demandbill_view (consumercode, servicetype, billingcycle, currentcharges, arrearcharges, penalty, interest, currentcollection, arrearcollection, penaltycollection, interestcollection, advancecollection, isbillgenerated, billgenerationdate, billduedate, billamount, billtype, demandlastupdatetime, billlastupdatedtime, demandid, zone, block, locality, projecteddemand) values (connections.consumercode, 'Water Charges', v_billingcycle, v_currentcharges, v_arrearcharges, v_penaltycharges, v_interestcharges, v_currentchargecoll, v_arrearchargecoll, v_penaltycoll, v_interestcoll, v_advancecoll, v_isbillgenerated, v_billdate, v_billduedate, v_billamount, v_billtype, v_demandlastupdatedate, v_billlastupdatedate, v_demandid, v_zone, v_block, v_locality, v_projecteddemand);
				EXCEPTION
				WHEN OTHERS THEN
				raise notice 'pbwc_demandbillview, installments : % %', SQLERRM, SQLSTATE;
				end;
			end loop;
			EXCEPTION
			WHEN OTHERS THEN
			raise notice 'pbwc_demandbillview connections : % %', SQLERRM, SQLSTATE;
			END;
		END LOOP;
	return 1;
END;
$BODY$ LANGUAGE plpgsql;
