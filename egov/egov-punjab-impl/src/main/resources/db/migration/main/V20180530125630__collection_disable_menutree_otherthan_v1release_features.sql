
update eg_module set enabled=false where name in ('Billbased Services', 'Bank Branch User Mapping');

update eg_action set enabled=false where name in ('ServiceToBankMapping','ServiceTypeToBankAccountMappingList')  and contextroot='collection';
