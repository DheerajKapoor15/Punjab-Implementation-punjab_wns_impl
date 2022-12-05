Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Collection Agency'),(select id from eg_action where name='SearchSewerageCharges' and contextroot='stms'));
INSERT INTO eg_roleaction (roleid,actionid) VALUES ((select id from eg_role where name = 'Collection Agency'), (select id from eg_action where name = 'UpdateMobileEmailSewerage'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Collection Agency'),(select id from eg_action where name = 'ViewSewerageConnection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Collection Agency'), (select id from eg_action where url='/collection/generatebill' and contextroot='stms'));
