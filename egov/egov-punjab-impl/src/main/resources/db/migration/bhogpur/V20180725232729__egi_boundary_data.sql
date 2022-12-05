delete from eg_boundary;

--City
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, bndryid, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, NULL, 'Bhogpur Municipal Council', (select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City'), 'Bhogpur Municipal Council', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, '1', now(), now(), 1, 1, 'ADM_CITY', 0);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, bndryid, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, NULL, 'Bhogpur Municipal Council', (select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='City'), 'Bhogpur Municipal Council', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, '1', now(), now(), 1, 1, 'REV_CITY', 0);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, bndryid, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, NULL, 'Bhogpur Municipal Council', (select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'LOCATION') and name='City'), 'Bhogpur Municipal Council', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, '1', now(), now(), 1, 1, 'LOC_CITY', 0);

--Revenue Zone
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='City')), 'Zone 1',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone'), 'Zone 1', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'Z1', true, 0);

--Revenue Block
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 1',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 1', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B1', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 2, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 2',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 2', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B2', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 3, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 3',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 3', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B3', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 4, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 4',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 4', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B4', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 5, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 5',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 5', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B5', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 6, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 6',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 6', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B6', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 7, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 7',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 7', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B7', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 8, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 8',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 8', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B8', true, 0);

--Revenue Locality
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where code='B1 ' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Guru Nanak Nagar',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Guru Nanak Nagar', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_1', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 2, (select id from eg_boundary where code='B1 ' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Roop Nagar',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Roop Nagar', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_2', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 3, (select id from eg_boundary where code='B1 ' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Baba Mast Colony',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Baba Mast Colony', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_3', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 4, (select id from eg_boundary where code='B1 ' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Bullowal Road',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Bullowal Road', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_4', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 5, (select id from eg_boundary where code='B2' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Adarsh Nagar',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Adarsh Nagar', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_5', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 6, (select id from eg_boundary where code='B2' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Guru Ravidass Nagar',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Guru Ravidass Nagar', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_6', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 7, (select id from eg_boundary where code='B3' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Basant Vihar',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Basant Vihar', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_7', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 8, (select id from eg_boundary where code='B3' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Dashmesh Nagar',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Dashmesh Nagar', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_8', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 9, (select id from eg_boundary where code='B3' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Rose Park Colony',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Rose Park Colony', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_9', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 10, (select id from eg_boundary where code='B3' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Adampur Road',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Adampur Road', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_10', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 11, (select id from eg_boundary where code='B4' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Navi Abadi',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Navi Abadi', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_11', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 12, (select id from eg_boundary where code='B4' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Seeta Ram Wali Gali',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Seeta Ram Wali Gali', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_12', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 13, (select id from eg_boundary where code='B4' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Dr. Thakur Wali Gali',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Dr. Thakur Wali Gali', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_13', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 14, (select id from eg_boundary where code='B5' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Arora Muhalla',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Arora Muhalla', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_14', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 15, (select id from eg_boundary where code='B5' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Dr. Mittal wali gali',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Dr. Mittal wali gali', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_15', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 16, (select id from eg_boundary where code='B5' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Chaura Bazaar',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Chaura Bazaar', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_16', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 17, (select id from eg_boundary where code='B5' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Railway Road',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Railway Road', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_17', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 18, (select id from eg_boundary where code='B6' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Purani Abadi',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Purani Abadi', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_18', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 19, (select id from eg_boundary where code='B6' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Jattan Muhalla',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Jattan Muhalla', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_19', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 20, (select id from eg_boundary where code='B6' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Ghumiara Muhalla',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Ghumiara Muhalla', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_20', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 21, (select id from eg_boundary where code='B7' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Shakti Nagar',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Shakti Nagar', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_21', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 22, (select id from eg_boundary where code='B7' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Laroi Road',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Laroi Road', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_22', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 23, (select id from eg_boundary where code='B7' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Loharan Road',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Loharan Road', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_23', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 24, (select id from eg_boundary where code='B7' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Guru Ramdass Nagar',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Guru Ramdass Nagar', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_24', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 25, (select id from eg_boundary where code='B8' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'Dalli',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'Dalli', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'BH_25', true, 0);


--Admin Ward
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 1',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 1', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-1', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 2, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 2',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 2', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-2', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 3, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 3',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 3', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-3', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 4, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 4',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 4', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-4', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 5, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 5',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 5', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-5', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 6, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 6',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 6', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-6', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 7, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 7',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 7', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-7', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 8, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 8',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 8', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-8', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 9, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 9',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 9', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-9', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 10, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 10',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 10', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-10', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 11, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 11',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 11', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-11', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 12, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 12',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 12', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-12', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 13, (select id from eg_boundary where name='Bhogpur Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 13',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 13', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-13', true, 0);

update eg_boundary set active =true;
