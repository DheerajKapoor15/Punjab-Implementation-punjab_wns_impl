insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Water Sewerage Administrator'),(select id from eg_action where name='SearchSewerageTaxActivateDeactivate'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Water Sewerage Administrator'),(select id from eg_action where name='SewerageTaxActivateDeactivate'));
