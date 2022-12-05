Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'),(select id from eg_action where name='PropertyUsageList' and contextroot='wtms'));
