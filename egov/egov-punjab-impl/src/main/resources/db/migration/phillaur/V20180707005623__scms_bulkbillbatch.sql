delete from egswtax_billgeneration;

insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 1', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B1'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B2'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B3'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B4'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B5'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 6', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B6'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 7', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B7'));
insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch 8', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B8'));


