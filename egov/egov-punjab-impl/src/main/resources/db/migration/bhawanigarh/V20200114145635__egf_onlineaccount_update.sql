update bankaccount set isactive='f' where accountnumber='917010083785397';

insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby, createddate, lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), '918010086286296', true, (select id from chartofaccounts where glcode='4502001'), (select id from fund where code='01'), 'RECEIPTS', 1, 1, now(), now(), 0);

update chartofaccounts set name='Axis Bank Bhawanigarh branch-918010086286296' where name='Axis Bank Bhawanigarh branch-917010083785397';
