

update eg_appconfig_values set value='PLOT_BASED' where key_id = (select id from eg_appconfig where key_name='TAX_RATETYPE' and module=(select id from eg_module where name='Water Tax Management'));
