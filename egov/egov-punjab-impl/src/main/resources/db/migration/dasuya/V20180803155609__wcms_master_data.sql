--Master cleanup
delete from egwtr_property_category;
delete from egwtr_category;
delete from egwtr_property_pipe_size;
delete from egwtr_pipesize;
delete from egwtr_property_usage;
delete from egwtr_watercharge_rates;
delete from egwtr_usage_type;
delete from egwtr_property_type;
delete from egwtr_water_source;


--Water Source
INSERT INTO egwtr_water_source(id, code, watersourcetype, description, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_water_source'), 'GROUNDWATER', 'Ground Water', 'Ground Water', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_water_source(id, code, watersourcetype, description, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_water_source'), 'CANALWATER', 'Canal Water', 'Canal Water', true, now(), now(), 1, 1, 0);


--Usage Type
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'DOMESTIC', 'USAGE_DOM', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'COMMERCIAL', 'USAGE_COMM', true, now(), now(), 1, 1, 0);

--Property Type
INSERT INTO egwtr_property_type(id, name, code, connectioneligibility, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_type'), 'Residential', 'RESD', 'Y', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_type(id, name, code, connectioneligibility, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_type'), 'Non Residential', 'NON_RESD', 'Y', true, now(), now(), 1, 1, 0);

--Property Type Usage Type
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_usage_type where name='DOMESTIC'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='DOMESTIC'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='COMMERCIAL'), true, now(), now(), 1, 1, 0);

--Pipe Size
INSERT INTO egwtr_pipesize(id, code, sizeininch, sizeinmilimeter, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_pipesize'), 'QT_INCH(1/4)', 0.25, 6.35, true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_pipesize(id, code, sizeininch, sizeinmilimeter, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_pipesize'), 'HALF_INCH(1/2)', 0.5, 12.7, true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_pipesize(id, code, sizeininch, sizeinmilimeter, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_pipesize'), 'THREEQT_INCH(3/4)', 0.75, 19.05, true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_pipesize(id, code, sizeininch, sizeinmilimeter, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_pipesize'), 'ONE_INCH(1)', 1, 25.4, true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_pipesize(id, code, sizeininch, sizeinmilimeter, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_pipesize'), 'ONENHALF_INCH(1.5)', 1.5, 38.1, true, now(), now(), 1, 1, 0);

--Property Type Pipe Size
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_pipesize where code='QT_INCH(1/4)'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_pipesize where code='HALF_INCH(1/2)'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_pipesize where code='THREEQT_INCH(3/4)'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_pipesize where code='ONE_INCH(1)'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_pipesize where code='ONENHALF_INCH(1.5)'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_pipesize where code='QT_INCH(1/4)'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_pipesize where code='HALF_INCH(1/2)'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_pipesize where code='THREEQT_INCH(3/4)'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_pipesize where code='ONE_INCH(1)'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_pipesize where code='ONENHALF_INCH(1.5)'), true, now(), now(), 1, 1, 0);

--Category
INSERT INTO egwtr_category(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_category'), 'General', 'GEN', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_category(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_category'), 'Below Poverty Line', 'BPL', true, now(), now(), 1, 1, 0);

--Property Type Category
INSERT INTO egwtr_property_category(id, propertytype, categorytype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_category'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_category where name='General'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_category(id, propertytype, categorytype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_category'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_category where name='Below Poverty Line'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_category(id, propertytype, categorytype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_category'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_category where name='General'), true, now(), now(), 1, 1, 0);

--Non metered rates
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='DOMESTIC'), 0, 125, null, null, '2018-04-01', '2020-03-31', 0, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='DOMESTIC'), 126, 250, null, null, '2018-04-01', '2020-03-31', 315, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='DOMESTIC'), 251, null, null, null, '2018-04-01', '2020-03-31', 315, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='COMMERCIAL'), 0, 125, null, null, '2018-04-01', '2020-03-31', 630, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='COMMERCIAL'), 126, 250, null, null, '2018-04-01', '2020-03-31', 630, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='COMMERCIAL'), 251, null, null, null, '2018-04-01', '2020-03-31', 630, null, now(), now(), 1, 1, 0);
