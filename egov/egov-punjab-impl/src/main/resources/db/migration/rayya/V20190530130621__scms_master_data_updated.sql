
--Master cleanup
delete from egswtax_seweragecharge_rates;


--Sewerage rates
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='DOMESTIC'), null, null, 1, null, '2018-04-01', '2020-03-31', 315, null, now(), now(), 1, 1, 0);

INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='COMMERCIAL'), null, null, 1, null, '2018-04-01', '2020-03-31', 630, null, now(), now(), 1, 1, 0);

INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'SEAT_BASED', (select id from egswtax_usage_type where name='INSTITUTIONAL'), null, null, 1, null, '2018-04-01', '2020-03-31', 840, null, now(), now(), 1, 1, 0);