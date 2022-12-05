update eg_appconfig_values set value='DEPT_15' where key_id = (select id from eg_appconfig where key_name='DEPTCODEFORGENERATEBILL' and module=(select id from eg_module where name='Water Tax Management'));

update eg_appconfig_values set value='DEPT_15' where key_id = (select id from eg_appconfig where key_name='DEPT_CODE_FOR_GENERATE_BILL' and module=(select id from eg_module where name='Sewerage Tax Management'));

update eg_appconfig_values set value='PWSSB' where key_id = (select id from eg_appconfig where key_name='COLLECTIONDEPARTMENTFORWORKFLOW' and module=(select id from eg_module where name='Collection'));

update eg_appconfig_values set value='DEPT_15' where key_id = (select id from eg_appconfig where key_name='COLLECTIONDEPARTMENTCOLLMODES' and module=(select id from eg_module where name='Collection'));

delete from eg_appconfig_values where key_id=(select id from eg_appconfig where key_name='COLLECTIONROLEFORNONEMPLOYEE' and module=(select id from eg_module where name='Collection')) and value='CSC Operator';

update eg_appconfig_values set value='Junior Engineer' where key_id = (select id from eg_appconfig where key_name='COLLECTIONDESIGNATIONFORCSCOPERATORASCLERK' and module=(select id from eg_module where name='Collection'));


update eg_location set name='Kotfatta Municipal Council', description='Kotfatta Counter 1';
