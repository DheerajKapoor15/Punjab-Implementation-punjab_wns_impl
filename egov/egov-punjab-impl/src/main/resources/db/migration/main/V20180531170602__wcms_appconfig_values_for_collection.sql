
Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='DEPTCODEFORGENERATEBILL' and module=(select id from eg_module where name='Water Tax Management')), '01-Apr-2018', 'REV',0);

Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='SERVICECODEFORGENERATEBILL' and module=(select id from eg_module where name='Water Tax Management')), '01-Apr-2018', 'WT',0);

Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='ESTSERVICECODEFORGENERATEBILL' and module=(select id from eg_module where name='Water Tax Management')), '01-Apr-2018', 'WES',0);

Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='FUNCTIONARYCODEFORGENERATEBILL' and module=(select id from eg_module where name='Water Tax Management')), '01-Apr-2018', '1',0);

Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='FUNDSOURCECODEFORGENERATEBILL' and module=(select id from eg_module where name='Water Tax Management')), '01-Apr-2018', '01',0);

Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='FUNDCODEFORGENERATEBILL' and module=(select id from eg_module where name='Water Tax Management')), '01-Apr-2018', '01',0);

