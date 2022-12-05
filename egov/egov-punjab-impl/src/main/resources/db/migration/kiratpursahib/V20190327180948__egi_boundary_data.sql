delete from eg_boundary;

--City
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, bndryid, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, NULL, 'Kiratpur Sahib Nagar Panchayat', (select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City'), 'Kiratpur Sahib Nagar Panchayat', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, '1', now(), now(), 1, 1, 'ADM_CITY', 0);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, bndryid, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, NULL, 'Kiratpur Sahib Nagar Panchayat', (select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='City'), 'Kiratpur Sahib Nagar Panchayat', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, '1', now(), now(), 1, 1, 'REV_CITY', 0);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, bndryid, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, NULL, 'Kiratpur Sahib Nagar Panchayat', (select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'LOCATION') and name='City'), 'Kiratpur Sahib Nagar Panchayat', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, '1', now(), now(), 1, 1, 'LOC_CITY', 0);

--Revenue Zone
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where name='Kiratpur Sahib Nagar Panchayat' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='City')), 'Zone 1',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone'), 'Zone 1', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'Z1', true, 0);


--Revenue Block
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 1',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 1', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B1', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 2, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 2',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 2', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B2', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 3, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 3',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 3', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B3', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 4, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 4',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 4', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B4', true, 0);





--Revenue Locality
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Kiratpur',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Kiratpur', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KPS_1', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 2, (select id from eg_boundary where code='B2' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Kalyanpur',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Kalyanpur', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KPS_2', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 3, (select id from eg_boundary where code='B3' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Jeowal',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Jeowal', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KPS_3', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 4, (select id from eg_boundary where code='B4' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Bhatoli',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Bhatoli', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KPS_4', true, 0);


--Admin Ward
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where name='Kiratpur Sahib Nagar Panchayat' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward no 1',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward no 1', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'W-1', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 2, (select id from eg_boundary where name='Kiratpur Sahib Nagar Panchayat' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward no 2',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward no 2', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'W-2', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 3, (select id from eg_boundary where name='Kiratpur Sahib Nagar Panchayat' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward no 3',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward no 3', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'W-3', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 4, (select id from eg_boundary where name='Kiratpur Sahib Nagar Panchayat' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward no 4',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward no 4', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'W-4', true, 0);


update eg_boundary set active =true;

