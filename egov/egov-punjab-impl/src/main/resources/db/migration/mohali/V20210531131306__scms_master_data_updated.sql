--add new sew Usage Type
INSERT INTO egswtax_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_usage_type'), 'DOMESTIC_EXEMPTED', 'USAGE_DOM_EXEM', true, now(), now(), 1, 1, 0);

--Sewerage rates with new usage type
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='DOMESTIC_EXEMPTED'), null, null, null, null, '2021-05-31', '2025-03-31', 0, null, now(), now(), 1, 1, 0);


