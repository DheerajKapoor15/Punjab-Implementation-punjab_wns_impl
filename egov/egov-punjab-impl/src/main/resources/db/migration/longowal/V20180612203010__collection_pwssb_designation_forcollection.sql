
update eg_appconfig_values set value='Junior Engineer' where key_id = (select id from eg_appconfig where key_name='COLLECTIONDESIGNATIONFORCSCOPERATORASCLERK' and module=(select id from eg_module where name='Collection'));

