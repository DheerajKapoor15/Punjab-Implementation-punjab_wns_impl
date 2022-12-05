update bankaccount set isactive='f' where accountnumber='918020081900965';

insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby, createddate, 
lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), 
'920010040378709', true, (select id from chartofaccounts where glcode='4502101'), (select id from fund where code='01'), 
'RECEIPTS', 1, 1, now(), now(), 0);

update chartofaccounts set name='Axis Bank Quadian branch-920010040378709' where name='Axis Bank Quadian branch-918020081900965';