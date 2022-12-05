select (select code from talwandibhai.eg_city)||'_'||ch.receiptNumber as id, DATE(ch.createddate) as createdDate, ch.receiptNumber as receiptNumber, billingservice.name as billingService, it.type as paymentMode, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ARREAR_AMOUNT') as arrearAmount, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_LATEPAYMENT_CHARGES','CURRENT_LATEPAYMENT_CHARGES')) as latePaymentCharges, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_PENALTY_CHARGES','CURRENT_PENALTY_CHARGES')) as interestAmount,(select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='CURRENT_AMOUNT') as currentAmount,(select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ADVANCE_AMOUNT') as advanceAmount,ch.totalamount as totalAmount, ch.source as channel,'' as paymentGateway,ch.referencenumber as billNumber, ch.consumercode as consumerCode, (select name from talwandibhai.eg_city) as cityName, (select districtname from talwandibhai.eg_city) as districtName, (select regionname from talwandibhai.eg_city) as regionName,status.description as status,DATE(ch.receiptdate) as receiptDate,(select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber= (select min(ordernumber) from talwandibhai.egcl_collectiondetails where collectionheader=ch.id)) as installmentFrom, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber=(select max(ordernumber) from talwandibhai.egcl_collectiondetails where cramount>0 and collectionheader=ch.id)) as installmentTo,ch.payeename as consumerName, (select grade from talwandibhai.eg_city) as cityGrade, (select code from talwandibhai.eg_city) as cityCode, eu.name as receiptCreator,(select code from talwandibhai.eg_city)||'_'||ch.receiptNumber as id, block.name as block, locality.name as locality , ch.consumertype as consumerType, CASE (select value from talwandibhai.eg_appconfig_values where key_id in (select id from talwandibhai.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb from talwandibhai.egcl_collectionheader ch, talwandibhai.egcl_servicedetails billingservice, talwandibhai.egcl_collectioninstrument ci, talwandibhai.egf_instrumentheader ih, talwandibhai.egf_instrumenttype it, talwandibhai.egw_status status, talwandibhai.eg_user eu,  talwandibhai.eg_boundary locality, talwandibhai.eg_boundary block, talwandibhai.egwtr_connection wtrcon where billingservice.id=ch.servicedetails and ci.collectionheader=ch.id and ci.instrumentheader=ih.id and ih.instrumenttype=it.id and ch.status=status.id and ch.collectiontype in ('C','F') and billingservice.code='WT' and wtrcon.consumercode=ch.consumercode and ch.createdby=eu.id and ch.status in (select id from talwandibhai.egw_status where moduletype='ReceiptHeader' and code not in ('PENDING','FAILED')) and locality.id=wtrcon.locality and block.id=wtrcon.block and (ch.createddate::date=now()::date or ch.lastmodifieddate::date=now()::date) UNION select (select code from talwandibhai.eg_city)||'_'||ch.receiptNumber as id, DATE(ch.createddate) as createdDate, ch.receiptNumber as receiptNumber,billingservice.name as billingService, it.type as paymentMode, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ARREAR_AMOUNT') as arrearAmount, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_LATEPAYMENT_CHARGES','CURRENT_LATEPAYMENT_CHARGES')) as latePaymentCharges, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_PENALTY_CHARGES','CURRENT_PENALTY_CHARGES')) as interestAmount, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='CURRENT_AMOUNT') as currentAmount,(select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ADVANCE_AMOUNT') as advanceAmount, ch.totalamount as totalAmount,ch.source as channel,paymentservice.name as paymentGateway,ch.referencenumber as billNumber, ch.consumercode as consumerCode, (select name from talwandibhai.eg_city) as cityName, (select districtname from talwandibhai.eg_city) as districtName, (select regionname from talwandibhai.eg_city) as regionName, status.description as status,DATE(ch.receiptdate) as receiptDate, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber =  (select min(ordernumber) from talwandibhai.egcl_collectiondetails where collectionheader=ch.id)) as installmentFrom, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber=(select max(ordernumber) from talwandibhai.egcl_collectiondetails where cramount> 0 and collectionheader=ch.id)) as installmentTo, ch.payeename as consumerName, (select grade from talwandibhai.eg_city) as cityGrade, (select code from talwandibhai.eg_city) as cityCode,eu.name as receiptCreator,(select code from talwandibhai.eg_city)||'_'||ch.receiptNumber as id, block.name as block, locality.name as locality , ch.consumertype as consumerType, CASE (select value from talwandibhai.eg_appconfig_values where key_id in (select id from talwandibhai.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb from talwandibhai.egcl_collectionheader ch,talwandibhai.egcl_servicedetails billingservice, talwandibhai.egcl_collectioninstrument ci, talwandibhai.egf_instrumentheader ih, talwandibhai.egf_instrumenttype it, talwandibhai.egcl_onlinepayments op, talwandibhai.egcl_servicedetails paymentservice, talwandibhai.egw_status status,  talwandibhai.eg_user eu,  talwandibhai.eg_boundary locality, talwandibhai.eg_boundary block, talwandibhai.egwtr_connection wtrcon  where billingservice.id=ch.servicedetails and ci.collectionheader=ch.id and ci.instrumentheader=ih.id and ih.instrumenttype=it.id and ch.id=op.collectionheader and op.servicedetails=paymentservice.id and ch.status=status.id and ch.collectiontype='O' and billingservice.code='WT' and wtrcon.consumercode=ch.consumercode and ch.createdby=eu.id and ch.status in (select id from talwandibhai.egw_status where moduletype='ReceiptHeader' and code not in ('PENDING','FAILED')) and locality.id=wtrcon.locality and block.id=wtrcon.block and (ch.createddate::date=now()::date or ch.lastmodifieddate::date=now()::date) UNION select (select code from talwandibhai.eg_city)||'_'||ch.receiptNumber as id, DATE(ch.createddate) as createdDate, ch.receiptNumber as receiptNumber, billingservice.name as billingService, it.type as paymentMode, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ARREAR_AMOUNT') as arrearAmount, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_LATEPAYMENT_CHARGES','CURRENT_LATEPAYMENT_CHARGES')) as latePaymentCharges, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_PENALTY_CHARGES','CURRENT_PENALTY_CHARGES')) as interestAmount,(select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='CURRENT_AMOUNT') as currentAmount,(select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ADVANCE_AMOUNT') as advanceAmount,ch.totalamount as totalAmount, ch.source as channel,'' as paymentGateway,ch.referencenumber as billNumber, ch.consumercode as consumerCode, (select name from talwandibhai.eg_city) as cityName, (select districtname from talwandibhai.eg_city) as districtName, (select regionname from talwandibhai.eg_city) as regionName,status.description as status,DATE(ch.receiptdate) as receiptDate,(select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber= (select min(ordernumber) from talwandibhai.egcl_collectiondetails where collectionheader=ch.id)) as installmentFrom, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber=(select max(ordernumber) from talwandibhai.egcl_collectiondetails where cramount>0 and collectionheader=ch.id)) as installmentTo,ch.payeename as consumerName, (select grade from talwandibhai.eg_city) as cityGrade, (select code from talwandibhai.eg_city) as cityCode, eu.name as receiptCreator,(select code from talwandibhai.eg_city)||'_'||ch.receiptNumber as id, block.name as block, locality.name as locality , ch.consumertype as consumerType, CASE (select value from talwandibhai.eg_appconfig_values where key_id in (select id from talwandibhai.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb from talwandibhai.egcl_collectionheader ch, talwandibhai.egcl_servicedetails billingservice, talwandibhai.egcl_collectioninstrument ci, talwandibhai.egf_instrumentheader ih, talwandibhai.egf_instrumenttype it, talwandibhai.egw_status status, talwandibhai.eg_user eu,  talwandibhai.eg_boundary locality, talwandibhai.eg_boundary block, talwandibhai.egswtax_connection swrcon where billingservice.id=ch.servicedetails and ci.collectionheader=ch.id and ci.instrumentheader=ih.id and ih.instrumenttype=it.id and ch.status=status.id and ch.collectiontype in ('C','F') and billingservice.code='STAX' and swrcon.shsc_number=ch.consumercode and ch.createdby=eu.id and ch.status in (select id from talwandibhai.egw_status where moduletype='ReceiptHeader' and code not in ('PENDING','FAILED')) and locality.id=swrcon.locality and block.id=swrcon.block and (ch.createddate::date=now()::date or ch.lastmodifieddate::date=now()::date) UNION select (select code from talwandibhai.eg_city)||'_'||ch.receiptNumber as id, DATE(ch.createddate) as createdDate, ch.receiptNumber as receiptNumber,billingservice.name as billingService, it.type as paymentMode, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ARREAR_AMOUNT') as arrearAmount, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_LATEPAYMENT_CHARGES','CURRENT_LATEPAYMENT_CHARGES')) as latePaymentCharges, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose in ('ARREAR_PENALTY_CHARGES','CURRENT_PENALTY_CHARGES')) as interestAmount, (select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='CURRENT_AMOUNT') as currentAmount,(select sum(cramount) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader  and colld.purpose ='ADVANCE_AMOUNT') as advanceAmount, ch.totalamount as totalAmount,ch.source as channel,paymentservice.name as paymentGateway,ch.referencenumber as billNumber, ch.consumercode as consumerCode, (select name from talwandibhai.eg_city) as cityName, (select districtname from talwandibhai.eg_city) as districtName, (select regionname from talwandibhai.eg_city) as regionName, status.description as status,DATE(ch.receiptdate) as receiptDate, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber =  (select min(ordernumber) from talwandibhai.egcl_collectiondetails where collectionheader=ch.id)) as installmentFrom, (select right(left(colld.description, strpos(colld.description, 'Q') + 1), 12) from talwandibhai.egcl_collectiondetails colld where ch.id=colld.collectionheader and colld.ordernumber=(select max(ordernumber) from talwandibhai.egcl_collectiondetails where cramount> 0 and collectionheader=ch.id)) as installmentTo, ch.payeename as consumerName, (select grade from talwandibhai.eg_city) as cityGrade, (select code from talwandibhai.eg_city) as cityCode,eu.name as receiptCreator,(select code from talwandibhai.eg_city)||'_'||ch.receiptNumber as id, block.name as block, locality.name as locality , ch.consumertype as consumerType, CASE (select value from talwandibhai.eg_appconfig_values where key_id in (select id from talwandibhai.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb from talwandibhai.egcl_collectionheader ch,talwandibhai.egcl_servicedetails billingservice, talwandibhai.egcl_collectioninstrument ci, talwandibhai.egf_instrumentheader ih, talwandibhai.egf_instrumenttype it, talwandibhai.egcl_onlinepayments op, talwandibhai.egcl_servicedetails paymentservice, talwandibhai.egw_status status,  talwandibhai.eg_user eu,  talwandibhai.eg_boundary locality, talwandibhai.eg_boundary block, talwandibhai.egswtax_connection swrcon  where billingservice.id=ch.servicedetails and ci.collectionheader=ch.id and ci.instrumentheader=ih.id and ih.instrumenttype=it.id and ch.id=op.collectionheader and op.servicedetails=paymentservice.id and ch.status=status.id and ch.collectiontype='O' and billingservice.code='STAX' and swrcon.shsc_number=ch.consumercode and ch.createdby=eu.id and ch.status in (select id from talwandibhai.egw_status where moduletype='ReceiptHeader' and code not in ('PENDING','FAILED')) and locality.id=swrcon.locality and block.id=swrcon.block and (ch.createddate::date=now()::date or ch.lastmodifieddate::date=now()::date);