
update eg_module set displayname ='Masters' where name='sewerageMasters';

update eg_action set parentmodule = (select id from eg_module where name='SewerageTransactions') where name='LegacySewerageConnection' and contextroot='stms';
update eg_action set parentmodule = (select id from eg_module where name='SewerageTransactions') where name='SearchLegacySewerageConnection' and contextroot='stms';

update eg_action set ordernumber=1 where name='LegacySewerageConnection' and contextroot='stms';
update eg_action set ordernumber=2 where name='SearchSewerageConnection' and contextroot='stms';
update eg_action set ordernumber=3 where name='SearchLegacySewerageConnection' and contextroot='stms';
update eg_action set ordernumber=4 where name='Auto Generate Demand For Sewerage' and contextroot='stms';
update eg_action set ordernumber=5 where name='SewerageDemandStatusSearch' and contextroot='stms';
update eg_action set ordernumber=6 where name='GenerateSewerageBil' and contextroot='stms';
update eg_action set ordernumber=7 where name='SearchSewerageCharges' and contextroot='stms';
