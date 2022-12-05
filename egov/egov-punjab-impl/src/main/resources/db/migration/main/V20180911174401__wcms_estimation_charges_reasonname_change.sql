update eg_demand_reason_master set reasonmaster='Water Other Fee' where reasonmaster='Water Other Charges' and module=(select id from eg_module where name = 'Water Tax Management');
update eg_demand_reason_master set reasonmaster='Water Road Cutting Fee' where reasonmaster='Water Road Cutting Charges' and module=(select id from eg_module where name = 'Water Tax Management');
update eg_demand_reason_master set reasonmaster='Water SuperVision Fee' where reasonmaster='Water SuperVision Charges' and module=(select id from eg_module where name = 'Water Tax Management');
update eg_demand_reason_master set reasonmaster='Water Application Fee' where reasonmaster='Water Application Charges' and module=(select id from eg_module where name = 'Water Tax Management');
