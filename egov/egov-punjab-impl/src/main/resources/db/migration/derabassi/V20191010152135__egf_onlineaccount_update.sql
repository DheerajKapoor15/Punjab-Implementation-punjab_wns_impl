update chartofaccounts set name='Axis Bank DeraBassi branch-303010100073741' where name='Axis Bank DeraBassi branch-303010100042778';

update bankaccount set isactive='f' where accountnumber = '303010100042778';

insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby, createddate, lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), '303010100073741', true, (select id from chartofaccounts where glcode='4502001'), (select id from fund where code='01'), 'RECEIPTS', 1, 1, now(), now(), 0);