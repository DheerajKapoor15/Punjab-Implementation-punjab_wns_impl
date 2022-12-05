delete from EGCL_SERVICE_INSTRUMENTACCOUNTS WHERE servicedetails = (select id from egcl_servicedetails where  code='AXIS');

Insert into EGCL_SERVICE_INSTRUMENTACCOUNTS(id, instrumenttype, servicedetails, chartofaccounts, createdby, createddate, lastmodifiedby, lastmodifieddate) values(nextval('seq_egcl_service_instrumentaccounts'),(select id from egf_instrumenttype  where type ='online'),(select id from egcl_servicedetails where  code='AXIS'), (select id from chartofaccounts where glcode='4318002'),1,now(),1,now()); 
