select (select code from bhawanigarh.eg_city)||'-'||conn.shsc_number as id, ( select name from bhawanigarh.eg_city) as cityName, (select code from bhawanigarh.eg_city) as cityCode, (select grade from bhawanigarh.eg_city) as cityGrade, (select districtname from bhawanigarh.eg_city) as districtName, (select regionname from bhawanigarh.eg_city) as regionName, 'Sewerage Charges' as serviceType, conn.executiondate as connectionDate, conn.shsc_number as consumerCode, conn.oldconsumernumber as oldConsumerCode, conn.status as connectionStatus, usr.name as consumerName, usr.mobilenumber as mobileNumber, usr.emailid as emailId, usr.guardian as guardianName, (COALESCE(address.houseNoBldgApt||', ', '')||COALESCE(address.areaLocalitySector||', ','')||COALESCE(address.streetRoadLine||', ','')||COALESCE(address.landmark||', ','')||COALESCE(address.cityTownVillage||', ','')||COALESCE(address.postOffice||', ','')||COALESCE(address.subdistrict||', ','')||COALESCE(address.district||', ','')||COALESCE(address.state||', ','')||COALESCE(address.country||', ','')||COALESCE(address.pinCode,'')) as consumerAddress, replace(address.housenobldgapt,'/','') as doorNo,  zone.name as zone, block.name as block, locality.name as locality, conndetails.propertyidentifier as propertyUID, conndetails.wateridentifier as waterConsumerCode, usage.name as usage, conndetails.plotsize as plotSize, conndetails.noofclosets_residential as noOfSeatsResidential,  conndetails.noofclosets_nonresidential as noOfSeatsNonResidential,conndetails.billingtype as billingType, conn.legacy as legacy, appdetails.applicationnumber as applicationNumber, appdetails.applicationdate as applicationDate, to_timestamp(to_char(conn.createddate::timestamp without time zone, 'YYYY-MM-DD'),'YYYY-MM-DDTHH24:MI:SSZ') as createdDate, conndetails.isexempted as exempted, CASE (select value from bhawanigarh.eg_appconfig_values where key_id in (select id from bhawanigarh.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb from bhawanigarh.egswtax_connection conn, bhawanigarh.egswtax_connectiondetail conndetails, bhawanigarh.egswtax_applicationdetails appdetails, bhawanigarh.egswtax_application_type apptype, bhawanigarh.egswtax_usage_type usage, bhawanigarh.eg_boundary locality, bhawanigarh.eg_boundary zone, bhawanigarh.eg_boundary block, bhawanigarh.egswtax_connection_owner_info ownerinfo, bhawanigarh.eg_user usr, bhawanigarh.eg_address address where appdetails.connection=conn.id and appdetails.connectiondetail=conndetails.id and apptype.id=appdetails.applicationtype and usage.id=conndetails.usagetype and block.id=conn.block and locality.id=conn.locality and zone.id=conn.zone and ownerinfo.connection=conn.id and usr.id=ownerinfo.owner and address.id=conn.address
