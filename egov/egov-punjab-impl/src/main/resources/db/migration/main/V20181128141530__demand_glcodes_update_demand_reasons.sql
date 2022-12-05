
--Water
update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1402012') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='PENALTY' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1402012') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='BREAKDOWN_PENALTY' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1100201') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTAXCHARGES' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1404009') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTAXOTHERS' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1405009') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTAXROADCUTTING' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1404003') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTAXSUPERVISION' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1501102') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTAXAPPLICATION' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1100202') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='INTEREST' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='3402001') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTAXSECURITY' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='3504102') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='WTADVANCE' and module=(select id from eg_module where name='Water Tax Management'));


--Sewerage
update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1402011') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='PENALTY' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1100301') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='SEWERAGETAX' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1404009') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='STAXOTHERS' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1405009') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='STAXROADCUTTING' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1404003') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='STAXSUPERVISION' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1501107') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='STAXAPPLICATION' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1100303') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='INTEREST' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='3402004') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='STAXSECURITY' and module=(select id from eg_module where name='Sewerage Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='3504103') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where code='SEWERAGEADVANCE' and module=(select id from eg_module where name='Sewerage Tax Management'));


