delete from eg_appconfig_values where key_id=(select id from eg_appconfig where key_name='COLLECTIONROLEFORNONEMPLOYEE' and module=(select id from eg_module where name='Collection')) and value='CSC Operator';

delete from eg_appconfig_values where key_id=(select id from eg_appconfig where key_name='COLLECTIONDEPARTMENTCOLLMODES' and module=(select id from eg_module where name='Collection'));

Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, CREATEDBY, LASTMODIFIEDBY, CREATEDDATE, LASTMODIFIEDDATE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='COLLECTIONDEPARTMENTCOLLMODES' and module=(select id from eg_module where name='Collection')), now(), 'DEPT_13', (select id from eg_user where username='egovernments'), (select id from eg_user where username='egovernments'), now(),now(), 0);

update egcl_servicedetails set vouchercreation=true;
