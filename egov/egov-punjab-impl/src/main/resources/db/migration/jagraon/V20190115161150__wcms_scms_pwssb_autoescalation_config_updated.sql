update eg_appconfig_values set value = 'Executive Officer' where key_id = (select id from eg_appconfig where key_name = 'WATER_APPROVE_DESIGNATION');

update eg_appconfig_values set value = 'Executive Officer' where key_id = (select id from eg_appconfig where key_name = 'SEWERAGE_APPROVE_DESIGNATION');