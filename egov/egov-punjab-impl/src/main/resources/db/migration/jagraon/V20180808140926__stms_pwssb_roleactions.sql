--Sewerage
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/ajaxconnection/check-connection-exists' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/ajaxconnection/check-watertax-due' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/ajaxconnection/getlegacy-demand-details' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/ajaxconnection/check-closets-exists' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/ajaxconnection/check-shscnumber-exists' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where name='Auto Generate Demand For Sewerage' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/baseregistersearch' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/baseregisterresult' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/transactions/seweragedemand-status' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/transactions/seweragedemand-status-records-view/' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/dailySTCollectionReport/search/' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/dcb-report-wardwise' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/dcbReportWardwiseList' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/transactions/seweragedemand-batch' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/transactions/seweragesearch/generatebill' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/generate-sewerage-demand-bill' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/transactions/sewerageLegacyApplication-success' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/transactions/sewerage/sewerageLegacyApplication-updateForm' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/transactions/modifylegacysearch' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/search-notice' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/search-no-of-application' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/seweragechargerates/ajaxsearch' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/existing/sewerage/seweragelegacysearch' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/seweragebaseregister/download' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/seweragebaseregister/grand-total' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/transactions/legacyConnection-newform' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/searchNotices-mergeAndDownload' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/searchResult' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/search-NoticeResultSize' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/searchNotices-seweragezipAndDownload' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/existing/sewerage/view' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/view-no-of-application' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/seweragechargerates/search' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/masters/seweragechargerates/view' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/transactions/legacyConnection-create' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/transactions/sewerageLegacyApplication-update' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/collection/generatebill' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/generateBillForSHSCNo/downloadDemandBill' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/searchNotices-showSewerageNotice/' and contextroot='stms'));
--sewerage collection
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/collectfee/search' and contextroot='stms'));

--Edit Demand
INSERT INTO EG_ROLEACTION (ROLEID, ACTIONID) values ((select id from eg_role where name = 'PWSSB User'),(select id FROM eg_action WHERE NAME = 'EditDemand-stms' and CONTEXTROOT='stms'));
INSERT INTO EG_ROLEACTION (ROLEID, ACTIONID) values ((select id from eg_role where name = 'PWSSB User'),(select id FROM eg_action WHERE NAME = 'EditDemand' and CONTEXTROOT='stms'));

--Job details
INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Scheduled Job Details For Sewerage'));
INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Scheduled Job Detail Logs For Sewerage'));
