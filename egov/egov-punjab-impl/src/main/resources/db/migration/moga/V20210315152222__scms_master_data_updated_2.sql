update egswtax_seweragecharge_rates set effectivetodate='2018-01-01' where usagetype =(select id from egswtax_usage_type where name='DOMESTIC_NSLC');


INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, 
fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'PLOT_BASED', 
(select id from egswtax_usage_type where name='DOMESTIC_NSLC'), 0, null, null, null, '2018-01-01', '2025-03-31', 0,null, now(), now(), 1, 1, 0);


update egswtax_seweragecharge_rates set effectivetodate='2018-01-01' where usagetype =(select id from egswtax_usage_type where name='DOMESTIC_SLC');

INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, 
fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'PLOT_BASED', 
(select id from egswtax_usage_type where name='DOMESTIC_SLC'), 0, null, null, null, '2018-01-01', '2025-03-31', 15, null, now(), now(), 1, 1, 0);

update egswtax_seweragecharge_rates set effectivetodate='2018-01-01' where usagetype =(select id from egswtax_usage_type where name='COMMERCIAL_NSLC');

INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, 
fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'PLOT_BASED', 
(select id from egswtax_usage_type where name='COMMERCIAL_NSLC'), 0, null, null, null, '2018-01-01', '2025-03-31', 0, null, now(), now(), 1, 1, 0);

update egswtax_seweragecharge_rates set effectivetodate='2018-01-01' where usagetype =(select id from egswtax_usage_type where name='COMMERCIAL_SLC');

INSERT INTO egswtax_seweragecharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnoofseats, tonoofseats, effectivefromdate, effectivetodate, rateamount, 
fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_seweragecharge_rates'), 'PLOT_BASED', 
(select id from egswtax_usage_type where name='COMMERCIAL_SLC'), 0, null, null, null, '2018-01-01', '2025-03-31', 15, null, now(), now(), 1, 1, 0);

