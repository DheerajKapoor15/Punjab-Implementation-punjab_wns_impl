Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'),(select id from eg_action where url='/ajax-RoadCuttingChargesByRoadCuttingType' and contextroot='wtms'));
Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Water Tax Approver'),(select id from eg_action where url='/ajax-RoadCuttingChargesByRoadCuttingType' and contextroot='wtms'));


Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='CSC Operator'), (select id from eg_action where url='/ajax-RoadSewerageCuttingChargesByRoadCuttingType' and contextroot='stms'));
INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'Sewerage Tax Approver'),  (select id from eg_action where url='/ajax-RoadSewerageCuttingChargesByRoadCuttingType' and contextroot='stms'));

