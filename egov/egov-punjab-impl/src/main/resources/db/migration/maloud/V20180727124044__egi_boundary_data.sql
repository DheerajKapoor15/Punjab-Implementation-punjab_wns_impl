delete from eg_boundary;

--City
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, bndryid, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, NULL, 'Malout Municipal Council', (select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City'), 'Malout Municipal Council', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, '1', now(), now(), 1, 1, 'ADM_CITY', true, 0);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, bndryid, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, NULL, 'Malout Municipal Council', (select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='City'), 'Malout Municipal Council', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, '1', now(), now(), 1, 1, 'REV_CITY', true, 0);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, bndryid, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, NULL, 'Malout Municipal Council', (select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'LOCATION') and name='City'), 'Malout Municipal Council', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, '1', now(), now(), 1, 1, 'LOC_CITY', true, 0);

--Revenue Zone
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where name='Malout Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='City')), 'Zone 1',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone'), 'Zone 1', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'Z1', true, 0);

--Revenue Block
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where code='Z1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'Block 1',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'Block 1', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'B1', true, 0);

--Revenue Locality
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'NEAR BUS STAND',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'NEAR BUS STAND', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'MD 1', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 2, (select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'DHANKI MOHALLA',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'DHANKI MOHALLA', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'MD 2', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 3, (select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'CHOMO ROAD, SANSI MOHALLA.',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'CHOMO ROAD, SANSI MOHALLA.', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'MD 3', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 4, (select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'GIRLS SCHOOL',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'GIRLS SCHOOL', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'MD 4', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 5, (select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'PURIAN MOHALLA',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'PURIAN MOHALLA', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'MD 5', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 6, (select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'BABA DEVIDYAL SMAD',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'BABA DEVIDYAL SMAD', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'MD 6', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 7, (select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'VETERANY HOSPITAL, SEKHA ROAD',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'VETERANY HOSPITAL, SEKHA ROAD', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'MD 7', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 8, (select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'GURUDWARA DHAMSAR SAHIB',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'GURUDWARA DHAMSAR SAHIB', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'MD 8', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 9, (select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LAHAURI MOHALLA, BOOTA CHOWK',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LAHAURI MOHALLA, BOOTA CHOWK', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'MD 9', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 10, (select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'SOMAL KHERI',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'SOMAL KHERI', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'MD 10', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 11, (select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'GOSAL ROAD',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'GOSAL ROAD', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'MD 11', true, 0);

--Admin Ward
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where name='Malout Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 1',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 1', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-1', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 2, (select id from eg_boundary where name='Malout Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 2',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 2', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-2', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 3, (select id from eg_boundary where name='Malout Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 3',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 3', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-3', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 4, (select id from eg_boundary where name='Malout Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 4',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 4', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-4', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 5, (select id from eg_boundary where name='Malout Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 5',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 5', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-5', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 6, (select id from eg_boundary where name='Malout Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 6',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 6', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-6', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 7, (select id from eg_boundary where name='Malout Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 7',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 7', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-7', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 8, (select id from eg_boundary where name='Malout Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 8',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 8', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-8', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 9, (select id from eg_boundary where name='Malout Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 9',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 9', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-9', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 10, (select id from eg_boundary where name='Malout Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 10',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 10', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-10', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 11, (select id from eg_boundary where name='Malout Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 11',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 11', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-11', true, 0);

