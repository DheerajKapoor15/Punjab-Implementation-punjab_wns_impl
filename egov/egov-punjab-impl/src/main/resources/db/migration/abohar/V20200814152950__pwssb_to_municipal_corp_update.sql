delete  from  eg_appconfig_values where key_id=(SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='PWSSB_CONFIGURATION' and module=(select id from eg_module where name='Administration'));
