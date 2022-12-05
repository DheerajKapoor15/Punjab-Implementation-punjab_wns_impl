Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='DEPT_CODE_FOR_GENERATE_BILL' and module=(select id from eg_module where name='Sewerage Tax Management')), '01-Apr-2018', 'REV',0);


Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='FUNCTIONARY_CODE_FOR_GENERATE_BILL' and module=(select id from eg_module where name='Sewerage Tax Management')), '01-Apr-2018', '1',0);


Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='FUNDSOURCE_CODE_FOR_GENERATE_BILL' and module=(select id from eg_module where name='Sewerage Tax Management')), '01-Apr-2018', '01',0);


Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='FUND_CODE_FOR_GENERATE_BILL' and module=(select id from eg_module where name='Sewerage Tax Management')), '01-Apr-2018', '01',0);
