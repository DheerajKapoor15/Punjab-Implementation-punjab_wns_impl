delete from egwtr_watercharge_rates;

--Non metered rates
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='DOMESTIC'), 0, 125, null, null, '2003-07-01', '2020-06-30', 0, 0, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='DOMESTIC'), 126, 250, null, null, '2003-07-01', '2020-06-30', 300, 300, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='DOMESTIC'), 251, 500, null, null, '2003-07-01', '2020-06-30', 400, 400, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='DOMESTIC'), 501, null, null, null, '2003-07-01', '2020-06-30', 800, 800, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='COMMERCIAL'), 0, 250, null, null, '2003-07-01', '2020-06-30', 570, 570, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='COMMERCIAL'), 251, 500, null, null, '2003-07-01', '2020-06-30', 800, 800, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='COMMERCIAL'), 501, null, null, null, '2003-07-01', '2020-06-30', 1600, 1600, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='INSTITUTIONAL'), 0, null, null, null, '2003-07-01', '2020-06-30', 1600, 1600, now(), now(), 1, 1, 0);
