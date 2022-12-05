
update eg_appconfig_values set value='NO' where KEY_ID = (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='IS_PWSSB_ULB' and module=(select id from eg_module where name='Administration'));

delete from eg_department where name='PWSSB';

delete from egeis_employeetype where name='PWSSB';
