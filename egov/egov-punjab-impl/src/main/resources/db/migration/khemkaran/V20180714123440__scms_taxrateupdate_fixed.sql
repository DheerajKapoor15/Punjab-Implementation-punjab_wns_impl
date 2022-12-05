update eg_appconfig_values set value='FIXED' where key_id = (select id from eg_appconfig where key_name='TAX_RATETYPE' and module=(select id from eg_module where name='Sewerage Tax Management'));
update egswtax_seweragecharge_rates set fromplotarea =null, toplotarea=null;
update eg_appconfig_values set value='10' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERIOD' and module=(select id from eg_module where name='Sewerage Tax Management'));
