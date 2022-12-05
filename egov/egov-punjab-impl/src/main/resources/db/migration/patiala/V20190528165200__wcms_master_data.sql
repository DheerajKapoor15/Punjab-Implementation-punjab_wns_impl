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
delete from egwtr_billgeneration;

--Water Source
INSERT INTO egwtr_water_source(id, code, watersourcetype, description, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_water_source'), 'GROUNDWATER', 'Ground Water', 'Ground Water', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_water_source(id, code, watersourcetype, description, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_water_source'), 'CANALWATER', 'Canal Water', 'Canal Water', true, now(), now(), 1, 1, 0);

--Usage Type
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'DOMESTIC_EXEMPTED', 'USAGE_DOM_EXEMPTED', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'DOMESTIC', 'USAGE_DOM', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'COMMERCIAL', 'USAGE_COMM', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'INSTITUTIONAL', 'USAGE_INST', true, now(), now(), 1, 1, 0);


--Property Type
INSERT INTO egwtr_property_type(id, name, code, connectioneligibility, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_type'), 'Residential', 'RESD', 'Y', true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_type(id, name, code, connectioneligibility, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_type'), 'Non Residential', 'NON_RESD', 'Y', true, now(), now(), 1, 1, 0);

--Property Type Usage Type
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_usage_type where name='DOMESTIC_EXEMPTED'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_usage_type where name='DOMESTIC'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='DOMESTIC'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='COMMERCIAL'), true, now(), now(), 1, 1, 0);
INSERT INTO egwtr_property_usage(id, propertytype, usagetype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_property_usage'), (select id from egwtr_property_type where name='Non Residential'), (select id from egwtr_usage_type where name='INSTITUTIONAL'), true, now(), now(), 1, 1, 0);

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


--bill batch
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 1', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B1'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B2'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B3'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B4'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B5'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 6', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B6'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 7', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B7'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 8', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B8'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 9', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B9'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 10', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B10'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 11', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B11'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 12', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B12'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 13', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B13'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 14', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B14'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 15', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B15'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 16', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B16'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 17', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B17'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 18', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B18'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 19', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B19'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 20', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B20'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 21', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B21'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 22', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B22'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 23', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B23'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 24', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B24'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 25', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B25'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 26', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B26'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 27', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B27'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 28', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B28'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 29', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B29'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 30', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B30'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 31', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B31'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 32', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B32'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 33', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B33'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 34', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B34'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 35', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B35'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 36', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B36'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 37', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B37'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 38', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B38'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 39', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B39'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 40', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B40'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 41', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B41'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 42', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B42'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 43', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B43'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 44', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B44'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 45', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B45'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 46', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B46'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 47', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B47'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 48', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B48'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 49', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B49'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 50', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B50'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 51', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B51'));
