update eg_appconfig_values set value=3 where key_id in (select id from eg_appconfig where module = (select id from eg_module where name='Water Tax Management') and key_name = 'BREAKDOWN_PENALTY_MULTIPLIER');