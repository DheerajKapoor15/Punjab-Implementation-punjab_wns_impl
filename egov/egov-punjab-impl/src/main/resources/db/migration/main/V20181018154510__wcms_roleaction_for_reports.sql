Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'),(select id from eg_action where name='DefaultersReport'));
Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'),(select id from eg_action where name='DefaultersReport-ajax'));

Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'),(select id from eg_action where name='BaseRegister Report'));
Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'),(select id from eg_action where name='BaseRegister Report result'));
