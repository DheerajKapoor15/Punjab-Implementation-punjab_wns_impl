select (select code from urmartanda.eg_city)||'_'||ch.receiptNumber as id, DATE(ch.createddate) as createdDate, ch.receiptNumber as receiptNumber, billingservice.name as billingService, it.type as paymentMode, (select sum(cramount) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.description::text ~~ 'Water Application Fee%'::text) as applicationfee, (select sum(cramount) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.description::text ~~ 'Water Security Deposit%'::text) as securitydeposit, (select sum(cramount) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.description::text ~~ 'Water Road Cutting Fee%'::text) as roadcuttingfee,(select sum(cramount) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.description::text ~~ 'Water Connection Fee%'::text) as connectionfee,(select sum(cramount) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.description::text ~~ 'Water Other Fee%'::text) as otherfee,ch.totalamount as totalAmount, ch.source as channel,'' as paymentGateway,ch.referencenumber as billNumber, ch.consumercode as applicationNumber, (select name from urmartanda.eg_city) as cityName, (select districtname from urmartanda.eg_city) as districtName, (select regionname from urmartanda.eg_city) as regionName,status.description as status,DATE(ch.receiptdate) as receiptDate,(select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber= (select min(ordernumber) from urmartanda.egcl_collectiondetails where collectionheader=ch.id)) as installmentFrom, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber=(select max(ordernumber) from urmartanda.egcl_collectiondetails where cramount>0 and collectionheader=ch.id)) as installmentTo,ch.payeename as consumerName, (select grade from urmartanda.eg_city) as cityGrade, (select code from urmartanda.eg_city) as cityCode, eu.name as receiptCreator, block.name as block, locality.name as locality , ch.consumertype as consumerType, CASE (select value from urmartanda.eg_appconfig_values where key_id in (select id from urmartanda.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb from urmartanda.egcl_collectionheader ch, urmartanda.egcl_servicedetails billingservice, urmartanda.egcl_collectioninstrument ci, urmartanda.egf_instrumentheader ih, urmartanda.egf_instrumenttype it, urmartanda.egw_status status, urmartanda.eg_user eu,  urmartanda.eg_boundary locality, urmartanda.eg_boundary block, urmartanda.egwtr_connection wtrcon,  urmartanda.egwtr_connectiondetails conndetails where billingservice.id=ch.servicedetails and ci.collectionheader=ch.id and ci.instrumentheader=ih.id and ih.instrumenttype=it.id and ch.status=status.id and billingservice.code='WT' and conndetails.applicationnumber=ch.consumercode and ch.createdby=eu.id and ch.status in (select id from urmartanda.egw_status where moduletype='ReceiptHeader' and code not in ('PENDING','FAILED')) and locality.id=wtrcon.locality and block.id=wtrcon.block and wtrcon.id=conndetails.connection and conndetails.legacy=false and ch.referencedesc like 'Water Application%' UNION select (select code from urmartanda.eg_city)||'_'||ch.receiptNumber as id, DATE(ch.createddate) as createdDate, ch.receiptNumber as receiptNumber, billingservice.name as billingService, it.type as paymentMode, (select sum(cramount) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.description::text ~~ 'Sewerage Application Fee%'::text) as applicationfee, (select sum(cramount) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.description::text ~~ 'Sewerage Security Deposit%'::text) as securitydeposit, (select sum(cramount) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.description::text ~~ 'Sewerage Road Cutting Fee%'::text) as roadcuttingfee,(select sum(cramount) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.description::text ~~ 'Sewerage Connection Fee%'::text) as connectionfee,(select sum(cramount) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.description::text ~~ 'Sewerage Other Fee%'::text) as otherfee,ch.totalamount as totalAmount, ch.source as channel,'' as paymentGateway,ch.referencenumber as billNumber, ch.consumercode as applicationNumber, (select name from urmartanda.eg_city) as cityName, (select districtname from urmartanda.eg_city) as districtName, (select regionname from urmartanda.eg_city) as regionName,status.description as status,DATE(ch.receiptdate) as receiptDate,(select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber= (select min(ordernumber) from urmartanda.egcl_collectiondetails where collectionheader=ch.id)) as installmentFrom, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from urmartanda.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber=(select max(ordernumber) from urmartanda.egcl_collectiondetails where cramount>0 and collectionheader=ch.id)) as installmentTo,ch.payeename as consumerName, (select grade from urmartanda.eg_city) as cityGrade, (select code from urmartanda.eg_city) as cityCode, eu.name as receiptCreator,block.name as block, locality.name as locality , ch.consumertype as consumerType, CASE (select value from urmartanda.eg_appconfig_values where key_id in (select id from urmartanda.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb from urmartanda.egcl_collectionheader ch, urmartanda.egcl_servicedetails billingservice, urmartanda.egcl_collectioninstrument ci, urmartanda.egf_instrumentheader ih, urmartanda.egf_instrumenttype it, urmartanda.egw_status status, urmartanda.eg_user eu,  urmartanda.eg_boundary locality, urmartanda.eg_boundary block, urmartanda.egswtax_connection swrcon, urmartanda.egswtax_applicationdetails appdetails where billingservice.id=ch.servicedetails and ci.collectionheader=ch.id and ci.instrumentheader=ih.id and ih.instrumenttype=it.id and ch.status=status.id and billingservice.code='STAX' and appdetails.applicationnumber=ch.consumercode and ch.createdby=eu.id and ch.status in (select id from urmartanda.egw_status where moduletype='ReceiptHeader' and code not in ('PENDING','FAILED')) and locality.id=swrcon.locality and block.id=swrcon.block and appdetails.connection=swrcon.id and swrcon.legacy=false and ch.referencedesc like 'Sewerage Application%'