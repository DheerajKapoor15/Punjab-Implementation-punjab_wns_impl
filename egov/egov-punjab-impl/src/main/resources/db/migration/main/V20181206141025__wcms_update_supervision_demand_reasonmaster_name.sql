update eg_demand_reason_master set reasonmaster='Water Connection Fee' where reasonmaster='Water SuperVision Fee' and module=(select id from eg_module where name = 'Water Tax Management');
update egcl_collectiondetails set description=replace(description, 'Water SuperVision Charges', 'Water Connection Fee') where description like 'Water SuperVision Charges%';
update egcl_collectiondetails set description=replace(description, 'Water SuperVision Fee', 'Water Connection Fee') where description like 'Water SuperVision Fee%';
