--Master cleanup
delete from egswtax_seweragecharge_rates;


--Sewerage rates
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'FIXED', (select id from egswtax_usage_type where name='DOMESTIC'), null, null, null, null, '2014-01-06', '2020-03-31', 315,315, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'FIXED', (select id from egswtax_usage_type where name='COMMERCIAL'), null, null, null, null, '2014-01-06', '2020-03-31', 420, 420, now(), now(), 1, 1, 0);
INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'FIXED', (select id from egswtax_usage_type where name='INSTITUTIONAL'), null, null, null, null, '2014-01-06', '2020-03-31', 420, 420, now(), now(), 1, 1, 0);


