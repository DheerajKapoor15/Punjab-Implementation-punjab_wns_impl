update eg_appconfig_values set value='YES' where KEY_ID = (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='IS_DWSSB_ULB' and module=(select id from eg_module where name='Administration'));

Insert into eg_appconfig_values ( ID, KEY_ID, EFFECTIVE_FROM, VALUE, VERSION ) VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'), (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='DWSSB_CONFIGURATION' and module=(select id from eg_module where name='Administration')), '01-Apr-2018', 'cityName=Department of Water Supply and Sanitation,contactNo=0172-4330317,emailId=hoddwss@gmail.com,designation=DWSS Authority',0);

