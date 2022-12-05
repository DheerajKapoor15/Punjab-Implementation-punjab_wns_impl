insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/collection/generatebill' and contextroot='stms'));
