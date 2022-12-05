update eg_demand_reason set glcodeid=(select id from chartofaccounts where glcode='1100201') where glcodeid =(select id from chartofaccounts where glcode='1806006');

update chartofaccounts set name='Water/Sewerage Charges Advance Collection' where glcode='3504106';
