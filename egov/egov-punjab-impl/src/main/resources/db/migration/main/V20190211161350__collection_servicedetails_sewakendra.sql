Insert into egcl_servicecategory (id,name,code,isactive,version,createdby,createddate,lastmodifiedby,lastmodifieddate) values (nextval('SEQ_EG_MODULE'),'Sewakendra Third Party','SEWAKENDRA',false,0,1,current_timestamp,1,current_timestamp);

Insert into egcl_servicedetails (ID,NAME,SERVICEURL,ISENABLED,CALLBACKURL,SERVICETYPE,CODE,FUND,FUNDSOURCE,FUNCTIONARY,
VOUCHERCREATION,SCHEME,SUBSCHEME,SERVICECATEGORY,ISVOUCHERAPPROVED,VOUCHERCUTOFFDATE,CREATED_BY,created_date,
modified_by,modified_date) values 
(nextval('seq_egcl_servicedetails'),'Sewakendra Third Party','',true,'',
'P','SEWAKENDRA',null,null,null,false,null,null,(select id from egcl_servicecategory where code='SEWAKENDRA'),true,null,1,current_timestamp,1,current_timestamp);

Insert into EGCL_SERVICE_INSTRUMENTACCOUNTS(id, instrumenttype, servicedetails, chartofaccounts, createdby, createddate, lastmodifiedby, lastmodifieddate) values(nextval('seq_egcl_service_instrumentaccounts'),(select id from egf_instrumenttype  where type ='online'),(select id from egcl_servicedetails where  code='SEWAKENDRA'), (select id from chartofaccounts where glcode='4319007'),1,now(),1,now()); 

