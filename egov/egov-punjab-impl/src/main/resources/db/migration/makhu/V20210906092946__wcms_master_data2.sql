--update end date of old rates
update egwtr_watercharge_rates set effectivetodate='2020-03-31' where effectivetodate='2023-03-31';


--new rates
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='DOMESTIC'), 0, null, null, null, '2020-04-01', '2025-03-31', 315, null, now(), now(), 1, 1, 0);

INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='COMMERCIAL'), 0, null, null, null, '2020-04-01', '2025-03-31', 630, null, now(), now(), 1, 1, 0);