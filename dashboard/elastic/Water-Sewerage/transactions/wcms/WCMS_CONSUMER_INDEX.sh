#!/bin/bash
export PATH=/home/ubuntu/bin:/home/ubuntu/.local/bin:/usr/share/jdk1.8.0_131/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

export JDBC_IMPORTER_HOME=/home/ubuntu/feeder/elasticsearch-jdbc-2.3.4.1
export ES_HOME=/home/ubuntu/feeder/elasticsearch-jdbc-2.3.4.1
bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib

echo '
{
"type": "jdbc",
"jdbc": {
"url": "jdbc:postgresql://punjab-prod-rds.c7gelbottzkp.ap-south-1.rds.amazonaws.com:5432/punjab_prod_app",
"user": "punjab_prod_user",
"password": <input db user password here>,
"strategy": "standard",
"timezone": "localtime",
"sql": "select (select code from '"$1"'.eg_city)||\u0027-\u0027||conn.consumercode as \"_id\", ( select name from '"$1"'.eg_city) as \"cityName\", (select code from '"$1"'.eg_city) as \"cityCode\", (select grade from '"$1"'.eg_city) as \"cityGrade\", (select districtname from '"$1"'.eg_city) as \"districtName\", (select regionname from '"$1"'.eg_city) as \"regionName\", conndetails.executiondate as \"connectionDate\", conn.consumercode as \"consumerCode\", conn.oldconsumernumber as \"oldConsumerCode\", conndetails.connectionstatus as \"connectionStatus\", usr.name as \"consumerName\", usr.mobilenumber as \"mobileNumber\", usr.emailid as \"emailId\", usr.guardian as \"guardianName\", (COALESCE(address.houseNoBldgApt||\u0027, \u0027, \u0027\u0027)||COALESCE(address.areaLocalitySector||\u0027, \u0027,\u0027\u0027)||COALESCE(address.streetRoadLine||\u0027, \u0027,\u0027\u0027)||COALESCE(address.landmark||\u0027, \u0027,\u0027\u0027)||COALESCE(address.cityTownVillage||\u0027, \u0027,\u0027\u0027)||COALESCE(address.postOffice||\u0027, \u0027,\u0027\u0027)||COALESCE(address.subdistrict||\u0027, \u0027,\u0027\u0027)||COALESCE(address.district||\u0027, \u0027,\u0027\u0027)||COALESCE(address.state||\u0027, \u0027,\u0027\u0027)||COALESCE(address.country||\u0027, \u0027,\u0027\u0027)||COALESCE(address.pinCode,\u0027\u0027)) as \"consumerAddress\", replace(address.housenobldgapt,\u0027/\u0027,\u0027\\u0027) as \"doorNo\",  zone.name as \"zone\", block.name as \"block\", locality.name as \"locality\", conn.propertyidentifier as \"propertyUID\", conn.sewerageidentifier as \"sewerageConsumerCode\",  contype.name as \"connectionType\", usage.name as \"usage\",   proptype.name as \"propertyType\", wtrctgy.name as \"category\",pipe.code as \"pipeSize\", wtrsrc.watersourcetype as \"waterSource\", conndetails.plotsize as \"plotSize\", conndetails.nooftaps as \"noOfTaps\", conndetails.billingtype as \"billingType\", conndetails.legacy as \"legacy\", conndetails.applicationnumber as \"applicationNumber\", conndetails.applicationdate as \"applicationDate\", to_timestamp(to_char(conn.createddate::timestamp without time zone, \u0027YYYY-MM-DD\u0027),\u0027YYYY-MM-DD\"T\"HH24:MI:SS\"Z\"\u0027) as \"createdDate\" from '"$1"'.egwtr_connection conn, '"$1"'.egwtr_connectiondetails conndetails, '"$1"'.egwtr_application_type apptype, '"$1"'.egwtr_usage_type usage, '"$1"'.eg_boundary locality, '"$1"'.eg_boundary zone, '"$1"'.eg_boundary block, '"$1"'.egwtr_water_source wtrsrc, '"$1"'.egwtr_property_type proptype, '"$1"'.egwtr_category wtrctgy, '"$1"'.egwtr_pipesize pipe, '"$1"'.egwtr_connection_type contype, '"$1"'.egwtr_connection_owner_info ownerinfo, '"$1"'.eg_user usr, '"$1"'.eg_address address where conn.id=conndetails.connection and apptype.id=conndetails.applicationtype and usage.id=conndetails.usagetype and block.id=conn.block and locality.id=conn.locality and zone.id=conn.zone and conndetails.watersource=wtrsrc.id and conndetails.propertytype=proptype.id and conndetails.category=wtrctgy.id and conndetails.pipesize=pipe.id and ownerinfo.connection=conn.id and usr.id=ownerinfo.owner and address.id=conn.address and contype.id=conndetails.connectiontype",
"index": "waterchargesconsumers",
"type": "waterchargesconsumers",
"elasticsearch" : {
     "cluster" : "punjab-prod-es-cluster",
     "host" : "localhost",
     "port" : 9300
}
    }   
}' | java \
-cp "${lib}/*" \
-Dlog4j.configurationFile=${bin}/log4j2.xml \
org.xbib.tools.Runner \
org.xbib.tools.JDBCImporter

