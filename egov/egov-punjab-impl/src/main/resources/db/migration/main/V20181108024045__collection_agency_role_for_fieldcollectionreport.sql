insert into eg_roleaction (roleid,actionid) VALUES ((select id from eg_role where name='Collection Agency'),(select id from eg_action where name='Field Collection Report'));
