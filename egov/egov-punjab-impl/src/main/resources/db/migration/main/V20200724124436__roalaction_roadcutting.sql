insert into eg_action values ( nextval('seq_eg_action'),'roadCuttingChargesByRoadCuttingType','/ajax-RoadCuttingChargesByRoadCuttingType',null,(select id from eg_module where name='Water Tax Management'),
null,'populateroadCuttingChargesByRoadCuttingType',false,'wtms',0,1,now(),1, now(),420);

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='ULB Operator'), (select id from eg_action where url='/ajax-RoadCuttingChargesByRoadCuttingType' and contextroot='wtms'));


insert into eg_action values ( nextval('seq_eg_action'),'roadSewerageCuttingChargesByRoadCuttingType','/ajax-RoadSewerageCuttingChargesByRoadCuttingType',null,(select id from eg_module where name='Sewerage Tax Management'),
null,'populateroadsewerageCuttingChargesByRoadCuttingType',false,'stms',0,1,now(),1, now(),468);


insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='ULB Operator'), (select id from eg_action where url='/ajax-RoadSewerageCuttingChargesByRoadCuttingType' and contextroot='stms'));