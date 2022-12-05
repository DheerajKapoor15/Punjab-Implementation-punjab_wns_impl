delete from egswtax_billgeneration;

insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 1', 'Block 1', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B1'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block 2', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B2'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block 3', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B3'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block 4', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B4'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block 5', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B5'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 6', 'Block 6', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B6'));

