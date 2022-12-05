update egwtr_watercharge_rates set rateamount=840 where fromplotarea=251 and usagetype=(select id from egwtr_usage_type where code='USAGE_COMM');
