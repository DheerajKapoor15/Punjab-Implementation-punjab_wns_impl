update eg_demand_reason_master set reasonmaster='Sewerage Connection Fee' where reasonmaster='Sewerage SuperVision Fee' and module=(select id from eg_module where name = 'Sewerage Tax Management');
update egcl_collectiondetails set description=replace(description, 'Sewerage SuperVision Charges', 'Sewerage Connection Fee') where description like 'Sewerage SuperVision Charges%';
update egcl_collectiondetails set description=replace(description, 'Sewerage SuperVision Fee', 'Sewerage Connection Fee') where description like 'Sewerage SuperVision Fee%';