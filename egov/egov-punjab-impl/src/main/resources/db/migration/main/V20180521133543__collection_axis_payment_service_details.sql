
--service category
Insert into egcl_servicecategory (id,name,code,isactive,version,createdby,createddate,lastmodifiedby,lastmodifieddate) values (nextval('SEQ_EG_MODULE'),'Axis Payment Gateway','AXIS',true,0,1,now(),1,now());
Insert into egcl_servicecategory (id,name,code,isactive,version,createdby,createddate,lastmodifiedby,lastmodifieddate) values (nextval('SEQ_EG_MODULE'),'Water Tax','WT',true,0,1,now(),1,now());

-- axis payment gatewayservice details
Insert into egcl_servicedetails (id,name,serviceurl,isenabled,callbackurl,servicetype,code,fund,fundsource,functionary,vouchercreation,scheme,subscheme,servicecategory,isvoucherapproved,vouchercutoffdate,created_by,created_date,modified_by,modified_date,ordernumber) values (nextval('seq_egcl_servicedetails'),'Axis Payment Gateway','https://migs.mastercard.com.au/vpcpay',true,'https://dev4.governation.com/collection/citizen/onlineReceipt-acceptMessageFromPaymentGateway.action','P','AXIS',1,null,null,true,null,null,(select id from egcl_servicecategory where code='AXIS'),true,null,1,now(),1,now(),1);

--appconfig values for axis payment gateway

update eg_appconfig_values set value='WT|AXIS' where key_id =(select id from eg_appconfig where KEY_NAME ='BILLINGSERVICEPAYMENTGATEWAY');

--update water charges service category in service details

update egcl_servicedetails set servicecategory=(select id from egcl_servicecategory where code='WT') where code='WT';
