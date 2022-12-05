Insert into egcl_servicecategory (id,name,code,isactive,version,createdby,createddate,lastmodifiedby,lastmodifieddate) values (nextval('seq_egcl_servicecategory'),'Sewerage Tax','STAX',true,0,(select id from eg_user where username='egovernments'),now(),(select id from eg_user where username='egovernments'),now());

update egcl_servicedetails set servicecategory=(select id from egcl_servicecategory where code='STAX'), fund=(select id from fund where code='01') where code='STAX';

