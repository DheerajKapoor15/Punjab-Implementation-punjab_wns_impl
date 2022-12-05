update eg_appconfig_values set value='TAX' where value='DEPT_13' and key_id = (select id from EG_APPCONFIG where KEY_NAME='DEPT_CODE_APP_INITIATOR' AND MODULE =(select id from eg_module where name='Water Tax Management'));

update eg_appconfig_values set value='TAX' where value='DEPT_13' and key_id = (select id from EG_APPCONFIG where KEY_NAME='DEPT_CODE_APP_INITIATOR' AND MODULE =(select id from eg_module where name='Sewerage Tax Management'));
