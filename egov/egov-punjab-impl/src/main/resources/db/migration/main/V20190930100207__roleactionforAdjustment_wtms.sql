Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Tax Waiver'),(select id from eg_action where name='ConnectionSearchForAdjustmentfeature'));
