select (select code from barnala.eg_city)||'_'||ch.receiptNumber as id, DATE(ch.createddate) as createdDate, ch.receiptNumber as receiptNumber, billingservice.name as billingService, it.type as paymentMode, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ARREAR_AMOUNT') as arrearAmount, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_LATEPAYMENT_CHARGES','CURRENT_LATEPAYMENT_CHARGES')) as latePaymentCharges, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_PENALTY_CHARGES','CURRENT_PENALTY_CHARGES')) as interestAmount,(select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='CURRENT_AMOUNT') as currentAmount,(select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ADVANCE_AMOUNT') as advanceAmount,ch.totalamount as totalAmount, ch.source as channel,'' as paymentGateway,ch.referencenumber as billNumber, ch.consumercode as consumerCode, (select name from barnala.eg_city) as cityName, (select districtname from barnala.eg_city) as districtName, (select regionname from barnala.eg_city) as regionName,status.description as status,DATE(ch.receiptdate) as receiptDate,(select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber= (select min(ordernumber) from barnala.egcl_collectiondetails where collectionheader=ch.id)) as installmentFrom, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber=(select max(ordernumber) from barnala.egcl_collectiondetails where cramount>0 and collectionheader=ch.id)) as installmentTo,ch.payeename as consumerName, (select grade from barnala.eg_city) as cityGrade, (select code from barnala.eg_city) as cityCode, eu.name as receiptCreator,(select code from barnala.eg_city)||'_'||ch.receiptNumber as id, block.name as block, locality.name as locality , ch.consumertype as consumerType, CASE (select value from barnala.eg_appconfig_values where key_id in (select id from barnala.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb from barnala.egcl_collectionheader ch, barnala.egcl_servicedetails billingservice, barnala.egcl_collectioninstrument ci, barnala.egf_instrumentheader ih, barnala.egf_instrumenttype it, barnala.egw_status status, barnala.eg_user eu,  barnala.eg_boundary locality, barnala.eg_boundary block, barnala.egwtr_connection wtrcon where billingservice.id=ch.servicedetails and ci.collectionheader=ch.id and ci.instrumentheader=ih.id and ih.instrumenttype=it.id and ch.status=status.id and ch.collectiontype in ('C','F') and billingservice.code='WT' and wtrcon.consumercode=ch.consumercode and ch.createdby=eu.id and ch.status in (select id from barnala.egw_status where moduletype='ReceiptHeader' and code not in ('PENDING','FAILED')) and locality.id=wtrcon.locality and block.id=wtrcon.block and (ch.createddate::date=now()::date or ch.lastmodifieddate::date=now()::date) UNION select (select code from barnala.eg_city)||'_'||ch.receiptNumber as id, DATE(ch.createddate) as createdDate, ch.receiptNumber as receiptNumber,billingservice.name as billingService, it.type as paymentMode, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ARREAR_AMOUNT') as arrearAmount, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_LATEPAYMENT_CHARGES','CURRENT_LATEPAYMENT_CHARGES')) as latePaymentCharges, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_PENALTY_CHARGES','CURRENT_PENALTY_CHARGES')) as interestAmount, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='CURRENT_AMOUNT') as currentAmount,(select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ADVANCE_AMOUNT') as advanceAmount, ch.totalamount as totalAmount,ch.source as channel,paymentservice.name as paymentGateway,ch.referencenumber as billNumber, ch.consumercode as consumerCode, (select name from barnala.eg_city) as cityName, (select districtname from barnala.eg_city) as districtName, (select regionname from barnala.eg_city) as regionName, status.description as status,DATE(ch.receiptdate) as receiptDate, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber =  (select min(ordernumber) from barnala.egcl_collectiondetails where collectionheader=ch.id)) as installmentFrom, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber=(select max(ordernumber) from barnala.egcl_collectiondetails where cramount> 0 and collectionheader=ch.id)) as installmentTo, ch.payeename as consumerName, (select grade from barnala.eg_city) as cityGrade, (select code from barnala.eg_city) as cityCode,eu.name as receiptCreator,(select code from barnala.eg_city)||'_'||ch.receiptNumber as id, block.name as block, locality.name as locality , ch.consumertype as consumerType, CASE (select value from barnala.eg_appconfig_values where key_id in (select id from barnala.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb from barnala.egcl_collectionheader ch,barnala.egcl_servicedetails billingservice, barnala.egcl_collectioninstrument ci, barnala.egf_instrumentheader ih, barnala.egf_instrumenttype it, barnala.egcl_onlinepayments op, barnala.egcl_servicedetails paymentservice, barnala.egw_status status,  barnala.eg_user eu,  barnala.eg_boundary locality, barnala.eg_boundary block, barnala.egwtr_connection wtrcon  where billingservice.id=ch.servicedetails and ci.collectionheader=ch.id and ci.instrumentheader=ih.id and ih.instrumenttype=it.id and ch.id=op.collectionheader and op.servicedetails=paymentservice.id and ch.status=status.id and ch.collectiontype='O' and billingservice.code='WT' and wtrcon.consumercode=ch.consumercode and ch.createdby=eu.id and ch.status in (select id from barnala.egw_status where moduletype='ReceiptHeader' and code not in ('PENDING','FAILED')) and locality.id=wtrcon.locality and block.id=wtrcon.block and (ch.createddate::date=now()::date or ch.lastmodifieddate::date=now()::date) UNION select (select code from barnala.eg_city)||'_'||ch.receiptNumber as id, DATE(ch.createddate) as createdDate, ch.receiptNumber as receiptNumber, billingservice.name as billingService, it.type as paymentMode, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ARREAR_AMOUNT') as arrearAmount, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_LATEPAYMENT_CHARGES','CURRENT_LATEPAYMENT_CHARGES')) as latePaymentCharges, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_PENALTY_CHARGES','CURRENT_PENALTY_CHARGES')) as interestAmount,(select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='CURRENT_AMOUNT') as currentAmount,(select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ADVANCE_AMOUNT') as advanceAmount,ch.totalamount as totalAmount, ch.source as channel,'' as paymentGateway,ch.referencenumber as billNumber, ch.consumercode as consumerCode, (select name from barnala.eg_city) as cityName, (select districtname from barnala.eg_city) as districtName, (select regionname from barnala.eg_city) as regionName,status.description as status,DATE(ch.receiptdate) as receiptDate,(select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber= (select min(ordernumber) from barnala.egcl_collectiondetails where collectionheader=ch.id)) as installmentFrom, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber=(select max(ordernumber) from barnala.egcl_collectiondetails where cramount>0 and collectionheader=ch.id)) as installmentTo,ch.payeename as consumerName, (select grade from barnala.eg_city) as cityGrade, (select code from barnala.eg_city) as cityCode, eu.name as receiptCreator,(select code from barnala.eg_city)||'_'||ch.receiptNumber as id, block.name as block, locality.name as locality , ch.consumertype as consumerType, CASE (select value from barnala.eg_appconfig_values where key_id in (select id from barnala.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb from barnala.egcl_collectionheader ch, barnala.egcl_servicedetails billingservice, barnala.egcl_collectioninstrument ci, barnala.egf_instrumentheader ih, barnala.egf_instrumenttype it, barnala.egw_status status, barnala.eg_user eu,  barnala.eg_boundary locality, barnala.eg_boundary block, barnala.egswtax_connection swrcon where billingservice.id=ch.servicedetails and ci.collectionheader=ch.id and ci.instrumentheader=ih.id and ih.instrumenttype=it.id and ch.status=status.id and ch.collectiontype in ('C','F') and billingservice.code='STAX' and swrcon.shsc_number=ch.consumercode and ch.createdby=eu.id and ch.status in (select id from barnala.egw_status where moduletype='ReceiptHeader' and code not in ('PENDING','FAILED')) and locality.id=swrcon.locality and block.id=swrcon.block and (ch.createddate::date=now()::date or ch.lastmodifieddate::date=now()::date) UNION select (select code from barnala.eg_city)||'_'||ch.receiptNumber as id, DATE(ch.createddate) as createdDate, ch.receiptNumber as receiptNumber,billingservice.name as billingService, it.type as paymentMode, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ARREAR_AMOUNT') as arrearAmount, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_LATEPAYMENT_CHARGES','CURRENT_LATEPAYMENT_CHARGES')) as latePaymentCharges, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_PENALTY_CHARGES','CURRENT_PENALTY_CHARGES')) as interestAmount, (select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='CURRENT_AMOUNT') as currentAmount,(select sum(cramount) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ADVANCE_AMOUNT') as advanceAmount, ch.totalamount as totalAmount,ch.source as channel,paymentservice.name as paymentGateway,ch.referencenumber as billNumber, ch.consumercode as consumerCode, (select name from barnala.eg_city) as cityName, (select districtname from barnala.eg_city) as districtName, (select regionname from barnala.eg_city) as regionName, status.description as status,DATE(ch.receiptdate) as receiptDate, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber =  (select min(ordernumber) from barnala.egcl_collectiondetails where collectionheader=ch.id)) as installmentFrom, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from barnala.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber=(select max(ordernumber) from barnala.egcl_collectiondetails where cramount> 0 and collectionheader=ch.id)) as installmentTo, ch.payeename as consumerName, (select grade from barnala.eg_city) as cityGrade, (select code from barnala.eg_city) as cityCode,eu.name as receiptCreator,(select code from barnala.eg_city)||'_'||ch.receiptNumber as id, block.name as block, locality.name as locality , ch.consumertype as consumerType, CASE (select value from barnala.eg_appconfig_values where key_id in (select id from barnala.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb from barnala.egcl_collectionheader ch,barnala.egcl_servicedetails billingservice, barnala.egcl_collectioninstrument ci, barnala.egf_instrumentheader ih, barnala.egf_instrumenttype it, barnala.egcl_onlinepayments op, barnala.egcl_servicedetails paymentservice, barnala.egw_status status,  barnala.eg_user eu,  barnala.eg_boundary locality, barnala.eg_boundary block, barnala.egswtax_connection swrcon  where billingservice.id=ch.servicedetails and ci.collectionheader=ch.id and ci.instrumentheader=ih.id and ih.instrumenttype=it.id and ch.id=op.collectionheader and op.servicedetails=paymentservice.id and ch.status=status.id and ch.collectiontype='O' and billingservice.code='STAX' and swrcon.shsc_number=ch.consumercode and ch.createdby=eu.id and ch.status in (select id from barnala.egw_status where moduletype='ReceiptHeader' and code not in ('PENDING','FAILED')) and locality.id=swrcon.locality and block.id=swrcon.block and (ch.createddate::date=now()::date or ch.lastmodifieddate::date=now()::date);
