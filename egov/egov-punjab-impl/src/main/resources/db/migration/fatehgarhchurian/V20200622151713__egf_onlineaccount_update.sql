update bankaccount set isactive='f' where accountnumber='918020081282911';

insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby, createddate, 
lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), 
'920010039458009', true, (select id from chartofaccounts where glcode='4502001'), (select id from fund where code='01'), 
'RECEIPTS', 1, 1, now(), now(), 0);

update chartofaccounts set name='Axis Bank FatehgarhChurian branch-920010039458009' where name='Axis Bank FatehgarhChurian branch-918020081282911';