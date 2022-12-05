
--OIS_Met usage type
--ois_dom
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'OIS_Metered_Dom', 'USAGE_OIS_Met_Dom', true, now(), now(), 1, 1, 0);
--ois_comm
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'OIS_Metered_Comm', 'USAGE_OIS_Met_Comm', true, now(), now(), 1, 1, 0);

--Metered Rates
--dom
insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'OIS_Metered_Dom'),1,null,'2020-09-20', '2023-03-31',3.80,null,now(),now(),1,1);
--com
insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'OIS_Metered_Comm'),1,null,'2020-09-20', '2023-03-31',7.60,null,now(),now(),1,1);

--Metered Property Type
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_usage_type where name='OIS_Metered_Dom'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='OIS_Metered_Dom'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='OIS_Metered_Comm'), true, now(), now(), 1, 1, 0);

-----------------OIS_NM------------------------
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'OIS_NM_1HP_Dom', 'USAGE_OIS_NM_1HP_D', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'OIS_NM_1HP_Comm', 'USAGE_OIS_NM_1HP_C', true, now(), now(), 1, 1, 0);
------
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'OIS_NM_2HP_Dom', 'USAGE_OIS_NM_2HP_D', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'OIS_NM_2HP_Comm','USAGE_OIS_NM_2HP_C', true, now(), now(), 1, 1, 0);
------
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'OIS_NM_3HP_Dom', 'USAGE_OIS_NM_3HP_D', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'OIS_NM_3HP_Comm', 'USAGE_OIS_NM_3HP_C', true, now(), now(), 1, 1, 0);
------
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'OIS_NM_4HP_Dom', 'USAGE_OIS_NM_4HP_D', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'OIS_NM_4HP_Comm', 'USAGE_OIS_NM_4HP_C', true, now(), now(), 1, 1, 0);
------
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES 
(nextval('seq_egwtr_usage_type'), 'OIS_NM_5HP_Dom', 'USAGE_OIS_NM_5HP_D', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES 
(nextval('seq_egwtr_usage_type'), 'OIS_NM_5HP_Comm', 'USAGE_OIS_NM_5HP_C', true, now(), now(), 1, 1, 0);
-------

--Non metered water rates
--dom rates
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='OIS_NM_1HP_Dom'), 0, null, null, null, '2020-07-01', '2023-03-31', 507, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='OIS_NM_2HP_Dom'), 0, null, null, null, '2020-07-01', '2023-03-31', 1293, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='OIS_NM_3HP_Dom'), 0, null, null, null, '2020-07-01', '2023-03-31', 1629, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='OIS_NM_4HP_Dom'), 0, null, null, null, '2020-07-01', '2023-03-31', 1797, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='OIS_NM_5HP_Dom'), 0, null, null, null, '2020-07-01', '2023-03-31', 2808, null, now(), now(), 1, 1, 0);


--commercial rates

INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='OIS_NM_1HP_Comm'), 0, null, null, null, '2020-07-01', '2023-03-31', 507, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='OIS_NM_2HP_Comm'), 0, null, null, null, '2020-07-01', '2023-03-31', 1293, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='OIS_NM_3HP_Comm'), 0, null, null, null, '2020-07-01', '2023-03-31', 1629, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='OIS_NM_4HP_Comm'), 0, null, null, null, '2020-07-01', '2023-03-31', 1797, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='OIS_NM_5HP_Comm'), 0, null, null, null, '2020-07-01', '2023-03-31', 2808, null, now(), now(), 1, 1, 0);

--Property Type Usage Type NM water
--1HP
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_usage_type where name='OIS_NM_1HP_Dom'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='OIS_NM_1HP_Dom'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='OIS_NM_1HP_Comm'), true, now(), now(), 1, 1, 0);
--2HP
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_usage_type where name='OIS_NM_2HP_Dom'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='OIS_NM_2HP_Dom'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='OIS_NM_2HP_Comm'), true, now(), now(), 1, 1, 0);
--3HP
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_usage_type where name='OIS_NM_3HP_Dom'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='OIS_NM_3HP_Dom'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='OIS_NM_3HP_Comm'), true, now(), now(), 1, 1, 0);
--4HP
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_usage_type where name='OIS_NM_4HP_Dom'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='OIS_NM_4HP_Dom'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='OIS_NM_4HP_Comm'), true, now(), now(), 1, 1, 0);
--5HP
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_usage_type where name='OIS_NM_5HP_Dom'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='OIS_NM_5HP_Dom'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='OIS_NM_5HP_Comm'), true, now(), now(), 1, 1, 0);







