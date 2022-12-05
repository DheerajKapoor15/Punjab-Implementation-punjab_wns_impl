update chartofaccounts set name='Axis Bank Abohar branch-918010083154826' where name='Axis Bank Abohar branch-918020071220208';

update bankaccount set isactive='f' where accountnumber='918020071220208';

insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby,
 createddate, lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), 
 '918010083154826', true, (select id from chartofaccounts where glcode='4502001'), (select id from fund where code='01'),
  'RECEIPTS', 1, 1, now(), now(), 0);