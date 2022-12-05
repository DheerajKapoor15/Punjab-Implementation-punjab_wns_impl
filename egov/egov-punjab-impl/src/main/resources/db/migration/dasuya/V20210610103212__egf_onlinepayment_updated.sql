update chartofaccounts set name='RAZORPAY Bank Dasuya branch-920010007811876' where name='RAZORPAY Bank Dasuya branch-915020003642189';
update bankaccount set isactive='f' where accountnumber = '915020003642189';
insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby, 
createddate, lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), 
'920010007811876', true, (select id from chartofaccounts where glcode='4502101'), (select id from fund where code='01'), 
'RECEIPTS', 1, 1, now(), now(), 0);
update bankaccount set narration ='acc_HIwFoMCglBzESl' where accountnumber = '920010007811876';