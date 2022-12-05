update chartofaccounts set name='Axis Bank Bhucho Mandi branch-918010058959148' where name='Axis Bank Bhucho Mandi branch-918010058959197';

update bankaccount set isactive='f' where accountnumber = '918010058959197';

insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby,
 createddate, lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), 
 '918010058959148', true, (select id from chartofaccounts where glcode='4502101'), (select id from fund where code='01'),
  'RECEIPTS', 1, 1, now(), now(), 0);
