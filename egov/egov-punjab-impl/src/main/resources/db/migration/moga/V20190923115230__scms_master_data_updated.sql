update egswtax_seweragecharge_rates set ratetype='FIXED' where usagetype in (select id from egswtax_usage_type where name in ('DOMESTIC_SLC','DOMESTIC_NSLC','COMMERCIAL_SLC','COMMERCIAL_NSLC'));