--razorpay service category
Insert into egcl_servicecategory (id,name,code,isactive,version,createdby,createddate,lastmodifiedby,lastmodifieddate) values (nextval('SEQ_EG_MODULE'),
'Razorpay Payment Gateway','RAZORPAY',true,0,1,now(),1,now());

-- razorpay payment gatewayservice details
Insert into egcl_servicedetails (id,name,serviceurl,isenabled,callbackurl,servicetype,code,fund,fundsource,functionary,vouchercreation,scheme,
subscheme,servicecategory,isvoucherapproved,vouchercutoffdate,created_by,created_date,modified_by,modified_date,ordernumber) values 
(nextval('seq_egcl_servicedetails'),'Razorpay Payment Gateway','https://api.razorpay.com/v1',true,
'http://dev4.governation.com//collection/citizen/onlineReceipt-acceptMessageFromPaymentGateway.action','P','RAZORPAY',1,null,null,true,null,null,
(select id from egcl_servicecategory where code='RAZORPAY'),true,null,1,now(),1,now(),1);


--appconfig values for razorpay payment gateway

update eg_appconfig_values set value='WT|RAZORPAY' where key_id =(select id from eg_appconfig where KEY_NAME ='BILLINGSERVICEPAYMENTGATEWAY');

---update chartofaccounts and EGCL_SERVICE_INSTRUMENTACCOUNTS
update chartofaccounts set name ='Receivables control accounts-Razorpay Bank Gateway' where glcode='4318002';

update EGCL_SERVICE_INSTRUMENTACCOUNTS set servicedetails=(select id from egcl_servicedetails where code='RAZORPAY')  where servicedetails= (select id from egcl_servicedetails where code='AXIS');
----Disable AXIS 
update egcl_servicedetails set isenabled ='f' where name ='Axis Payment Gateway';
update egcl_servicecategory set isactive ='f' where code='AXIS';

---change callurl
update egcl_servicedetails set callbackurl ='https://'||(select domainurl from eg_city)||'/collection/citizen/onlineReceipt-acceptMessageFromPaymentGateway.action' where code='RAZORPAY';
update chartofaccounts set name = 'RAZORPAY Bank Mall Road branch-918010058959177' where glcode='4502101';
update bankaccount set narration ='acc_FVkKLvpjnqelJU' where accountnumber='918010058959177';