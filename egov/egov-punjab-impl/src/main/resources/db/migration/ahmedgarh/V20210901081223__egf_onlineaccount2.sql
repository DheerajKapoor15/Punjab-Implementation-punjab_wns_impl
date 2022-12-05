
update bankaccount set isactive='t' where accountnumber = '918010087741583';

insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby, createddate,
 lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), 
 '920010017376541', false, 1324, (select id from fund where code='01'), 
 'RECEIPTS', 1, 1, now(), now(), 0);
 
