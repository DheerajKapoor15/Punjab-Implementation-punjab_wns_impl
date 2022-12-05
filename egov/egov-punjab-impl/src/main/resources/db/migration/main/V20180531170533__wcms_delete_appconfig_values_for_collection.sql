delete from eg_appconfig_values where key_id in (select id from eg_appconfig where key_name='DEPTCODEFORGENERATEBILL');
delete from eg_appconfig_values where key_id in (select id from eg_appconfig where key_name='SERVICECODEFORGENERATEBILL');
delete from eg_appconfig_values where key_id in (select id from eg_appconfig where key_name='ESTSERVICECODEFORGENERATEBILL');
delete from eg_appconfig_values where key_id in (select id from eg_appconfig where key_name='FUNDSOURCECODEFORGENERATEBILL');
delete from eg_appconfig_values where key_id in (select id from eg_appconfig where key_name='FUNCTIONARYCODEFORGENERATEBILL');
delete from eg_appconfig_values where key_id in (select id from eg_appconfig where key_name='FUNDCODEFORGENERATEBILL');

delete from eg_appconfig where key_name='DEPTCODEFORGENERATEBILL';
delete from eg_appconfig where key_name='SERVICECODEFORGENERATEBILL';
delete from eg_appconfig where key_name='ESTSERVICECODEFORGENERATEBILL';
delete from eg_appconfig where key_name='FUNDSOURCECODEFORGENERATEBILL';
delete from eg_appconfig where key_name='FUNCTIONARYCODEFORGENERATEBILL';
delete from eg_appconfig where key_name='FUNDCODEFORGENERATEBILL';
