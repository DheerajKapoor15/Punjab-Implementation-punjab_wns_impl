Insert into egcl_servicecategory (id,name,code,isactive,version,createdby,createddate,lastmodifiedby,lastmodifieddate) values (nextval('SEQ_EG_MODULE'),'Paytm Third Party','PAYTM',false,0,1,current_timestamp,1,current_timestamp);


Insert into egcl_servicedetails (ID,NAME,SERVICEURL,ISENABLED,CALLBACKURL,SERVICETYPE,CODE,FUND,FUNDSOURCE,FUNCTIONARY,
VOUCHERCREATION,SCHEME,SUBSCHEME,SERVICECATEGORY,ISVOUCHERAPPROVED,VOUCHERCUTOFFDATE,CREATED_BY,created_date,
modified_by,modified_date) values 
(nextval('seq_egcl_servicedetails'),'Paytm Third Party','',true,'',
'P','PAYTM',null,null,null,false,null,null,(select id from egcl_servicecategory where code='PAYTM'),true,null,1,current_timestamp,1,current_timestamp);
