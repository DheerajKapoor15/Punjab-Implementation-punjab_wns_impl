delete from egwtr_billgeneration;

insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 1', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B1'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 1', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B2'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 1', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B3'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 1', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B4'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 1', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B5'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 1', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B6'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 1', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B7'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B8'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B9'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B10'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B11'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B12'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B13'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B14'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B15'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B16'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B17'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B18'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B19'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B20'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B21'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B22'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B23'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B24'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B25'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B26'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B27'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B28'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B29'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B30'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B31'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B32'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B33'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B34'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B35'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B36'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B37'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B38'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B39'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B40'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B41'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B42'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B43'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B44'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B45'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B46'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B47'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B48'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B49'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B50'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B51'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B52'));