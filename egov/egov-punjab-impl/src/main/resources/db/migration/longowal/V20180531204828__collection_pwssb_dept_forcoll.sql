update eg_appconfig_values set value='DEPT_15' where key_id = (select id from eg_appconfig where key_name='DEPTCODEFORGENERATEBILL' and module=(select id from eg_module where name='Water Tax Management'));

update eg_appconfig_values set value='PWSSB' where key_id = (select id from eg_appconfig where key_name='COLLECTIONDEPARTMENTFORWORKFLOW' and module=(select id from eg_module where name='Collection'));

update eg_appconfig_values set value='Accountant' where key_id = (select id from eg_appconfig where key_name='COLLECTIONDESIGNATIONFORCSCOPERATORASCLERK' and module=(select id from eg_module where name='Collection'));

update eg_location set name='Longowal Municipal Council', description='Longowal Counter 1';