insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Application Initiator'),(select id from eg_action where name='Water Rate Demand And Collection Register Report' and contextroot='wtms'));

