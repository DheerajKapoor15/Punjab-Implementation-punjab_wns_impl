update egwtr_watercharge_rates set usagetype=(select id from egwtr_usage_type where name='INSTITUTIONAL') where usagetype is null;
