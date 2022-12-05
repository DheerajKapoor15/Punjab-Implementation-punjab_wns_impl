update egswtax_seweragecharge_rates set rateamount=600 where usagetype in (select id from egswtax_usage_type where code in ('USAGE_COMM','USAGE_INST'));
