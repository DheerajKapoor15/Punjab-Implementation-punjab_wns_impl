--Master cleanup
delete from egwtr_property_category;
delete from egwtr_category;
delete from egwtr_property_pipe_size;
delete from egwtr_pipesize;
delete from egwtr_property_usage;
delete from egwtr_watercharge_rates;
delete from egwtr_usage_type;
delete from egwtr_property_type;

--Property Type master
INSERT INTO egwtr_property_type(id, name, code, connectioneligibility, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_type'), 'Residential', 'RESD', 'Y', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_type(id, name, code, connectioneligibility, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_type'), 'Non Residential', 'NON_RESD', 'Y', true, now(), now(), 1, 1, 0);

--Usage Master
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'DOMESTIC', 'USAGE_DOM', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'COMMERCIAL', 'USAGE_COMM', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'INSTITUTIONAL', 'USAGE_INST', true, now(), now(), 1, 1, 0);

--Ferrule size
INSERT INTO egwtr_pipesize(id, code, sizeininch, sizeinmilimeter, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_pipesize'), 'QT_INCH', 0.25, 6.35, true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_pipesize(id, code, sizeininch, sizeinmilimeter, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_pipesize'), 'HALF_INCH', 0.5, 12.7, true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_pipesize(id, code, sizeininch, sizeinmilimeter, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_pipesize'), 'THREEQT_INCH', 0.75, 19.05, true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_pipesize(id, code, sizeininch, sizeinmilimeter, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_pipesize'), 'ONE_INCH', 1, 25.4, true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_pipesize(id, code, sizeininch, sizeinmilimeter, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_pipesize'), 'ONENHALF_INCH', 1.5, 38.1, true, now(), now(), 1, 1, 0);

--category
INSERT INTO egwtr_category(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_category'), 'General', 'GEN', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_category(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_category'), 'Below Poverty Line', 'BPL', true, now(), now(), 1, 1, 0);

--Property Type Usage
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_usage_type where name='DOMESTIC'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='DOMESTIC'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='COMMERCIAL'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='INSTITUTIONAL'), true, now(), now(), 1, 1, 0);

--Property Type Ferrule size
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_pipesize where code='QT_INCH'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_pipesize where code='HALF_INCH'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_pipesize where code='THREEQT_INCH'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_pipesize where code='ONE_INCH'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_pipesize where code='ONENHALF_INCH'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_pipesize where code='QT_INCH'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_pipesize where code='HALF_INCH'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_pipesize where code='THREEQT_INCH'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_pipesize where code='ONE_INCH'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_pipe_size(id, propertytype, pipesize, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_pipesize'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_pipesize where code='ONENHALF_INCH'), true, now(), now(), 1, 1, 0);

--Property Type category
INSERT INTO egwtr_property_category(id, propertytype, categorytype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_category'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_category where name='General'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_category(id, propertytype, categorytype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_category'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_category where name='Below Poverty Line'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_category(id, propertytype, categorytype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_category'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_category where name='General'), true, now(), now(), 1, 1, 0);

--Non metered water rates
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='DOMESTIC'), 0, 125, null, null, '2018-04-01', '2020-03-31', 0, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='DOMESTIC'), 126, null, null, null, '2018-04-01', '2020-03-31', 80, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='COMMERCIAL'), 0, null, null, null, '2018-04-01', '2020-03-31', 160, null, now(), now(), 1, 1, 0);
INSERT INTO egwtr_watercharge_rates(id, ratetype, usagetype, fromplotarea, toplotarea, fromnooftaps, tonooftaps, effectivefromdate, effectivetodate, rateamount, fixedcharges, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_watercharge_rates'), 'PLOT_BASED', (select id from egwtr_usage_type where name='INSTITUTIONAL'), 0, null, null, null, '2018-04-01', '2020-03-31', 160, null, now(), now(), 1, 1, 0);
