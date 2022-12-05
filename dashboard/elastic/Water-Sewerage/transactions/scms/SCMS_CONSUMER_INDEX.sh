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
"sql": "select (select code from '"$1"'.eg_city)||\u0027-\u0027||conn.shsc_number as \"_id\", ( select name from '"$1"'.eg_city) as \"cityName\", (select code from '"$1"'.eg_city) as \"cityCode\", (select grade from '"$1"'.eg_city) as \"cityGrade\", (select districtname from '"$1"'.eg_city) as \"districtName\", (select regionname from '"$1"'.eg_city) as \"regionName\", conn.executiondate as \"connectionDate\", conn.shsc_number as \"consumerCode\", conn.oldconsumernumber as \"oldConsumerCode\", conn.status as \"connectionStatus\", usr.name as \"consumerName\", usr.mobilenumber as \"mobileNumber\", usr.emailid as \"emailId\", usr.guardian as \"guardianName\", (COALESCE(address.houseNoBldgApt||\u0027, \u0027, \u0027\u0027)||COALESCE(address.areaLocalitySector||\u0027, \u0027,\u0027\u0027)||COALESCE(address.streetRoadLine||\u0027, \u0027,\u0027\u0027)||COALESCE(address.landmark||\u0027, \u0027,\u0027\u0027)||COALESCE(address.cityTownVillage||\u0027, \u0027,\u0027\u0027)||COALESCE(address.postOffice||\u0027, \u0027,\u0027\u0027)||COALESCE(address.subdistrict||\u0027, \u0027,\u0027\u0027)||COALESCE(address.district||\u0027, \u0027,\u0027\u0027)||COALESCE(address.state||\u0027, \u0027,\u0027\u0027)||COALESCE(address.country||\u0027, \u0027,\u0027\u0027)||COALESCE(address.pinCode,\u0027\u0027)) as \"consumerAddress\", replace(address.housenobldgapt,\u0027/\u0027,\u0027\u0027) as \"doorNo\",  zone.name as \"zone\", block.name as \"block\", locality.name as \"locality\", conndetails.propertyidentifier as \"propertyUID\", conndetails.wateridentifier as \"waterConsumerCode\", usage.name as \"usage\", conndetails.plotsize as \"plotSize\", conndetails.noofclosets_residential as \"noOfSeatsResidential\",  conndetails.noofclosets_nonresidential as \"noOfSeatsNonResidential\",conndetails.billingtype as \"billingType\", conn.legacy as \"legacy\", appdetails.applicationnumber as \"applicationNumber\", appdetails.applicationdate as \"applicationDate\", to_timestamp(to_char(conn.createddate::timestamp without time zone, \u0027YYYY-MM-DD\u0027),\u0027YYYY-MM-DD\"T\"HH24:MI:SS\"Z\"\u0027) as \"createdDate\" from '"$1"'.egswtax_connection conn, '"$1"'.egswtax_connectiondetail conndetails, '"$1"'.egswtax_applicationdetails appdetails, '"$1"'.egswtax_application_type apptype, '"$1"'.egswtax_usage_type usage, '"$1"'.eg_boundary locality, '"$1"'.eg_boundary zone, '"$1"'.eg_boundary block, '"$1"'.egswtax_connection_owner_info ownerinfo, '"$1"'.eg_user usr, '"$1"'.eg_address address where appdetails.connection=conn.id and appdetails.connectiondetail=conndetails.id and apptype.id=appdetails.applicationtype and usage.id=conndetails.usagetype and block.id=conn.block and locality.id=conn.locality and zone.id=conn.zone and ownerinfo.connection=conn.id and usr.id=ownerinfo.owner and address.id=conn.address",
"index": "seweragechargesconsumers",
"type": "seweragechargesconsumers",
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

