Insert into egcl_servicecategory (id,name,code,isactive,version,createdby,createddate,lastmodifiedby,lastmodifieddate) values (nextval('SEQ_EG_MODULE'),
'ICICI Payment Gateway','ICICI',true,0,1,now(),1,now());

Insert into egcl_servicedetails (id,name,serviceurl,isenabled,callbackurl,servicetype,code,fund,fundsource,functionary,vouchercreation,scheme,
subscheme,servicecategory,isvoucherapproved,vouchercutoffdate,created_by,created_date,modified_by,modified_date,ordernumber) values 
(nextval('seq_egcl_servicedetails'),'ICICI Payment Gateway','https://eazypay.icicibank.com/EazyPG',true,
'https://jalandhar.lgpunjab.gov.in/collection/citizen/onlineReceipt-acceptMessageFromPG.action','P','ICICI',1,null,null,true,null,null,
(select id from egcl_servicecategory where code='ICICI'),true,null,1,now(),1,now(),1);


update eg_appconfig_values set value='WT|ICICI' where key_id =(select id from eg_appconfig where KEY_NAME ='BILLINGSERVICEPAYMENTGATEWAY');
update chartofaccounts set name ='Receivables control accounts-ICICI Bank Gateway' where glcode='4318002';
update EGCL_SERVICE_INSTRUMENTACCOUNTS set servicedetails=(select id from egcl_servicedetails where code='ICICI')  where servicedetails= (select id from egcl_servicedetails where code='AXIS');
----Disable AXIS 
update egcl_servicedetails set isenabled ='f' where name ='Axis Payment Gateway';
update egcl_servicecategory set isactive ='f' where code='AXIS';

---change callurl
update egcl_servicedetails set callbackurl ='https://'||(select domainurl from eg_city)||'/collection/citizen/onlineReceipt-acceptMessageFromPG.action' where code='ICICI';
update chartofaccounts set name = 'ICICI Nationalised Banks-State Bank of India' where glcode='4502101';
