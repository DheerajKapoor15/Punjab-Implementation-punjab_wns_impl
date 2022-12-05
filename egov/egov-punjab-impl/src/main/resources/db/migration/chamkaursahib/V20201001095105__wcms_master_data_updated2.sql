--Master cleanup

delete from egwtr_watercharge_rates;


--Non metered rates
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='DOMESTIC'), null, null, null, null, '2018-04-01', '2019-09-30', null, 413, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='COMMERCIAL'), null, null, null, null, '2018-04-01', '2019-09-30', null, 1240, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='INSTITUTIONAL'), null, null, null, null, '2018-04-01', '2019-09-30', null, 1240, now(), now(), 1, 1, 0);


--New Rates

INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='DOMESTIC'), null, null, null, null, '2019-10-01', '2020-09-30', null, 456, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='COMMERCIAL'), null, null, null, null, '2019-10-01', '2020-09-30', null, 1362, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='INSTITUTIONAL'), null, null, null, null, '2019-10-01', '2021-03-31', null, 1362, now(), now(), 1, 1, 0);

--New Updated for Comm Rates COMMERCIAL DOMESTIC only

INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='DOMESTIC'), null, null, null, null, '2020-10-01', '2021-09-30', null, 501, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='COMMERCIAL'), null, null, null, null, '2019-10-01', '2021-09-30', null, 1503, now(), now(), 1, 1, 0);
