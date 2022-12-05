-- update call back url script for payment gateway

update egcl_servicedetails set callbackurl ='https://'||(select domainurl from eg_city)||'/collection/citizen/onlineReceipt-acceptMessageFromPaymentGateway.action' where code='AXIS';




