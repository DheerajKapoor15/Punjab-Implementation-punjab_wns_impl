update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1100301') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where reasonmaster='Sewerage Tax' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1718001') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where reasonmaster='Penalty' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1718001') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where reasonmaster='Interest' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='3504106') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where reasonmaster='SEWERAGEADVANCE' and module=(select id from eg_module where name='Sewerage Tax Management'));