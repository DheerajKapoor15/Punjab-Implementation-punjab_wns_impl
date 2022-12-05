--Sewerage
update eg_action set enabled = true where url='/ajaxconnection/check-connection-exists' and contextroot='stms';
update eg_action set enabled = true where url='/ajaxconnection/check-watertax-due' and contextroot='stms';
update eg_action set enabled = true where url='/ajaxconnection/getlegacy-demand-details' and contextroot='stms';
update eg_action set enabled = true where url='/ajaxconnection/check-closets-exists' and contextroot='stms';
update eg_action set enabled = true where url='/ajaxconnection/check-shscnumber-exists' and contextroot='stms';
update eg_action set enabled = true where name='Auto Generate Demand For Sewerage' and contextroot='stms';
update eg_action set enabled = true where url='/reports/baseregistersearch' and contextroot='stms';
update eg_action set enabled = true where url='/reports/baseregisterresult' and contextroot='stms';
update eg_action set enabled = true where url='/transactions/seweragedemand-status' and contextroot='stms';
update eg_action set enabled = true where url='/transactions/seweragedemand-status-records-view/' and contextroot='stms';
update eg_action set enabled = true where url='/reports/dailySTCollectionReport/search/' and contextroot='stms';
update eg_action set enabled = true where url='/reports/dcb-report-wardwise' and contextroot='stms';
update eg_action set enabled = true where url='/reports/dcbReportWardwiseList' and contextroot='stms';
update eg_action set enabled = true where url='/transactions/seweragedemand-batch' and contextroot='stms';
update eg_action set enabled = true where url='/transactions/seweragesearch/generatebill' and contextroot='stms';
update eg_action set enabled = true where url='/reports/generate-sewerage-demand-bill' and contextroot='stms';
update eg_action set enabled = true where url='/transactions/sewerageLegacyApplication-success' and contextroot='stms';
update eg_action set enabled = true where url='/transactions/sewerage/sewerageLegacyApplication-updateForm' and contextroot='stms';
update eg_action set enabled = true where url='/transactions/modifylegacysearch' and contextroot='stms';
update eg_action set enabled = true where url='/reports/search-notice' and contextroot='stms';
update eg_action set enabled = true where url='/reports/search-no-of-application' and contextroot='stms';
update eg_action set enabled = true where url='/masters/seweragechargerates/ajaxsearch' and contextroot='stms';
update eg_action set enabled = true where url='/existing/sewerage/seweragelegacysearch' and contextroot='stms';
update eg_action set enabled = true where url='/reports/seweragebaseregister/download' and contextroot='stms';
update eg_action set enabled = true where url='/reports/seweragebaseregister/grand-total' and contextroot='stms';
update eg_action set enabled = true where url='/transactions/legacyConnection-newform' and contextroot='stms';
update eg_action set enabled = true where url='/reports/searchNotices-mergeAndDownload' and contextroot='stms';
update eg_action set enabled = true where url='/reports/searchResult' and contextroot='stms';
update eg_action set enabled = true where url='/reports/search-NoticeResultSize' and contextroot='stms';
update eg_action set enabled = true where url='/reports/searchNotices-seweragezipAndDownload' and contextroot='stms';
update eg_action set enabled = true where url='/existing/sewerage/view' and contextroot='stms';
update eg_action set enabled = true where url='/reports/view-no-of-application' and contextroot='stms';
update eg_action set enabled = true where url='/masters/seweragechargerates/search' and contextroot='stms';
update eg_action set enabled = true where url='/masters/seweragechargerates/view' and contextroot='stms';
update eg_action set enabled = true where url='/transactions/legacyConnection-create' and contextroot='stms';
update eg_action set enabled = true where url='/transactions/sewerageLegacyApplication-update' and contextroot='stms';
update eg_action set enabled = true where url='/collection/generatebill' and contextroot='stms';
update eg_action set enabled = true where url='/reports/generateBillForSHSCNo/downloadDemandBill' and contextroot='stms';
update eg_action set enabled = true where url='/reports/searchNotices-showSewerageNotice/' and contextroot='stms';
--sewerage collection
update eg_action set enabled = true where url='/collectfee/search' and contextroot='stms';

--Edit Demand
update eg_action set enabled = true WHERE NAME = 'EditDemand-stms' and CONTEXTROOT='stms';
update eg_action set enabled = true WHERE NAME = 'EditDemand' and CONTEXTROOT='stms';

--Job details
update eg_action set enabled = false where name = 'Scheduled Job Details For Sewerage';
update eg_action set enabled = false where name = 'Scheduled Job Detail Logs For Sewerage';
