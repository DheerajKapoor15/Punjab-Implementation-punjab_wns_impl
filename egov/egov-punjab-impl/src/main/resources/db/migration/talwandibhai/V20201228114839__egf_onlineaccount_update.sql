update chartofaccounts set name='Axis Bank TalwandiBhai branch-914020024951544' where name='Axis Bank TalwandiBhai branch-918010047938471';

update bankaccount set isactive='f' where accountnumber = '918010047938471';

insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby, 
createddate, lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), 
'914020024951544', true, (select id from chartofaccounts where glcode='4502101'), (select id from fund where code='01'), 
'RECEIPTS', 1, 1, now(), now(), 0);

  
