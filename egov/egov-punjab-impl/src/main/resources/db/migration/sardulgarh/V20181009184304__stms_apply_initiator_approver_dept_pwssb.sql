update eg_appconfig_values set value='DEPT_15' where key_id = (select id from EG_APPCONFIG where KEY_NAME='DEPT_CODE_APP_INITIATOR' AND MODULE =(select id from eg_module where name='Sewerage Tax Management'));
update eg_appconfig_values set value='PWSSB' where key_id = (select id from EG_APPCONFIG where KEY_NAME='SEWERAGE_APPROVE_DEPARTMENT' AND MODULE =(select id from eg_module where name='Sewerage Tax Management'));
