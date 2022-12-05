--Master cleanup

delete from egwtr_watercharge_rates;


--Non metered rates
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='DOMESTIC'), null, null, null, null, '2018-04-01', '2020-03-31', 0, 315, now(), now(), 1, 1, 0);
