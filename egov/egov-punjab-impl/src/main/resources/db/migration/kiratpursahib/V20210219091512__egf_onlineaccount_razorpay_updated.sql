insert into bankaccount (id,branchid,accountnumber,isactive,glcodeid,fundid,type,createdby,lastmodifiedby,createddate,lastmodifieddate,version)
values(nextval('seq_bankaccount'),(select id from bankbranch where branchcode='001'),'912010014043283',true,
(select id from chartofaccounts where glcode='4502101'),(select id from fund where code='01'),'RECEIPTS',1,1,now(),now(),0);

update bankaccount set narration ='' where accountnumber='912010014043283';