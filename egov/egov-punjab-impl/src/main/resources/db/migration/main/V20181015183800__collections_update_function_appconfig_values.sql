update eg_appconfig_values set value='505100' where key_id = (select id from EG_APPCONFIG where KEY_NAME='WT_BILL_DETAILS_FUNCTON_CODE' AND MODULE =(select id from eg_module where name='Water Tax Management'));

update eg_appconfig_values set value='505200' where key_id = (select id from EG_APPCONFIG where KEY_NAME='SEWERAGE_FUNCTION_CODE' AND MODULE =(select id from eg_module where name='Sewerage Tax Management'));

update eg_appconfig_values set value='505200' where key_id = (select id from EG_APPCONFIG where KEY_NAME='SWT_BILL_DETAILS_FUNCTON_CODE' AND MODULE =(select id from eg_module where name='Sewerage Tax Management'));
