update eg_demand_reason_master set "order"=1 where code='PENALTY' and module = (select id from eg_module where name='Sewerage Tax Management');
update eg_demand_reason_master set "order"=2 where code='INTEREST' and module = (select id from eg_module where name='Sewerage Tax Management');
update eg_demand_reason_master set "order"=3 where code='SEWERAGETAX' and module = (select id from eg_module where name='Sewerage Tax Management');
update eg_demand_reason_master set "order"=4 where code='SEWERAGEADVANCE' and module = (select id from eg_module where name='Sewerage Tax Management');
