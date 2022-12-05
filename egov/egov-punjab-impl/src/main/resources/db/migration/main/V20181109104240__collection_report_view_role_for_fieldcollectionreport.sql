insert into eg_roleaction (roleid,actionid) VALUES ((select id from eg_role where name='COLLECTION REPORT VIEWER'),(select id from eg_action where name='Field Collection Report'));

insert into eg_roleaction (roleid,actionid) VALUES ((select id from eg_role where name='Coll_View Access'),(select id from eg_action where name='Field Collection Report'));
