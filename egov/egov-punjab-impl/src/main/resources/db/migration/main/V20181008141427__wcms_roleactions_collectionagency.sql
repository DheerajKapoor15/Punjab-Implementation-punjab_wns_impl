Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Collection Agency'),(select id from eg_action where name='Collect Water Charges' and contextroot='wtms'));
Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Collection Agency'),(select id from eg_action where name='collectTaxForwatrtax' and contextroot='wtms'));
INSERT INTO eg_roleaction (roleid,actionid) VALUES ((select id from eg_role where name = 'Collection Agency'), (select id from eg_action where name = 'UpdateMobileEmailWater'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Collection Agency'), (select id from eg_action where url='/search/waterSearch/commonSearch-form/' and contextroot='wtms'));