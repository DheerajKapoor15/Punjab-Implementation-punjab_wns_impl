update chartofaccounts set name='Axis Bank Talwandi sabo branch-919010062684910' where name='Axis Bank Talwandi sabo branch-918010041091185';

update bankaccount set isactive='f' where accountnumber = '918010041091185';

insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby, createddate, lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), '919010062684910', true, (select id from chartofaccounts where glcode='4502001'), (select id from fund where code='01'), 'RECEIPTS', 1, 1, now(), now(), 0);