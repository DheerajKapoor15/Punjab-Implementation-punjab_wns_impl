delete from egswtax_billgeneration;

insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch1', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B1'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch1', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B2'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B3'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B4'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B5'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B6'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B7'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B8'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B9'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B10'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch6', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B11'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch6', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B12'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch7', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B13'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch7', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B14'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch8', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B15'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch8', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B16'));
