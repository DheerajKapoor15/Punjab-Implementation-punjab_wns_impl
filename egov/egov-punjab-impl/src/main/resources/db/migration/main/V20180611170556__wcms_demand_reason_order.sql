update eg_demand_reason_master set "order"=1 where code='PENALTY' and module = (select id from eg_module where name='Water Tax Management');
update eg_demand_reason_master set "order"=2 where code='INTEREST' and module = (select id from eg_module where name='Water Tax Management');
update eg_demand_reason_master set "order"=3 where code='WTAXCHARGES' and module = (select id from eg_module where name='Water Tax Management');
update eg_demand_reason_master set "order"=4 where code='WTADVANCE' and module = (select id from eg_module where name='Water Tax Management');
