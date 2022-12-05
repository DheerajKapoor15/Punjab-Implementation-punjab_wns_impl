update eg_module set enabled=false where name in('DonationMaster','WaterRatesHeaderMaster','MeterCostMaster','ApplicationProcessTime', 'DocumentNamesMaster', 'ChairPersonMaster', 'UsageSlabMaster', 'MeteredRatesMaster');

update eg_action set enabled=false where name in ('CategoryMaster', 'UsageTypeMaster', 'Property Category', 'PipeSizeMaster', 'Property Usage', 'modifyUsageTypeMaster', 'modifyCategoryMaster', 'modifyPipeSizeMaster', 'modifyPropertyUsageMaster', 'modifyPropertyCategoryMaster', 'modifypropertyPipeSizeMaster', 'Property Pipe Size', 'modifyWaterSourceTypeMaster', 'Water Source Type') and contextroot='wtms';

update eg_action set enabled=false where name in ('EditCollection', 'WaterTaxCreateNewConnectionNewForm', 'EnterMeterEntryForConnection', 
'createClosureConnection', 'Water Tax Search Pending Digital Signature', 'WaterTaxConnectionRectification', 'LinkActiveProperty', 'CreateChangeOfUseConnection', 'CreateAdditionalConnection', 'createReConnection', 'ExecuteUpdateSearch', 'ExecuteMeteredWaterConnectionSearch', 'ApplyforRegulariseWaterConnection')  and contextroot='wtms';
