--------------------WCMS_VIEW_ACCESS_ROLE
--Master Data
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'viewUsageTypeMaster' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'SearchWaterChargeRatesMaster' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'WaterMeteredRatesAjaxSearch' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'WaterMeteredRatesView' and contextroot='wtms'));

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'SearchWaterMeteredRatesMaster'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'WaterChargeRatesAjaxSearch' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'WaterChargeRatesView' and contextroot='wtms'));

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'CategoryMasterList' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'PipeSizeList' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'PropertyUsageList' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'PropertyCategoryList' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'PropertyPipeSizeList' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'WaterSourceTypeList' and contextroot='wtms'));

-- View Transactions
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'watertaxappsearch' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'Meter Reading Entry View' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'Scheduled Job Details For Water' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'Scheduled Job Detail Logs For Water' and contextroot='wtms'));

-- Reports
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'GenerateBillReport' and contextroot='wtms'));