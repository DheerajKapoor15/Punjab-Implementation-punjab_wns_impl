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

--reports
update eg_action set enabled = false where name = 'SearchNotice';
