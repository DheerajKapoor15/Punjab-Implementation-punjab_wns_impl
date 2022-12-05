
update eg_action set enabled=false where name in ('STDailyCollectionReport', 'Sewerage DCB Drill Down Report Wardwise', 'SewerageNoOfApplicationsReportSearch', 'Sewerage base register report')  and contextroot='stms';
