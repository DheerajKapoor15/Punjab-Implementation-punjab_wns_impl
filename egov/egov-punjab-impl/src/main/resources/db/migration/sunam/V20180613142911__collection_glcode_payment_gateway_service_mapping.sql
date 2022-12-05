-- Glcode mapping with payment gateway service

update egcl_service_instrumentaccounts set chartofaccounts = (select id from chartofaccounts where glcode='4502101') where servicedetails= (select id from egcl_servicedetails where code='AXIS');
