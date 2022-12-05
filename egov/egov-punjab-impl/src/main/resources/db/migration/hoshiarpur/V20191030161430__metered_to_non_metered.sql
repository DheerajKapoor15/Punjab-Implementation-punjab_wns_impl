delete from egwtr_meter_reading_details where connectiondetails in (select id from egwtr_connectiondetails where usagetype in (select id from egwtr_usage_type where name='DOMESTIC'));

update egwtr_connectiondetails set connectiontype=(select id from egwtr_connection_type where name='Non-Metered') where id in (select id from egwtr_connectiondetails where connectiontype in (select id from egwtr_connection_type where name='Metered') and usagetype in (select id from egwtr_usage_type where name='DOMESTIC'));