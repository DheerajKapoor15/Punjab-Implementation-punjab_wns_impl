delete from egwtr_watermeteredcharge_rates;

insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'DOMESTIC'),null,null,'2018-01-01', '2020-03-31',null,50,now(),now(),1,1);


insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'DOMESTIC'),1,null,'2018-01-01', '2020-03-31',3.80,null,now(),now(),1,1);


insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'COMMERCIAL'),null,null,'2018-01-01', '2020-03-31',null,100,now(),now(),1,1);


insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'COMMERCIAL'),1,null,'2018-01-01', '2020-03-31',7.60,null,now(),now(),1,1);
