update eg_demand_reason_master set category = (select id from eg_reason_category where code = 'ADVANCE') where code = 'WTADVANCE';
