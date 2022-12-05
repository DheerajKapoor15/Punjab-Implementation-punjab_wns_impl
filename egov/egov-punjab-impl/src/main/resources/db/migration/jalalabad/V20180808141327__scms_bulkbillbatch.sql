delete from egswtax_billgeneration;

insert into egswtax_billgeneration (batchname, boundarytype, boundary) values ('Batch1', 'Block', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block') and code='B1'));
