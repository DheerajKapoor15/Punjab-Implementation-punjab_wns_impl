update eg_appconfig_values set value='NO' where KEY_ID = (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='IS_PWSSB_ULB' and module=(select id from eg_module where name='Administration'));
delete from eg_appconfig_values where key_id=(SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='PWSSB_CONFIGURATION' and module=(select id from eg_module where name='Administration'));
update eg_appconfig_values set value='DEPT_13' where value='DEPT_15';
update eg_appconfig_values set value='Tax Branch' where value='PWSSB';
update eg_appconfig_values set value='Clerk' where key_id = (select id from eg_appconfig where key_name='COLLECTIONDESIGNATIONFORCSCOPERATORASCLERK' and module=(select id from eg_module where name='Collection'));
update eg_appconfig_values set value = 'Executive Officer' where key_id =(select id from eg_appconfig where key_name = 'WATER_APPROVE_DESIGNATION');
update eg_appconfig_values set value = 'Executive Officer' where key_id =(select id from eg_appconfig where key_name = 'SEWERAGE_APPROVE_DESIGNATION'); 