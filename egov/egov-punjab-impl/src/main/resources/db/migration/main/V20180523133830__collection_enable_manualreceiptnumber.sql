update eg_appconfig_values set value='Y' where key_id =(select id from eg_appconfig where KEY_NAME ='MANUALRECEIPTINFOREQUIRED' and module=(select id from eg_module where name='Collection')) ;
