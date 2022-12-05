--Usage Type
INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egwtr_usage_type'), 'DOMESTIC_EXEMPTED', 'USAGE_DOM_EXEM', true, now(), now(), 1, 1, 0);


--new rates

insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,
minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 
'DOMESTIC_EXEMPTED'),null,null,'2021-05-31', '2025-03-31',null,0,now(),now(),1,1);
