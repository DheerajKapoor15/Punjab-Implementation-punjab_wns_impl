update eg_action set enabled = false where url='/search/waterSearch/commonSearch/editdemand' and contextroot='wtms';
update eg_action set enabled = false where url='/reports/arrear/arrearReportList' and contextroot='wtms';
update eg_action set enabled = false where url='/report/baseRegister/result' and contextroot='wtms';
update eg_action set enabled = false where url='/report/baseRegister' and contextroot='wtms';
update eg_action set enabled = false where url='/search/waterSearch/commonSearch/collecttax' and contextroot='wtms';
update eg_action set enabled = false where url='/search/waterSearch/' and displayname='Search Water Connection' and contextroot='wtms';
update eg_action set enabled = false where url='/search/waterSearch/commonSearch-form/' and contextroot='wtms';
update eg_action set enabled = false where url='/report/dailyWTCollectionReport/search/' and contextroot='wtms';
update eg_action set enabled = false where url='/report/dataEntryConnectionReport/search' and contextroot='wtms';
update eg_action set enabled = false where url='/reports/dCBReport/blockWise' and contextroot='wtms';
update eg_action set enabled = false where url='/reports/dCBReportList' and contextroot='wtms';
update eg_action set enabled = false where url='/reports/dCBReport/localityWise' and contextroot='wtms';
update eg_action set enabled = false where url='/reports/dCBReport/wardWise' and contextroot='wtms';
update eg_action set enabled = false where url='/reports/dCBReport/zoneWise' and contextroot='wtms';
update eg_action set enabled = false where url='/report/defaultersWTReport/search' and contextroot='wtms';
update eg_action set enabled = false where url='/application/editDemand/' and contextroot='wtms';
update eg_action set enabled = false where url='/application/newConnection-editExisting/' and contextroot='wtms';
update eg_action set enabled = false where url='/report/generateBillForHSCNo/' and contextroot='wtms';
update eg_action set enabled = false where url='/search/waterSearch/commonSearch/generatebill' and contextroot='wtms';
update eg_action set enabled = false where url='/report/dataEntryConnectionReport/search/result/' and contextroot='wtms';
update eg_action set enabled = false where url='/report/defaultersWTReport/search/result' and contextroot='wtms';
update eg_action set enabled = false where url='/search/waterSearch/commonSearch/dataentryedit' and contextroot='wtms';
update eg_action set enabled = false where url='/reports/coonectionReport/wardWise' and contextroot='wtms';
update eg_action set enabled = false where url='/ajax-CategoryTypeByPropertyType' and contextroot='wtms';
update eg_action set enabled = false where url='/ajax-PipeSizesByPropertyType' and contextroot='wtms';
update eg_action set enabled = false where url='/ajax-UsageTypeByPropertyType' and contextroot='wtms';
update eg_action set enabled = false where url='/report/notice/search' and contextroot='wtms';
update eg_action set enabled = false where url='/masters/waterchargerates/ajaxsearch' and contextroot='wtms';
update eg_action set enabled = false where url='/reports/view-donation' and contextroot='wtms';
update eg_action set enabled = false where url='/reports/search-donation' and contextroot='wtms';
update eg_action set enabled = false where url='/masters/pipesizeMaster/list' and contextroot='wtms';
update eg_action set enabled = false where url='/masters/propertyCategoryMaster/list' and contextroot='wtms';
update eg_action set enabled = false where url='/masters/propertyPipeSizeMaster/list' and contextroot='wtms';
update eg_action set enabled = false where url='/masters/propertyUsageMaster/list' and contextroot='wtms';
update eg_action set enabled = false where url='/masters/usageTypeMaster/list' and contextroot='wtms';
update eg_action set enabled = false where url='/masters/waterchargerates/view' and contextroot='wtms';
update eg_action set enabled = false where url='/masters/waterchargerates/search' and contextroot='wtms';
update eg_action set enabled = false where url='/application/view/' and contextroot='wtms';
update eg_action set enabled = false where url='/masters/waterSourceTypeMaster/list' and contextroot='wtms';
update eg_action set enabled = false where url='/application/newConnection-dataEntryForm' and contextroot='wtms';
update eg_action set enabled = false where url='/application/newConnection-existingMessage' and contextroot='wtms';
update eg_action set enabled = false where url='/reports/connectionReportList' and contextroot='wtms';
update eg_action set enabled = false where url='/report/generateBillForHSCNo/downloadDemandBill' and contextroot='wtms';
update eg_action set enabled = false where url='/application/newConnection-existingMessage/' and contextroot='wtms';

--Job details
update eg_action set enabled = false where name = 'Auto Generate Demand For Water';
update eg_action set enabled = false where name = 'Scheduled Job Details For Water';
update eg_action set enabled = false where name = 'Scheduled Job Detail Logs For Water';

--Meter Reading Entry
update eg_action set enabled = false where name = 'Meter Reading Entry';
update eg_action set enabled = false where name = 'Meter Reading Entry Save';
update eg_action set enabled = false where name = 'Meter Reading Entry View';

update eg_action set enabled = false where displayname = 'View Water Metered Rates';
update eg_action set enabled = false where displayname = 'View Category';

update eg_module set enabled=false where displayname = 'Water Charge Management';
