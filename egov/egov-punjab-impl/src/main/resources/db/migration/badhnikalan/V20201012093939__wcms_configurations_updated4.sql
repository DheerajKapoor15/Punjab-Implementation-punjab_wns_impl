UPDATE eg_appconfig_values SET value='PLOT_BASED' WHERE key_id = (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='TAX_RATETYPE' and module=(select id from eg_module where name='Water Tax Management'));
