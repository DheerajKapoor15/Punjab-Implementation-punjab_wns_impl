INSERT INTO eg_role(id, name, description, createddate, createdby, lastmodifiedby, lastmodifieddate, version) VALUES (nextval('seq_eg_role'), 'PWSSB User', 'One who can access the Water and Sewerage services for citize under PWSSB', now(), 1, 1, now(), 0);

--water
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/search/waterSearch/commonSearch/editdemand' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/arrear/arrearReportList' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/report/baseRegister/result' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/report/baseRegister' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/search/waterSearch/commonSearch/collecttax' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/search/waterSearch/' and displayname='Search Water Connection' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/search/waterSearch/commonSearch-form/' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/report/dailyWTCollectionReport/search/' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/report/dataEntryConnectionReport/search' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/dCBReport/blockWise' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/dCBReportList' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/dCBReport/localityWise' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/dCBReport/wardWise' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/dCBReport/zoneWise' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/report/defaultersWTReport/search' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/application/editDemand/' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/application/newConnection-editExisting/' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/report/generateBillForHSCNo/' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/search/waterSearch/commonSearch/generatebill' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/report/dataEntryConnectionReport/search/result/' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/report/defaultersWTReport/search/result' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/search/waterSearch/commonSearch/dataentryedit' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/coonectionReport/wardWise' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/ajax-CategoryTypeByPropertyType' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/ajax-PipeSizesByPropertyType' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/ajax-UsageTypeByPropertyType' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/report/notice/search' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/waterchargerates/ajaxsearch' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/view-donation' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/search-donation' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/pipesizeMaster/list' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/propertyCategoryMaster/list' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/propertyPipeSizeMaster/list' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/propertyUsageMaster/list' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/usageTypeMaster/list' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/waterchargerates/view' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/waterchargerates/search' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/application/view/' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/waterSourceTypeMaster/list' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/application/newConnection-dataEntryForm' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/application/newConnection-existingMessage' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/connectionReportList' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/report/generateBillForHSCNo/downloadDemandBill' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/application/newConnection-existingMessage/' and contextroot='wtms'));

--Job details
INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Auto Generate Demand For Water'));
INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Scheduled Job Details For Water'));
INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Scheduled Job Detail Logs For Water'));

--Meter Reading Entry
INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Meter Reading Entry'));
INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Meter Reading Entry Save'));
INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Meter Reading Entry View'));

------New Meter Details
INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'New Meter Details'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/watermeteredrates/search' and contextroot='wtms'));
