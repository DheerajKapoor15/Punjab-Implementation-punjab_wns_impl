delete from egwtr_watermeteredcharge_rates;

--remove if no DOMESTIC usage type
insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'DOMESTIC'),1,null,'2018-04-01', '2020-03-31',3.80,null,now(),now(),1,1);

--remove if no COMMERCIAL usage type
insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'COMMERCIAL'),1,null,'2018-04-01', '2020-03-31',7.60,null,now(),now(),1,1);

--remove if no INSTITUTIONAL usage type
insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'INSTITUTIONAL'),1,null,'2018-04-01', '2020-03-31',150,null,now(),now(),1,1);
