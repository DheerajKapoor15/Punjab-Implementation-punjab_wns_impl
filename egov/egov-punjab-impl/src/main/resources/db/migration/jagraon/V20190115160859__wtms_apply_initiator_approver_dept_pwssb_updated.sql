update eg_appconfig_values set value='DEPT_13' where key_id = (select id from EG_APPCONFIG where KEY_NAME='DEPT_CODE_APP_INITIATOR' AND MODULE =(select id from eg_module where name='Water Tax Management'));
update eg_appconfig_values set value='Tax Branch' where key_id = (select id from EG_APPCONFIG where KEY_NAME='WATER_APPROVE_DEPARTMENT' AND MODULE =(select id from eg_module where name='Water Tax Management'));