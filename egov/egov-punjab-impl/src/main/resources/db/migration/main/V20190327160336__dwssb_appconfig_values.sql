Insert into eg_appconfig (id,key_name,description,version,createdby,lastmodifiedby,createddate,lastmodifieddate,module) values (nextval('SEQ_EG_APPCONFIG'),'IS_DWSSB_ULB','Configuration For ULB to know DWSSB or not',0,(select id from eg_user where username='egovernments'),(select id from eg_user where username='egovernments'),now(),now(),(select id from eg_module where name='Administration'));

Insert into eg_appconfig_values (ID, KEY_ID, EFFECTIVE_FROM, VALUE, CREATEDBY, LASTMODIFIEDBY, CREATEDDATE, LASTMODIFIEDDATE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), 
 (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='IS_DWSSB_ULB' and module=(select id from eg_module where name='Administration')), now(), 'NO', (select id from eg_user where username='egovernments'), 
 (select id from eg_user where username='egovernments'), now(),now(), 0);


Insert into eg_appconfig (id,key_name,description,version,createdby,lastmodifiedby,createddate,lastmodifieddate,module) values (nextval('SEQ_EG_APPCONFIG'),'DWSSB_CONFIGURATION','General Info for DWSSB Cities',0,(select id from eg_user where username='egovernments'),(select id from eg_user where username='egovernments'),now(),now(),(select id from eg_module where name='Administration'));
