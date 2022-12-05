--WCMS master data

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where name='PipeSizeList' and contextroot='wtms'));

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where name='viewUsageTypeMaster' and contextroot='wtms'));

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where name='CategoryMasterList' and contextroot='wtms'));

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where name='PropertyCategoryList' and contextroot='wtms'));

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where name='WaterSourceTypeList' and contextroot='wtms'));

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where name='PropertyPipeSizeList' and contextroot='wtms'));

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where name='GenerateBillReport' and contextroot='wtms'));

--STMS master data

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where name='SearchSewerageChargeRatesMaster' and contextroot='stms'));

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where name='SewerageChargeRatesView' and contextroot='stms'));

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where name='SearchNotice' and contextroot='stms'));

