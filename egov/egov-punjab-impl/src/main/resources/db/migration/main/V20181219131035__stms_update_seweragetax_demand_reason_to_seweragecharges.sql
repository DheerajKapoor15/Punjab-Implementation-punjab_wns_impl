update eg_demand_reason_master set reasonmaster='Sewerage Charges' where reasonmaster='Sewerage Tax' and module=(select id from eg_module where name = 'Sewerage Tax Management');
update egcl_collectiondetails set description=replace(description, 'Sewerage Tax', 'Sewerge Charges') where description like 'Sewerage Tax%';
update eg_bill_details set description=replace(description, 'Sewerage Tax', 'Sewerge Charges') where description like 'Sewerage Tax%';
update egswtax_fees_master set description ='Sewerage Charges' where description='Sewerage Tax'