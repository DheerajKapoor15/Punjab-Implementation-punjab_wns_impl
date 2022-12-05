
--Non metered rates for commercial

INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, 
fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED',
(select id from egwtr_usage_type where name='COMMERCIAL'), 0, 50, null, null, '2020-04-01', '2025-04-01', 630, null, now(), now(), 1, 1, 0);

INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, 
fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED',
(select id from egwtr_usage_type where name='COMMERCIAL'), 51, null, null, null, '2020-04-01', '2025-04-01', 840, null, now(), now(), 1, 1, 0);