--Master cleanup
delete from egswtax_seweragecharge_rates;
delete from egswtax_usage_type;

--Usage Type
INSERT INTO egswtax_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_usage_type'), 'Domestic', 'USAGE_DOM', true, now(), now(), 1, 1, 0);
INSERT INTO egswtax_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_usage_type'), 'Commercial', 'USAGE_COMM', true, now(), now(), 1, 1, 0);
INSERT INTO egswtax_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_usage_type'), 'Institutional', 'USAGE_INST', true, now(), now(), 1, 1, 0);


--Sewerage rates
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'PLOT_BASED', (select id from egswtax_usage_type where name='Domestic'), 0, 125, null, null, '2018-4-1', '2020-3-31', 0, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'PLOT_BASED', (select id from egswtax_usage_type where name='Domestic'), 126, 250, null, null, '2018-4-1', '2020-3-31', 315, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'PLOT_BASED', (select id from egswtax_usage_type where name='Domestic'), 251, null, null, null, '2018-4-1', '2020-3-31', 420, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'PLOT_BASED', (select id from egswtax_usage_type where name='Commercial'), 0, 125, null, null, '2018-4-1', '2020-3-31', 420, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'PLOT_BASED', (select id from egswtax_usage_type where name='Commercial'), 126, 250, null, null, '2018-4-1', '2020-3-31', 1260, null, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'PLOT_BASED', (select id from egswtax_usage_type where name='Commercial'), 251, null, null, null, '2018-4-1', '2020-3-31', 1440, null, now(), now(), 1, 1, 0);

