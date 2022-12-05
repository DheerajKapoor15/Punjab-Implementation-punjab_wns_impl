
update eg_action set enabled=false where name in ('WaterTaxDCBReportZoneWise','WaterTaxConnectionReportWardWise','waterchargearrearReport','DefaultersReport','WaterTaxDCBReportWardWise','WaterTaxDCBReportBlockWise','WaterTaxDCBReportLocalityWise','DailyWTCollectionReport','BaseRegister Report','DataEntryConnectionReport','SearchDonationCharges') and contextroot='wtms';
