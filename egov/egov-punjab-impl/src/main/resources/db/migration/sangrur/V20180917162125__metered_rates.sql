delete from egwtr_watermeteredcharge_rates;

--remove if no DOMESTIC usage type
insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'DOMESTIC'),0,125,'2018-01-01', '2020-03-31',0,null,now(),now(),1,1);

--remove if no DOMESTIC usage type
insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'DOMESTIC'),125,null,'2018-01-01', '2020-03-31',0.0018,null,now(),now(),1,1);

--remove if no COMMERCIAL usage type
insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'COMMERCIAL'),0,null,'2018-01-01', '2020-03-31',0.00325,null,now(),now(),1,1);

