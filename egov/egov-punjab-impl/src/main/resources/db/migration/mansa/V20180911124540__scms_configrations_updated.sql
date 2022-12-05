
update eg_appconfig_values set value='15' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERIOD' and module=(select id from eg_module where name='Sewerage Tax Management'));
