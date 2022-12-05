--Sewerage
update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1402005') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='PENALTY' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1405009') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='SEWERAGETAX' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1501104') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='STAXAPPLICATION' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1405009') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='STAXOTHERS' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1407001') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='STAXROADCUTTING' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1407014') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='STAXSUPERVISION' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='3402002') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='STAXSECURITY' and module=(select id from eg_module where name='Sewerage Tax Management'));


--Water
update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1402005') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='PENALTY' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1405013') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTAXCHARGES' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1501104') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTAXAPPLICATION' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1405013') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTAXOTHERS' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1407001') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTAXROADCUTTING' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1407014') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTAXSUPERVISION' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='3402002') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTAXSECURITY' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1405013') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='BREAKDOWN_PENALTY' and module=(select id from eg_module where name='Water Tax Management'));
