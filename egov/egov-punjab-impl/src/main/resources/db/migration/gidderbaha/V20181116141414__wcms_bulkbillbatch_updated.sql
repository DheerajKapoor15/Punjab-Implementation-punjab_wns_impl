delete from egwtr_billgeneration;

insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 1','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD1'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD2'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD3'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD4'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD5'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 6','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD6'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 7','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD7'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 8','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD8'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 9','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD9'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 10','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD10'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 11','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD11'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 12','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD12'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 13','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD13'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 14','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD14'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 15','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD15'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 16','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD16'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 17','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD17'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 18','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD18'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 19','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD19'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 20','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD20'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 21','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD21'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 22','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD22'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 23','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD23'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 24','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD24'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 25','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD25'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 26','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD26'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 27','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD27'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 28','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD28'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 29','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD29'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 30','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD30'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 31','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD31'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 32','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD32'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 33','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD33'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 34','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD34'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 35','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD35'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 36','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD36'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 37','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD37'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 38','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD38'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 39','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD39'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 40','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD40'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 41','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD41'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 42','Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GD42'));
