update eg_boundary set name=localname where code in ('LC-58','LC-69','LC-67','LC-68','LC-112','LC-61','LC-114','LC-84','LC-34','LC-91','LC-73');

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 189, (select id from eg_boundary where code='B2' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Karnail Singh Gate',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Karnail Singh Gate', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'LC-189', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 190, (select id from eg_boundary where code='B4' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Thapar Colony',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Thapar Colony', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'LC-190', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 191, (select id from eg_boundary where code='B8' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Kacha Malak Road',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Kacha Malak Road', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'LC-191', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 192, (select id from eg_boundary where code='B9' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Heera Bagh',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Heera Bagh', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'LC-192', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 193, (select id from eg_boundary where code='B9' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Royal City',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Royal City', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'LC-193', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 194, (select id from eg_boundary where code='B10' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Mahavir Enclave',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Mahavir Enclave', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'LC-194', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 195, (select id from eg_boundary where code='B10' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Madhuban Enclave',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Madhuban Enclave', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'LC-195', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 196, (select id from eg_boundary where code='B12' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Gali Telephone Exchange Wali',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Gali Telephone Exchange Wali', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'LC-196', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 197, (select id from eg_boundary where code='B14' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'East Moti Bagh',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'East Moti Bagh', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'LC-197', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 198, (select id from eg_boundary where code='B16' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Agwad Ladhai',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Agwad Ladhai', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'LC-198', true, 0);