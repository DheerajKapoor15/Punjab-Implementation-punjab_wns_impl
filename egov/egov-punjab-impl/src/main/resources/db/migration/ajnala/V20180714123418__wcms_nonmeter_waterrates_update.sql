update egwtr_watercharge_rates set rateamount=600 where usagetype in (select id from egwtr_usage_type where code in ('USAGE_COMM','USAGE_INST'));
