delete from egwtr_watermeteredcharge_rates;

insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'DOMESTIC'),null,null,'2018-04-01', '2020-03-31',null,2,now(),now(),1,1);

insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'DOMESTIC'),1,null,'2018-04-01', '2020-03-31',1.5,null,now(),now(),1,1);

--remove if no COMMERCIAL usage type
insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'COMMERCIAL'),1,null,'2018-04-01', '2020-03-31',3.25,null,now(),now(),1,1);
insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'COMMERCIAL'),null,null,'2018-04-01', '2020-03-31',null,6,now(),now(),1,1);

insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'INSTITUTIONAL'),1,null,'2018-04-01', '2020-03-31',3.25,null,now(),now(),1,1);
insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'INSTITUTIONAL'),null,null,'2018-04-01', '2020-03-31',null,6,now(),now(),1,1);

insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'DOMESTIC_EXEMPTED'),null,null,'2018-04-01', '2020-03-31',null,0,now(),now(),1,1);

insert into egwtr_watermeteredcharge_rates(id,usagetype,fromvolume,tovolume,effectivefromdate,effectivetodate,rateamount,minimumamount,createddate,lastmodifieddate,createdby,lastmodifiedby)
values(nextval('seq_egwtr_watermeteredcharge_rates'),(select id from egwtr_usage_type where name = 'DOMESTIC_EXEMPTED'),1,null,'2018-04-01', '2020-03-31',0,null,now(),now(),1,1);
