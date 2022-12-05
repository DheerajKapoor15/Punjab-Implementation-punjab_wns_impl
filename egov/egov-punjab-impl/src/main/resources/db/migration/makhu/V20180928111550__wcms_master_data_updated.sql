--Master cleanup

delete from egwtr_watercharge_rates;


--Non metered rates
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='DOMESTIC'), 0, 125, null, null, '2001-05-01', '2020-03-31', 0, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='DOMESTIC'), 126, null, null, null, '2001-05-01', '2020-03-31', 90, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='COMMERCIAL'), 0, null, null, null, '2001-05-01', '2020-03-31', 180, null, now(), now(), 1, 1, 0);

