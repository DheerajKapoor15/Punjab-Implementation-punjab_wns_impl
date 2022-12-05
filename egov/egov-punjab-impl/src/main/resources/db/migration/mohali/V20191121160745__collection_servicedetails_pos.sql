Insert into egcl_servicecategory (id,name,code,isactive,version,createdby,createddate,lastmodifiedby,lastmodifieddate) values (nextval('SEQ_EG_MODULE'),'POS Third Party','POS',false,0,1,current_timestamp,1,current_timestamp);

Insert into egcl_servicedetails (ID,NAME,SERVICEURL,ISENABLED,CALLBACKURL,SERVICETYPE,CODE,FUND,FUNDSOURCE,FUNCTIONARY,VOUCHERCREATION,SCHEME,SUBSCHEME,SERVICECATEGORY,
ISVOUCHERAPPROVED,VOUCHERCUTOFFDATE,CREATED_BY,created_date,modified_by,modified_date) values (nextval('seq_egcl_servicedetails'),'POS Third Party','',true,'','P','POS',null,null,null,false,null,null,(select id from egcl_servicecategory where code='POS'),false,null,1,current_timestamp,1,current_timestamp);

insert into EGCL_SERVICE_INSTRUMENTACCOUNTS(id, instrumenttype, servicedetails, chartofaccounts, createdby, createddate, lastmodifiedby, lastmodifieddate) values(nextval('seq_egcl_service_instrumentaccounts'),(select id from egf_instrumenttype where type ='online'),(select id from egcl_servicedetails where code='POS'), (select id from chartofaccounts where glcode='4502004'),1,now(),1,now());

insert into EGCL_SERVICE_INSTRUMENTACCOUNTS(id, instrumenttype, servicedetails, chartofaccounts, createdby, createddate, lastmodifiedby, lastmodifieddate) values(nextval('seq_egcl_service_instrumentaccounts'),(select id from egf_instrumenttype where type ='cash'),(select id from egcl_servicedetails where code='POS'), (select id from chartofaccounts where glcode='4501001'),1,now(),1,now());
