update chartofaccounts set name='RAZORPAY Bank Jagraon branch-920010002058740' where name='RAZORPAY Bank Jagraon branch-281010100087498';

update bankaccount set isactive='f' where accountnumber = '281010100087498';

insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby, 
createddate, lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), 
'920010002058740', true, 1314, 1,'RECEIPTS', 1, 1, now(), now(), 0);