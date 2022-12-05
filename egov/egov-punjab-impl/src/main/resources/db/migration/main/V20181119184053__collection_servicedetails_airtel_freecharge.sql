Insert into egcl_servicecategory (id,name,code,isactive,version,createdby,createddate,lastmodifiedby,lastmodifieddate) values (nextval('SEQ_EG_MODULE'),'Airtel Third Party','AIRTEL',true,0,1,current_timestamp,1,current_timestamp);


Insert into egcl_servicedetails (ID,NAME,SERVICEURL,ISENABLED,CALLBACKURL,SERVICETYPE,CODE,FUND,FUNDSOURCE,FUNCTIONARY,
VOUCHERCREATION,SCHEME,SUBSCHEME,SERVICECATEGORY,ISVOUCHERAPPROVED,VOUCHERCUTOFFDATE,CREATED_BY,created_date,
modified_by,modified_date) values 
(nextval('seq_egcl_servicedetails'),'Airtel Third Party','',true,'',
'P','AIRTEL',null,null,null,false,null,null,(select id from egcl_servicecategory where code='AIRTEL'),true,null,1,current_timestamp,1,current_timestamp);


Insert into egcl_servicecategory (id,name,code,isactive,version,createdby,createddate,lastmodifiedby,lastmodifieddate) values (nextval('SEQ_EG_MODULE'),'Freecharge Third Party','FREECHARGE',true,0,1,current_timestamp,1,current_timestamp);


Insert into egcl_servicedetails (ID,NAME,SERVICEURL,ISENABLED,CALLBACKURL,SERVICETYPE,CODE,FUND,FUNDSOURCE,FUNCTIONARY,
VOUCHERCREATION,SCHEME,SUBSCHEME,SERVICECATEGORY,ISVOUCHERAPPROVED,VOUCHERCUTOFFDATE,CREATED_BY,created_date,
modified_by,modified_date) values 
(nextval('seq_egcl_servicedetails'),'Freecharge Third Party','',true,'',
'P','FREECHARGE',null,null,null,false,null,null,(select id from egcl_servicecategory where code='FREECHARGE'),true,null,1,current_timestamp,1,current_timestamp);
