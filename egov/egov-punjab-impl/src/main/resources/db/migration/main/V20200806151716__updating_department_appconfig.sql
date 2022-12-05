update eg_appconfig_values set value='Engineering Branch (O&M - W&S)' where key_id=(SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='WATER_APPROVE_DEPARTMENT');
update eg_appconfig_values set value='Engineering Branch (O&M - W&S)' where key_id=(SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='SEWERAGE_APPROVE_DEPARTMENT');
update eg_appconfig_values set value='Executive Engineer' where key_id=(SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='WATER_APPROVE_DESIGNATION');
update eg_appconfig_values set value='Executive Engineer' where key_id=(SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='SEWERAGE_APPROVE_DESIGNATION');

update eg_wf_matrix set currentdesignation='Executive Engineer' where currentdesignation='Executive Engineer/Municipal Engineer/Corporation Engineer';

update eg_wf_matrix set currentdesignation='Sub-Divisional Engineer' where currentdesignation='Sub-Divisional Engineer/Sub-Divisional Officer';

update eg_wf_matrix set nextdesignation='Executive Engineer,Sub-Divisional Engineer,Executive Officer' where
nextdesignation='Executive Engineer/Municipal Engineer/Corporation Engineer,Sub-Divisional Engineer/Sub-Divisional Officer,Executive Officer';

update eg_appconfig_values set value='ENGG' where value='DEPT_7' and key_id in (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='DEPT_CODE_APP_INITIATOR' and module=(select id from eg_module where name='Water Tax Management'));

update eg_appconfig_values set value='ENGG' where value='DEPT_7' and key_id in (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='DEPT_CODE_APP_INITIATOR' and module=(select id from eg_module where name='Sewerage Tax Management'));

update eg_appconfig_values set value='TAX' where value='DEPT_13' and key_id = (select id from eg_appconfig where key_name='DEPTCODEFORGENERATEBILL' and module=(select id from eg_module where name='Water Tax Management'));

update eg_appconfig_values set value='TAX' where value='DEPT_13' and key_id = (select id from eg_appconfig where key_name='DEPT_CODE_FOR_GENERATE_BILL' and module=(select id from eg_module where name='Sewerage Tax Management'));

update eg_appconfig_values set value='TAX' where value='DEPT_13' and key_id = (select id from eg_appconfig where key_name='COLLECTIONDEPARTMENTCOLLMODES' and module=(select id from eg_module where name='Collection'));

update eg_appconfig_values set value='PWSSB' where value='DEPT_15' and key_id = (select id from eg_appconfig where key_name='DEPTCODEFORGENERATEBILL' and module=(select id from eg_module where name='Water Tax Management'));

update eg_appconfig_values set value='PWSSB' where value='DEPT_15' and key_id = (select id from eg_appconfig where key_name='DEPT_CODE_FOR_GENERATE_BILL' and module=(select id from eg_module where name='Sewerage Tax Management'));

update eg_appconfig_values set value='PWSSB' where value='DEPT_15' and key_id = (select id from eg_appconfig where key_name='COLLECTIONDEPARTMENTCOLLMODES' and module=(select id from eg_module where name='Collection'));

update eg_appconfig_values set value='PWSSB' where value='DEPT_15' and key_id = (select id from EG_APPCONFIG where KEY_NAME='DEPT_CODE_APP_INITIATOR' AND MODULE =(select id from eg_module where name='Water Tax Management'));

update eg_appconfig_values set value='PWSSB' where value='DEPT_15' and key_id = (select id from EG_APPCONFIG where KEY_NAME='DEPT_CODE_APP_INITIATOR' AND MODULE =(select id from eg_module where name='Sewerage Tax Management'));

update eg_appconfig_values set value='DWSS' where value='DEPT_16' and key_id = (select id from eg_appconfig where key_name='DEPTCODEFORGENERATEBILL' and module=(select id from eg_module where name='Water Tax Management'));

update eg_appconfig_values set value='DWSS' where value='DEPT_16' and key_id = (select id from eg_appconfig where key_name='DEPT_CODE_FOR_GENERATE_BILL' and module=(select id from eg_module where name='Sewerage Tax Management'));

update eg_appconfig_values set value='DWSS' where value='DEPT_16' and key_id = (select id from eg_appconfig where key_name='COLLECTIONDEPARTMENTCOLLMODES' and module=(select id from eg_module where name='Collection'));

update eg_appconfig_values set value='DWSS' where value='DEPT_16' and key_id = (select id from EG_APPCONFIG where KEY_NAME='DEPT_CODE_APP_INITIATOR' AND MODULE =(select id from eg_module where name='Water Tax Management'));

update eg_appconfig_values set value='DWSS' where value='DEPT_16' and key_id = (select id from EG_APPCONFIG where KEY_NAME='DEPT_CODE_APP_INITIATOR' AND MODULE =(select id from eg_module where name='Sewerage Tax Management'));