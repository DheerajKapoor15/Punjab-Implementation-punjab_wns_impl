insert into bankbranch (id, branchcode, branchname,  branchaddress1, branchcity, bankid, isactive, createddate, lastmodifieddate, lastmodifiedby, version, createdby) values(nextval('seq_bankbranch'), '001', 'Ropar Punjab', 'Ropar', 'Ropar', (select id from bank where code='UTIB'), true, now(), now(), 1, 0, 1);

delete from chartofaccounts where glcode like '45021%';

INSERT INTO chartofaccounts (id, glcode, name, isactiveforposting, parentid, createddate, type, classification, functionreqd, budgetcheckreq, majorcode, createdby) VALUES (nextval('seq_chartofaccounts'), '4502101', 'Axis Bank Ropar branch-918010082843464', true, (select id from chartofaccounts where glcode='45021'), now(), 'A', 4, false, false, '450', 1);

insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby, createddate, lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), '918010082843464', true, (select id from chartofaccounts where glcode='4502101'), (select id from fund where code='01'), 'RECEIPTS', 1, 1, now(), now(), 0);

update egf_instrumentaccountcodes set glcodeid = (select id from chartofaccounts where glcode='4502101') where typeid =(select id from egf_instrumenttype where type='online');

update egcl_service_instrumentaccounts set chartofaccounts = (select id from chartofaccounts where glcode='4502101') where servicedetails= (select id from egcl_servicedetails where code='AXIS');
