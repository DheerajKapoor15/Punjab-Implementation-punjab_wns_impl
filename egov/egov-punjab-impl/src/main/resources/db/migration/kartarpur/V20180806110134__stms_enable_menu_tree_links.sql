--SEWERAGE DISABLE 

--master
update eg_action set enabled = true where name = 'SearchSewerageChargeRatesMaster';

--transactions
update eg_action set enabled = true where name = 'LegacySewerageConnection';
update eg_action set enabled = true where name = 'SearchSewerageConnection';
update eg_action set enabled = true where name = 'SearchLegacySewerageConnection';
update eg_action set enabled = true where name = 'Auto Generate Demand For Sewerage';
update eg_action set enabled = true where name = 'GenerateSewerageBil';
update eg_action set enabled = true where name = 'Scheduled Job Details For Sewerage';
update eg_action set enabled = true where name = 'EditDemand-stms';

--reports
update eg_action set enabled = true where name = 'SearchNotice';
