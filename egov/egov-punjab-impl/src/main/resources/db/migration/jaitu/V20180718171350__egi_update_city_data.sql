
update eg_city set domainurl= 'jaitu-uat.egovernments.org', name= 'Jaitu', localname= 'Jaitu', preferences= (select id from eg_citypreferences);

update eg_citypreferences set municipalityname= 'Jaitu Municipal Council', municipalityaddress= 'Jaitu Municipal Council';


