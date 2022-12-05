insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where name = 'WaterMeteredRatesAjaxSearch' and contextroot='wtms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where name = 'WaterMeteredRatesView' and contextroot='wtms'));
