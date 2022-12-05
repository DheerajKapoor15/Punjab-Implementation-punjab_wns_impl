--Master cleanup
delete from egswtax_seweragecharge_rates;


--Usage Type
INSERT INTO egswtax_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_usage_type'), 'DOMESTIC_above251', 'USAGE_DOM_251', true, now(), now(), 1, 1, 0);



--Sewerage rates
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='DOMESTIC'), null, null, 0, 0, '2018-04-01', '2020-03-31', 0, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='DOMESTIC'), null, null, 1, 1, '2018-04-01', '2020-03-31', 300, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='DOMESTIC'), null, null, 2, 2, '2018-04-01', '2020-03-31', 600, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='DOMESTIC'), null, null, 3, null, '2018-04-01', '2020-03-31', 900, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='DOMESTIC_above251'), null, null, 1, 2, '2018-04-01', '2020-03-31', 390, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='DOMESTIC_above251'), null, null, 2, 2, '2018-04-01', '2020-03-31', 780, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='DOMESTIC_above251'), null, null, 3, null, '2018-04-01', '2020-03-31', 1170, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='COMMERCIAL'), null, null, 1, 1, '2018-04-01', '2020-03-31', 390, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='COMMERCIAL'), null, null, 2, 2, '2018-04-01', '2020-03-31', 780, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='COMMERCIAL'), null, null, 3, null, '2018-04-01', '2020-03-31', 1170, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='INSTITUTIONAL'), null, null, 1, 1, '2018-04-01', '2020-03-31', 390, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='INSTITUTIONAL'), null, null, 2, 2, '2018-04-01', '2020-03-31', 780, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES(nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='INSTITUTIONAL'), null, null, 3, null, '2018-04-01', '2020-03-31', 1170, null, now(), now(), 1, 1, 0);
