delete from egwtr_billgeneration;

insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch1', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-1'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch2', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-2'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch3', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-3'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch4', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-4'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch5', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-5'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch6', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-6'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch7', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-7'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch8', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-8'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch9', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-9'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch10', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-10'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch11', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-11'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch12', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-12'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch13', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-13'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch14', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-14'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch15', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-15'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch16', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-16'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch17', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-17'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch18', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-18'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch19', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-19'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch20', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-20'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch21', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-21'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch22', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-22'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch23', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-23'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch24', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-24'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch25', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-25'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch26', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-26'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch27', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-27'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch28', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-28'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch29', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-29'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch30', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-30'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch31', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-31'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch32', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-32'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch33', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-33'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch34', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-34'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch35', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-35'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch36', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='LC-36'));
