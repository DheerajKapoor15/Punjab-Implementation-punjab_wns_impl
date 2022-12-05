--Master cleanup
delete from egswtax_seweragecharge_rates;

--Sewerage rates
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='DOMESTIC'), null, null, 1, null, '2018-04-01', '2020-03-31', 60, null, now(), now(), 1, 1, 0);

INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='COMMERCIAL'), null, null, 1, null, '2018-04-01', '2020-03-31', 120, null, now(), now(), 1, 1, 0);


--Sewerage rates
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='DOMESTIC'), null, null, 1, null, '2020-04-01', '2021-03-31', 150, null, now(), now(), 1, 1, 0);

INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='COMMERCIAL'), null, null, 1, null, '2020-04-01', '2021-03-31', 300, null, now(), now(), 1, 1, 0);



