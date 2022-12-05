--SEWERAGE DISABLE 

--master
update eg_action set enabled = false where name = 'SearchSewerageChargeRatesMaster';

--transactions
update eg_action set enabled = false where name = 'LegacySewerageConnection';
update eg_action set enabled = false where name = 'SearchSewerageConnection';
update eg_action set enabled = false where name = 'SearchLegacySewerageConnection';
update eg_action set enabled = false where name = 'Auto Generate Demand For Sewerage';
update eg_action set enabled = false where name = 'GenerateSewerageBil';
update eg_action set enabled = false where name = 'Scheduled Job Details For Sewerage';
update eg_action set enabled = false where name = 'EditDemand-stms';
update eg_action set enabled = false where name = 'SearchSewerageTaxActivateDeactivate';
update eg_action set enabled = false where name = 'SearchSewerageApplication';
update eg_action set enabled = false where name = 'ExecuteConnectionSearch';
update eg_action set enabled = false where name = 'CancelSewerageBill';
update eg_action set enabled = false where name = 'CancelSewerageBill';

--reports
update eg_action set enabled = false where name = 'SearchNotice';
update eg_action set enabled = false where name = 'Sewerage base register report';
update eg_action set enabled = false where name = 'SewerageDefaultersReport';
update eg_action set enabled = false where name = 'Sewerage Ageing Report for Designation';
