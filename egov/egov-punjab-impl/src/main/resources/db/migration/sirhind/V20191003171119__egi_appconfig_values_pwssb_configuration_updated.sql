
update eg_appconfig_values set value='cityName=Punjab Water Supply and Sewerage Board,contactNo=01763-222210,emailId=ees.pwssb@punjab.gov.in,designation=PWSSB Authority' where key_id in (select id from EG_APPCONFIG where key_name='PWSSB_CONFIGURATION');
