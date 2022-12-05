update eg_appconfig_values set value='18' where key_id = (select id from eg_appconfig where key_name='INTEREST_PERCENTAGE' and module=(select id from eg_module where name='Sewerage Tax Management'));
update eg_appconfig_values set value='365' where key_id = (select id from eg_appconfig where key_name='INTEREST_PERIOD' and module=(select id from eg_module where name='Sewerage Tax Management'));
update eg_appconfig_values set value='20' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERCENTAGE' and module=(select id from eg_module where name='Sewerage Tax Management'));
update eg_appconfig_values set value='9' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERIOD' and module=(select id from eg_module where name='Sewerage Tax Management'));
