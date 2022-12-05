insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'4319008','Receivable from PayU Payment','Receivable from PayU Payment',true,(select id from chartofaccounts where glcode='43190'),now(),1,now(),null,null,'A',null,4,true,false,null,null,null,null,null,431,1,null,null);


Insert into egcl_servicecategory (id,name,code,isactive,version,createdby,createddate,lastmodifiedby,lastmodifieddate) values (nextval('SEQ_EG_MODULE'),'PayU Third Party','PAYU',false,0,1,current_timestamp,1,current_timestamp);

Insert into egcl_servicedetails (ID,NAME,SERVICEURL,ISENABLED,CALLBACKURL,SERVICETYPE,CODE,FUND,FUNDSOURCE,FUNCTIONARY,
VOUCHERCREATION,SCHEME,SUBSCHEME,SERVICECATEGORY,ISVOUCHERAPPROVED,VOUCHERCUTOFFDATE,CREATED_BY,created_date,
modified_by,modified_date) values 
(nextval('seq_egcl_servicedetails'),'PayU Third Party','',true,'',
'P','PAYU',null,null,null,false,null,null,(select id from egcl_servicecategory where code='PAYU'),true,null,1,current_timestamp,1,current_timestamp);

Insert into EGCL_SERVICE_INSTRUMENTACCOUNTS(id, instrumenttype, servicedetails, chartofaccounts, createdby, createddate, lastmodifiedby, lastmodifieddate) values(nextval('seq_egcl_service_instrumentaccounts'),(select id from egf_instrumenttype  where type ='online'),(select id from egcl_servicedetails where  code='PAYU'), (select id from chartofaccounts where glcode='4319008'),1,now(),1,now()); 
