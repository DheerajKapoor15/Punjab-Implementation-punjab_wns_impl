--Master cleanup

delete from egwtr_watercharge_rates;


--Non metered rates
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='DOMESTIC'), null, null, null, null, '2014-01-06', '2020-03-31', 315, 315, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='COMMERCIAL'), null, null, null, null, '2014-01-06', '2020-03-31', 420, 420, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='INSTITUTIONAL'), null, null, null, null, '2014-01-06', '2020-03-31', 420, 420, now(), now(), 1, 1, 0);


