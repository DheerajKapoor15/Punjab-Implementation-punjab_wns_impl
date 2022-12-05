--water

Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='DEPT_CODE_APP_INITIATOR' and module=(select id from eg_module where name='Water Tax Management')), '01-Apr-2018', 'DEPT_7',0);

Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='DESG_APP_INITIATOR' and module=(select id from eg_module where name='Water Tax Management')), '01-Apr-2018', 'Clerk',0);

--sewerage

Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='DEPT_CODE_APP_INITIATOR' and module=(select id from eg_module where name='Sewerage Tax Management')), '01-Apr-2018', 'DEPT_7',0);

Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='DESG_APP_INITIATOR' and module=(select id from eg_module where name='Sewerage Tax Management')), '01-Apr-2018', 'Clerk',0);


