--Master cleanup
delete from egswtax_seweragecharge_rates;
delete from egswtax_usage_type;

--Usage Type
INSERT INTO egswtax_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_usage_type'), 'DOMESTIC', 'USAGE_DOM', true, now(), now(), 1, 1, 0);
INSERT INTO egswtax_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_usage_type'), 'COMMERCIAL', 'USAGE_COMM', true, now(), now(), 1, 1, 0);
INSERT INTO egswtax_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_usage_type'), 'INSTITUTIONAL', 'USAGE_INST', true, now(), now(), 1, 1, 0);


--Sewerage rates
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'FIXED', (select id from egswtax_usage_type where name='DOMESTIC'), null, null, null, null, '2014-01-06', '2020-03-31', 315, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'FIXED', (select id from egswtax_usage_type where name='COMMERCIAL'), null, null, null, null, '2014-01-06', '2020-03-31', 420, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'FIXED', (select id from egswtax_usage_type where name='INSTITUTIONAL'), null, null, null, null, '2014-01-06', '2020-03-31', 420, null, now(), now(), 1, 1, 0);


