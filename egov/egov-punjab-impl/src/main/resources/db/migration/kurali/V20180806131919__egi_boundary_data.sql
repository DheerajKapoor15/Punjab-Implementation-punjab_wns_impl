delete from eg_boundary;

--City
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, bndryid, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, NULL, 'Kurali Municipal Council', (select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City'), 'Kurali Municipal Council', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, '1', now(), now(), 1, 1, 'ADM_CITY', 0);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, bndryid, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, NULL, 'Kurali Municipal Council', (select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='City'), 'Kurali Municipal Council', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, '1', now(), now(), 1, 1, 'REV_CITY', 0);

INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, bndryid, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, NULL, 'Kurali Municipal Council', (select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'LOCATION') and name='City'), 'Kurali Municipal Council', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, '1', now(), now(), 1, 1, 'LOC_CITY', 0);

--Revenue Zone
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='City')), 'KURALI',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone'), 'KURALI', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KUZ1', true, 0);

--Revenue Block
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD1',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD1', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD1', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 2, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD2',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD2', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD2', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 3, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD3',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD3', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD3', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 4, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD4',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD4', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD4', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 5, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD5',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD5', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD5', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 6, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD6',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD6', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD6', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 7, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD7',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD7', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD7', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 8, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD8',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD8', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD8', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 9, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD9',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD9', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD9', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 10, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD10',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD10', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD10', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 11, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD11',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD11', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD11', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 12, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD12',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD12', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD12', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 13, (select id from eg_boundary where code='KUZ1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Zone')), 'WARD13',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block'), 'WARD13', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KWD13', true, 0);

--Revenue Locality
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where code='KWD1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD1',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD1', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL1', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 2, (select id from eg_boundary where code='KWD2' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD2',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD2', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL2', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 3, (select id from eg_boundary where code='KWD3' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD3',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD3', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL3', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 4, (select id from eg_boundary where code='KWD4' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD4',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD4', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL4', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 5, (select id from eg_boundary where code='KWD5' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD5',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD5', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL5', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 6, (select id from eg_boundary where code='KWD6' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD6',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD6', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL6', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 7, (select id from eg_boundary where code='KWD7' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD7',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD7', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL7', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 8, (select id from eg_boundary where code='KWD8' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD8',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD8', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL8', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 9, (select id from eg_boundary where code='KWD9' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD9',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD9', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL9', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 10, (select id from eg_boundary where code='KWD10' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD10',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD10', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL10', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 11, (select id from eg_boundary where code='KWD11' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD11',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD11', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL11', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 12, (select id from eg_boundary where code='KWD12' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD12',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD12', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL12', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 13, (select id from eg_boundary where code='KWD13' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')), 'LOC_WARD13',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality'), 'LOC_WARD13', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'KL13', true, 0);

--Admin Ward
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 1, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 1',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 1', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-1', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 2, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 2',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 2', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-2', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 3, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 3',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 3', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-3', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 4, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 4',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 4', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-4', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 5, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 5',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 5', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-5', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 6, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 6',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 6', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-6', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 7, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 7',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 7', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-7', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 8, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 8',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 8', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-8', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 9, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 9',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 9', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-9', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 10, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 10',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 10', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-10', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 11, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 11',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 11', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-11', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 12, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 12',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 12', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-12', true, 0);
INSERT INTO eg_boundary (id, boundarynum, parent, name, boundarytype, localname, fromdate, todate, materializedpath, createddate, lastmodifieddate, createdby, lastmodifiedby, code, active, version) VALUES (NEXTVAL('seq_eg_boundary'), 13, (select id from eg_boundary where name='Kurali Municipal Council' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='City')), 'Ward No 13',(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'ADMINISTRATION') and name='Ward'), 'Ward No 13', '2018-04-01 00:00:00', '2099-03-31 00:00:00', NULL, now(), now(), 1, 1, 'WD-13', true, 0);

update eg_boundary set active =true;
