update eg_appconfig_values set value='18' where key_id = (select id from eg_appconfig where key_name='INTEREST_PERCENTAGE' and module=(select id from eg_module where name='Sewerage Tax Management'));
update eg_appconfig_values set value='30' where key_id = (select id from eg_appconfig where key_name='INTEREST_PERIOD' and module=(select id from eg_module where name='Sewerage Tax Management'));
update eg_appconfig_values set value='10' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERCENTAGE' and module=(select id from eg_module where name='Sewerage Tax Management'));
update eg_appconfig_values set value='15' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERIOD' and module=(select id from eg_module where name='Sewerage Tax Management'));

UPDATE eg_appconfig_values SET value='SEAT_BASED' WHERE key_id = (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='TAX_RATETYPE' and module=(select id from eg_module where name='Sewerage Tax Management'));

