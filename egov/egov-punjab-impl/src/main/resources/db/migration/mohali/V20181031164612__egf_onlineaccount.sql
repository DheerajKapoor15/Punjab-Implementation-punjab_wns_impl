insert into bankbranch(id,branchcode,branchname,branchaddress1,bankid,isactive,createddate,lastmodifieddate,lastmodifiedby)
values(nextval('seq_bankbranch'),'Mohali','Mohali','Mohali',(select id from bank where code='UTIB'),true,now(),now(),1);

insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'4502004','Axis Bank-Mohali-918010097736982','Axis Bank-Mohali-918010097736982',true,(select id from chartofaccounts where glcode='45020'),now(),1,now(),null,null,'A',null,4,true,false,null,null,null,null,null,450,1,null,null);

insert into bankaccount(id,branchid,accountnumber,accounttype,narration,isactive,glcodeid,fundid,type,createdby,lastmodifiedby,createddate,lastmodifieddate,version)
values(nextval('seq_bankaccount'),(select id from bankbranch where branchcode='Mohali'),'918010097736982','OTHER SCHEDULED BANKS',null,true,(select id from chartofaccounts where glcode='4502004'),(select id from fund where code='01'),'RECEIPTS',1,1,now(),now(),0);

update egf_instrumentaccountcodes set glcodeid = (select id from chartofaccounts where glcode='4502004') where typeid =(select id from egf_instrumenttype where type='online');

update egcl_service_instrumentaccounts set chartofaccounts = (select id from chartofaccounts where glcode='4502004') where servicedetails= (select id from egcl_servicedetails where code='AXIS');
