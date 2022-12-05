-- Minor code
insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'43190','Receivables','Receivables',false,(select id from chartofaccounts where glcode='431'),now(),1,now(),null,null,'A',null,2,null,null,null,null,null,null,null,431,1,null,null);
 
-- Detail code for Airtel
insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'4319004','Receivable from Airtel Payment','Receivable from Airtel Payment',true,(select id from chartofaccounts where glcode='43190'),now(),1,now(),null,null,'A',null,4,true,false,null,null,null,null,null,431,1,null,null);

-- Detail code for Freecharge
insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'4319005','Receivable from Freecharge Payment','Receivable from Freecharge Payment',true,(select id from chartofaccounts where glcode='43190'),now(),1,now(),null,null,'A',null,4,true,false,null,null,null,null,null,431,1,null,null);

-- Detail code for Paytm
insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'4319006','Receivable from Paytm Payment','Receivable from Paytm Payment',true,(select id from chartofaccounts where glcode='43190'),now(),1,now(),null,null,'A',null,4,true,false,null,null,null,null,null,431,1,null,null);

-- Detail code for Sewakendra
insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'4319007','Receivable from Sewakendra Payment','Receivable from Sewakendra Payment',true,(select id from chartofaccounts where glcode='43190'),now(),1,now(),null,null,'A',null,4,true,false,null,null,null,null,null,431,1,null,null);
