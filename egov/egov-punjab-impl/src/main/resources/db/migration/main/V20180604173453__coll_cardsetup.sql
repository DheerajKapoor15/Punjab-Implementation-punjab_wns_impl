insert into EGF_INSTRUMENTACCOUNTCODES(id,typeid,glcodeid,createdby,lastmodifiedby,createddate,lastmodifieddate) 
values(nextval('seq_EGF_INSTRUMENTACCOUNTCODES'),(select id from egf_instrumenttype where type='card'),(select id from chartofaccounts where name='Cash-Cash In Transit'),1,1,now(),now());

