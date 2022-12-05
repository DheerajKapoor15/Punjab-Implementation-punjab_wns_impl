update eg_appconfig_values set value='10' where key_id = (select id from eg_appconfig where key_name='PANALTY_PERCENTAGE' and module=(select id from eg_module where name='Water Tax Management'));


--If Municipal Council (Class I, II, III)
--update eg_appconfig_values set value = 'Executive Officer' where key_id = (select id from eg_appconfig where key_name = 'WATER_APPROVE_DESIGNATION');

--If Municipal Corporation
--update eg_appconfig_values set value = 'Executive Engineer/Municipal Engineer/Corporation Engineer' where key_id = (select id from eg_appconfig where key_name = 'WATER_APPROVE_DESIGNATION');

