----------Department Data

INSERT INTO eg_department (id, name, createddate, code, createdby, lastmodifiedby, lastmodifieddate, version) VALUES (nextval('SEQ_EG_DEPARTMENT'), 'Accounts', now(), 'A', 1, 1, now(), 0);

INSERT INTO eg_department (id, name, createddate, code, createdby, lastmodifiedby, lastmodifieddate, version) VALUES (nextval('SEQ_EG_DEPARTMENT'), 'Engineering Branch(O&M) - for Water and Sewerage', now(), 'WAS', 1, 1, now(), 0);

----------Designation Data

INSERT INTO eg_designation (id, name, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, code) VALUES (nextval('seq_eg_designation'),'Accountant', 'Accountant', null, 0, now(), now(), 1, 1, 'ACT');

INSERT INTO eg_designation (id, name, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, code) VALUES (nextval('seq_eg_designation'),'Assistant Corporation Engineer', 'Assistant Corporation Engineer (Electrical)', null, 0, now(), now(), 1, 1, 'ACE');


------------Fund Data
INSERT INTO fund (id, code, name, llevel, parentid, isactive, lastmodifieddate, CREATEDDATE, lastmodifiedby, isnotleaf, identifier, purpose_id, createdby, transactioncreditamount) VALUES (nextval('seq_fund'), '01', 'General Municipal Fund', 0, NULL, 'true', now(), now(), 1, 'false', '1', 12, 1,NULL);

------------Function Data
INSERT INTO function (id, code, name, type, llevel, parentid, isactive, CREATEDDATE, lastmodifieddate, lastmodifiedby, isnotleaf, parentcode, createdby)  VALUES (NEXTVAL('seq_function'), '51', 'Water Supply', NULL, 0, NULL, 'true', now(), now(), NULL, 'true', NULL, NULL);

INSERT INTO function (id, code, name, type, llevel, parentid, isactive, CREATEDDATE, lastmodifieddate, lastmodifiedby, isnotleaf, parentcode, createdby)  VALUES (NEXTVAL('seq_function'), '52', 'Sewerage', NULL, 0, NULL, 'true', now(), now(), NULL, 'true', NULL, NULL);

------------Employee Grade Data
INSERT INTO egeis_grade_mstr (grade_id, grade_value, start_date, end_date, age, order_no) VALUES (NEXTVAL('egpims_grade_mstr_seq'), 'A', '0001-04-01 00:00:00 BC', '0001-04-01 00:00:00 BC', 60, NULL);
INSERT INTO egeis_grade_mstr (grade_id, grade_value, start_date, end_date, age, order_no) VALUES (NEXTVAL('egpims_grade_mstr_seq'), 'B', '0001-04-01 00:00:00 BC', '0001-04-01 00:00:00 BC', 60, NULL);
INSERT INTO egeis_grade_mstr (grade_id, grade_value, start_date, end_date, age, order_no) VALUES (NEXTVAL('egpims_grade_mstr_seq'), 'C', '0001-04-01 00:00:00 BC', '0001-04-01 00:00:00 BC', 60, NULL);
INSERT INTO egeis_grade_mstr (grade_id, grade_value, start_date, end_date, age, order_no) VALUES (NEXTVAL('egpims_grade_mstr_seq'), 'D', '0001-04-01 00:00:00 BC', '0001-04-01 00:00:00 BC', 60, NULL);


----------Hierarchy type Data



INSERT INTO eg_hierarchy_type (id, name, code, createddate, lastmodifieddate, createdby, lastmodifiedby, version, localname) VALUES (NEXTVAL('seq_eg_hierarchy_type'), 'ADMINISTRATION', '00003', now(), now(), 1, 1, 0, NULL);


----------Boundary type Data for ADMINISTRATION
INSERT INTO eg_boundary_type (id, hierarchy, parent, name, hierarchytype, createddate, lastmodifieddate, createdby, lastmodifiedby, version, localname) VALUES (NEXTVAL('seq_eg_boundary_type'), 1, NULL, 'City', (select id from eg_hierarchy_type where name = 'ADMINISTRATION'), now(), now(), 1, 1, 0, NULL);

INSERT INTO eg_boundary_type (id, hierarchy, parent, name, hierarchytype, createddate, lastmodifieddate, createdby, lastmodifiedby, version, localname) VALUES (NEXTVAL('seq_eg_boundary_type'), 2, (select id from eg_boundary_type  where name='City' and hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION')), 'Ward', (select id from eg_hierarchy_type where name = 'ADMINISTRATION'), now(), now(), 1, 1, 0, NULL);


----------Boundary type Data for REVENUE
INSERT INTO eg_boundary_type (id, hierarchy, parent, name, hierarchytype, createddate, lastmodifieddate, createdby, lastmodifiedby, version, localname) VALUES (NEXTVAL('seq_eg_boundary_type'), 2, (select id from eg_boundary_type  where name='City' and hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE')), 'Zone', (select id from eg_hierarchy_type where name = 'REVENUE'), now(), now(), 1, 1, 0, NULL);

INSERT INTO eg_boundary_type (id, hierarchy, parent, name, hierarchytype, createddate, lastmodifieddate, createdby, lastmodifiedby, version, localname) VALUES (NEXTVAL('seq_eg_boundary_type'), 3, (select id from eg_boundary_type  where name='Zone' and hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE')), 'Block', (select id from eg_hierarchy_type where name = 'REVENUE'), now(), now(), 1, 1, 0, NULL);

INSERT INTO eg_boundary_type (id, hierarchy, parent, name, hierarchytype, createddate, lastmodifieddate, createdby, lastmodifiedby, version, localname) VALUES (NEXTVAL('seq_eg_boundary_type'), 4, (select id from eg_boundary_type  where name='Block' and hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE')), 'Locality', (select id from eg_hierarchy_type where name = 'REVENUE'), now(), now(), 1, 1, 0, NULL);

----------Boundary City Data for REVENUE

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0001, NULL, 'Punjab', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='City'), 'Punjab', NULL, NULL, '0001-04-01 00:00:00 BC', '2099-03-31 00:00:00', NULL, NULL, NULL, '1', now(), now(), 1, 1, 0);

----------Boundary Zone Data for REVENUE

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0002, (select id from eg_boundary  where name = 'Punjab'), 'Zone 1', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone'), 'Zone 1', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.1', now(), now(), 1, 1, NULL);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0003, (select id from eg_boundary  where name = 'Punjab'), 'Zone 2', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone'), 'Zone 2', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.2', now(), now(), 1, 1, NULL);

----------Boundary Block Data for REVENUE

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0004, (select id from eg_boundary  where name = 'Zone 1'), 'Block 1', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 1', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.3', now(), now(), 1, 1, NULL);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0005, (select id from eg_boundary  where name = 'Zone 1'), 'Block 2', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 2', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.3', now(), now(), 1, 1, NULL);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0006, (select id from eg_boundary  where name = 'Zone 2'), 'Block 3', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 3', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.3', now(), now(), 1, 1, NULL);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0007, (select id from eg_boundary  where name = 'Zone 2'), 'Block 4', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 4', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.3', now(), now(), 1, 1, NULL);

----------Boundary Locality Data for REVENUE

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0008, (select id from eg_boundary  where name = 'Block 1'), 'Locality 1', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Locality 1', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.3', now(), now(), 1, 1, NULL);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0009, (select id from eg_boundary  where name = 'Block 1'), 'Locality 2', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Locality 2', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.3', now(), now(), 1, 1, NULL);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0010, (select id from eg_boundary  where name = 'Block 2'), 'Locality 3', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Locality 3', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.3', now(), now(), 1, 1, NULL);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0011, (select id from eg_boundary  where name = 'Block 2'), 'Locality 4', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Locality 4', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.3', now(), now(), 1, 1, NULL);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0012, (select id from eg_boundary  where name = 'Block 3'), 'Locality 5', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Locality 5', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.3', now(), now(), 1, 1, NULL);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0013, (select id from eg_boundary  where name = 'Block 3'), 'Locality 6', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Locality 6', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.3', now(), now(), 1, 1, NULL);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0014, (select id from eg_boundary  where name = 'Block 4'), 'Locality 1', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Locality 1', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.3', now(), now(), 1, 1, NULL);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0015, (select id from eg_boundary  where name = 'Block 4'), 'Locality 2', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Locality 2', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.3', now(), now(), 1, 1, NULL);




----------Boundary City Data for ADMINISTRATION

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0016, NULL, 'Punjab', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City'), 'Punjab', NULL, NULL, '0001-04-01 00:00:00 BC', '2099-03-31 00:00:00', NULL, NULL, NULL, '1', now(), now(), 1, 1, 0);


----------Boundary Ward Data for ADMINISTRATION

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0017, (select id from eg_boundary  where name = 'Punjab' and boundarytype = (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward 1', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward 1', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.1', now(), now(), 1, 1, NULL);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, bndry_name_old, bndry_name_old_local, fromdate, todate, bndryid, longitude, latitude, materializedpath,  createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (NEXTVAL('seq_eg_boundary'), 0018, (select id from eg_boundary  where name = 'Punjab' and boundarytype = (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward 2', (select id from eg_boundary_type  where hierarchytype  = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward 2', NULL, NULL, '2004-04-01 00:00:00', '2099-04-01 00:00:00', NULL, NULL, NULL, '3.2', now(), now(), 1, 1, NULL);
