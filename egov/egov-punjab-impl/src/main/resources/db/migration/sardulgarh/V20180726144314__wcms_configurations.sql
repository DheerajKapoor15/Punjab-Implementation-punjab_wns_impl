update eg_appconfig_values set value='9' where key_id = (select id from eg_appconfig where key_name='INTEREST_PERCENTAGE' and module=(select id from eg_module where name='Water Tax Management'));
update eg_appconfig_values set value='30' where key_id = (select id from eg_appconfig where key_name='INTEREST_PERIOD' and module=(select id from eg_module where name='Water Tax Management'));
update eg_appconfig_values set value='0' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERCENTAGE' and module=(select id from eg_module where name='Water Tax Management'));
update eg_appconfig_values set value='0' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERIOD' and module=(select id from eg_module where name='Water Tax Management'));
