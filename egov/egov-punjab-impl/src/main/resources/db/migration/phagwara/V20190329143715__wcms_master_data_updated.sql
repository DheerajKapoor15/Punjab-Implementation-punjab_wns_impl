


--bill batch

insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 52', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B52'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 53', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B53'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 54', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B54'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 55', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B55'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 56', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B56'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 57', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B57'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 58', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B58'));


