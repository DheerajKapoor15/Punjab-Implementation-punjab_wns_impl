
insert into bankbranch(id,branchcode,branchname,branchaddress1,bankid,isactive,createddate,lastmodifieddate,lastmodifiedby)
values(nextval('seq_bankbranch'),'PHS5','PHASE 5','Punjab',(select id from bank where code='ICIC'),true,now(),now(),1);


insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'4502002','ICICI BANK-PHASE 5-189601000411','ICICI BANK-PHASE 5-189601000411',true,(select id from chartofaccounts where glcode='45020'),now(),1,now(),null,null,'A',null,4,true,false,null,null,null,null,null,450,1,null,null);


insert into bankaccount(id,branchid,accountnumber,accounttype,narration,isactive,glcodeid,fundid,type,createdby,lastmodifiedby,createddate,lastmodifieddate,version)
values(nextval('seq_bankaccount'),(select id from bankbranch where branchcode='PHS5'),'189601000411','OTHER SCHEDULED BANKS',null,true,(select id from chartofaccounts where glcode='4502002'),(select id from fund where code='01'),'RECEIPTS',1,1,now(),now(),0);

insert into bankbranch(id,branchcode,branchname,branchaddress1,bankid,isactive,createddate,lastmodifieddate,lastmodifiedby)
values(nextval('seq_bankbranch'),'PHS3B2','PHASE 3B-2','Punjab',(select id from bank where code='INDB'),true,now(),now(),1);


insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'4502003','IndusInd Bank Ltd.-PHASE 3B-2-100030803100','IndusInd Bank Ltd.-PHASE 3B-2-100030803100',true,(select id from chartofaccounts where glcode='45020'),now(),1,now(),null,null,'A',null,4,true,false,null,null,null,null,null,450,1,null,null);


insert into bankaccount(id,branchid,accountnumber,accounttype,narration,isactive,glcodeid,fundid,type,createdby,lastmodifiedby,createddate,lastmodifieddate,version)
values(nextval('seq_bankaccount'),(select id from bankbranch where branchcode='PHS3B2'),'100030803100','OTHER SCHEDULED BANKS',null,true,(select id from chartofaccounts where glcode='4502003'),(select id from fund where code='01'),'RECEIPTS_PAYMENTS',1,1,now(),now(),0);