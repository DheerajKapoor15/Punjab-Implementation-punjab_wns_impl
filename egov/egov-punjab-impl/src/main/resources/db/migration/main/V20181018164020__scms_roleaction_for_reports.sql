Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'),(select id from eg_action where name='SewerageDefaultersReport'));
Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'),(select id from eg_action where name='SewerageDefaultersReport-ajax'));

Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'),(select id from eg_action where name='Sewerage base register report'));
Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'),(select id from eg_action where name='Sewerage base register report result'));
