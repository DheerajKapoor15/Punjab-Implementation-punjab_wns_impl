
--Usage Type
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'DOMESTIC0', 'USAGE_DOM0', true, now(), now(), 1, 1, 0);


--Property Type Usage Type
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_usage_type where name='DOMESTIC0'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='DOMESTIC0'), true, now(), now(), 1, 1, 0);

--Non metered rates
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'FIXED', (select id from egwtr_usage_type where name='DOMESTIC0'), null, null, null, null, '2018-04-01', '2020-03-31', null, 0, now(), now(), 1, 1, 0);

