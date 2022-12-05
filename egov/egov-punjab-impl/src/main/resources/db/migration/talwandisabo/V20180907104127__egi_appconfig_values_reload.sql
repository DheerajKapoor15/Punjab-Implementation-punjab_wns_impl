delete from eg_appconfig_values;
insert into eg_appconfig_values (id, key_id, effective_from, value, createddate, lastmodifieddate, createdby, lastmodifiedby, version) select nextval('seq_eg_appconfig_values'), key_id, effective_from, value, createddate, lastmodifieddate, createdby, lastmodifiedby, version from longowal.eg_appconfig_values;

update eg_appconfig_values set value='0' where key_id = (select id from eg_appconfig where key_name='INTEREST_PERCENTAGE' and module=(select id from eg_module where name='Sewerage Tax Management'));
update eg_appconfig_values set value='0' where key_id = (select id from eg_appconfig where key_name='INTEREST_PERIOD' and module=(select id from eg_module where name='Sewerage Tax Management'));
update eg_appconfig_values set value='25' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERCENTAGE' and module=(select id from eg_module where name='Sewerage Tax Management'));
update eg_appconfig_values set value='15' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERIOD' and module=(select id from eg_module where name='Sewerage Tax Management'));
UPDATE eg_appconfig_values SET value='PLOT_BASED' WHERE key_id = (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='TAX_RATETYPE' and module=(select id from eg_module where name='Sewerage Tax Management'));