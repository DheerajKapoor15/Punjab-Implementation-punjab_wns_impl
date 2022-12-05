update eg_appconfig_values set value='0' where key_id = (select id from eg_appconfig where key_name='INTEREST_PERCENTAGE' and module=(select id from eg_module where name='Water Tax Management'));
update eg_appconfig_values set value='0' where key_id = (select id from eg_appconfig where key_name='INTEREST_PERIOD' and module=(select id from eg_module where name='Water Tax Management'));
update eg_appconfig_values set value='0' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERCENTAGE' and module=(select id from eg_module where name='Water Tax Management'));
update eg_appconfig_values set value='0' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERIOD' and module=(select id from eg_module where name='Water Tax Management'));

UPDATE eg_appconfig_values SET value='FIXED' WHERE key_id = (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='TAX_RATETYPE' and module=(select id from eg_module where name='Water Tax Management'));
