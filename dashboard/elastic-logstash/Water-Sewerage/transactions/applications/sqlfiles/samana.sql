select (select code from samana.eg_city)||'-'||conndetails.id||'-WC' as id, (select name from samana.eg_city) as cityName, (select code from samana.eg_city) as cityCode, (select grade from samana.eg_city) as cityGrade, (select districtname from samana.eg_city) as districtName, (select regionname from samana.eg_city) as regionName, 'Water Charges' as serviceType, apptype.name as applicationType, conndetails.applicationnumber as applicationNumber, conndetails.applicationdate as applicationDate, usr.name as applicantName, conndetails.disposalDate as disposalDate, status.description as applicationStatus, usr.mobilenumber as mobileNumber, usr.emailid as emailId, usr.guardian as guardianName, (COALESCE(address.houseNoBldgApt||', ', '')||COALESCE(address.areaLocalitySector||', ','')||COALESCE(address.streetRoadLine||', ','')||COALESCE(address.landmark||', ','')||COALESCE(address.cityTownVillage||', ','')||COALESCE(address.postOffice||', ','')||COALESCE(address.subdistrict||', ','')||COALESCE(address.district||', ','')||COALESCE(address.state||', ','')||COALESCE(address.country||', ','')||COALESCE(address.pinCode,'')) as applicantAddress, replace(address.housenobldgapt,'/','\') as doorNo, zone.name as zone, block.name as block, locality.name as locality, CASE WHEN conndetails.source is not null THEN conndetails.source ELSE 'COUNTER' END as channel, conn.consumercode as consumerCode, conndetails.connectionstatus as connectionStatus, (select contype.name from samana.egwtr_connection_type contype where contype.id=conndetails.connectiontype) as connectionType, usage.name as usage, proptype.name as propertyType, wtrctgy.name as category, to_timestamp(to_char(conn.createddate::timestamp without time zone, 'YYYY-MM-DD'),'YYYY-MM-DDTHH24:MI:SSZ') as createdDate, CASE (select value from samana.eg_appconfig_values where key_id in (select id from samana.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb, '' as sla, '' as slaGap, '' as elapsedDays, CASE WHEN (select count(*) from samana.eg_wf_state_history statehist where statehist.state_id=conndetails.state_id and lastmodifiedby=(select id from samana.eg_user where username='system'))>=1 THEN true ELSE false END as autoVerified, (select lastmodifieddate from samana.eg_wf_state_history statehist where statehist.state_id=conndetails.state_id and lastmodifiedby=(select id from samana.eg_user where username='system')) as autoVerifiedDate from samana.egwtr_connection conn, samana.egwtr_connectiondetails conndetails, samana.egwtr_application_type apptype, samana.egwtr_usage_type usage, samana.eg_boundary locality, samana.eg_boundary zone, samana.eg_boundary block, samana.egwtr_property_type proptype, samana.egwtr_category wtrctgy, samana.egwtr_connection_owner_info ownerinfo, samana.eg_user usr, samana.eg_address address, samana.egw_status status where conn.id=conndetails.connection and apptype.id=conndetails.applicationtype and usage.id=conndetails.usagetype and block.id=conn.block and locality.id=conn.locality and zone.id=conn.zone and conndetails.propertytype=proptype.id and conndetails.category=wtrctgy.id and ownerinfo.connection=conn.id and usr.id=ownerinfo.owner and address.id=conn.address and status.id=conndetails.statusid and conndetails.legacy=false UNION select (select code from samana.eg_city)||'-'||conndetails.id||'-SC' as id, (select name from samana.eg_city) as cityName, (select code from samana.eg_city) as cityCode, (select grade from samana.eg_city) as cityGrade, (select districtname from samana.eg_city) as districtName, (select regionname from samana.eg_city) as regionName, 'Sewerage Charges' as serviceType, apptype.name as applicationType, appdetails.applicationnumber as applicationNumber, appdetails.applicationdate as applicationDate, usr.name as applicantName, appdetails.disposalDate as disposalDate,status.description as applicationStatus,  usr.mobilenumber as mobileNumber, usr.emailid as emailId, usr.guardian as guardianName, (COALESCE(address.houseNoBldgApt||', ', '')||COALESCE(address.areaLocalitySector||', ','')||COALESCE(address.streetRoadLine||', ','')||COALESCE(address.landmark||', ','')||COALESCE(address.cityTownVillage||', ','')||COALESCE(address.postOffice||', ','')||COALESCE(address.subdistrict||', ','')||COALESCE(address.district||', ','')||COALESCE(address.state||', ','')||COALESCE(address.country||', ','')||COALESCE(address.pinCode,'')) as applicantAddress, replace(address.housenobldgapt,'/','\') as doorNo, zone.name as zone, block.name as block, locality.name as locality, CASE WHEN appdetails.source is not null THEN appdetails.source ELSE 'COUNTER' END as channel, conn.shsc_number as consumerCode,  conn.status as connectionStatus, '' as connectionType, usage.name as usage, '' as propertyType, '' as category, to_timestamp(to_char(conn.createddate::timestamp without time zone, 'YYYY-MM-DD'),'YYYY-MM-DDTHH24:MI:SSZ') as createdDate, CASE (select value from samana.eg_appconfig_values where key_id in (select id from samana.eg_appconfig where key_name ='IS_PWSSB_ULB')) WHEN 'YES' THEN true ELSE false END as pwssb, '' as sla, '' as slaGap, '' as elapsedDays, CASE WHEN (select count(*) from samana.eg_wf_state_history statehist where statehist.state_id=appdetails.state_id and lastmodifiedby=(select id from samana.eg_user where username='system'))>=1 THEN true ELSE false END as autoVerified, (select lastmodifieddate from samana.eg_wf_state_history statehist where statehist.state_id=appdetails.state_id and lastmodifiedby=(select id from samana.eg_user where username='system')) as autoVerifiedDate from samana.egswtax_connection conn, samana.egswtax_connectiondetail conndetails, samana.egswtax_applicationdetails appdetails, samana.egswtax_application_type apptype, samana.egswtax_usage_type usage, samana.eg_boundary locality, samana.eg_boundary zone, samana.eg_boundary block, samana.egswtax_connection_owner_info ownerinfo, samana.eg_user usr, samana.eg_address address, samana.egw_status status where appdetails.connection=conn.id and appdetails.connectiondetail=conndetails.id and apptype.id=appdetails.applicationtype and usage.id=conndetails.usagetype and block.id=conn.block and locality.id=conn.locality and zone.id=conn.zone and ownerinfo.connection=conn.id and usr.id=ownerinfo.owner and address.id=conn.address and status.id=appdetails.status and conn.legacy=false