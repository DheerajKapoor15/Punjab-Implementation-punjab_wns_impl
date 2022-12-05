-- WATER DISABLE 

--water module enable
update eg_module set enabled = false where displayname = 'Water Charge Management';

--Master data
update eg_action set enabled = false where name = 'viewUsageTypeMaster';
update eg_action set enabled = false where name = 'SearchWaterChargeRatesMaster';
update eg_action set enabled = false where name = 'SearchWaterMeteredRatesMaster';

update eg_action set enabled = false where name = 'CategoryMasterList';
update eg_action set enabled = false where name = 'PipeSizeList';
update eg_action set enabled = false where name = 'PropertyUsageList';
update eg_action set enabled = false where name = 'PropertyCategoryList';
update eg_action set enabled = false where name = 'PropertyPipeSizeList';
update eg_action set enabled = false where name = 'WaterSourceTypeList';

--Transactions
update eg_action set enabled = false where name = 'WaterTaxConnectionDataEntry';
update eg_action set enabled = false where name = 'watertaxappsearch';
update eg_action set enabled = false where name = 'modifydataentryconnectiondetails';
update eg_action set enabled = false where name = 'EditDemand-wcms';
update eg_action set enabled = false where name = 'Auto Generate Demand For Water';
update eg_action set enabled = false where name = 'Collect Water Charges';
update eg_action set enabled = false where name = 'GenerateBillForConsumerCode';
update eg_action set enabled = false where name = 'Scheduled Job Details For Water';
update eg_action set enabled = false where name = 'Meter Reading Entry';
update eg_action set enabled = false where name = 'Meter Reading Entry View';

--Reports
update eg_action set enabled = false where name = 'GenerateBillReport';







