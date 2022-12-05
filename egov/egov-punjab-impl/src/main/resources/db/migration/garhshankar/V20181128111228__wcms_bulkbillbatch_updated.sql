delete from egwtr_billgeneration;

insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 1', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_1'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 2', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_2'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 3', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_3'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 4', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_4'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 5', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_5'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 6', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_6'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 7', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_7'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 8', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_8'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 9', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_9'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 10', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_10'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 11', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_11'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 12', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_12'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 13', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_13'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 14', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_14'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 15', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_15'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 16', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_16'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 17', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_17'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 18', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_18'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 19', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_19'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 20', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_20'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 21', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_21'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 22', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_22'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 23', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_23'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 24', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_24'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 25', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_25'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 26', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_26'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 27', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_27'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 28', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_28'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 29', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_29'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 30', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_30'));
insert into egwtr_billgeneration (batchname, boundarytype, boundary) values ('Batch 31', 'Locality', (select id from eg_boundary where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='GSK_31'));
