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
"sql":  "select (select code from '"$1"'.eg_city) as _id, (select regionname from '"$1"'.eg_city) as regionname,(select districtname from '"$1"'.eg_city) as districtname,(select name from '"$1"'.eg_city) as ulbname,(select code from '"$1"'.eg_city) as ulbcode,(select count(*) from '"$1"'.egwtr_connectiondetails where connectionstatus=\u0027ACTIVE\u0027 and createddate::date=now()::date-2 and legacy=\u0027true\u0027) as daybeforeyesterday,(select count(*) from '"$1"'.egwtr_connectiondetails where connectionstatus=\u0027ACTIVE\u0027 and createddate::date=now()::date-1 and legacy=\u0027true\u0027) as yesterday,(select count(*) from '"$1"'.egwtr_connectiondetails where connectionstatus=\u0027ACTIVE\u0027 and createddate::date=now()::date and legacy=\u0027true\u0027) as today,(select mst.total_wc_connections from generic.water_sewerage_statistics mst where mst.ulbcode =(select code from '"$1"'.eg_city)) as totalconnections,(select count(*) from '"$1"'.egwtr_connectiondetails where connectionstatus=\u0027ACTIVE\u0027 and legacy=\u0027true\u0027) as dataentryconnections, (select mst.total_wc_connections::bigint from generic.water_sewerage_statistics mst where mst.ulbcode=(select code from '"$1"'.eg_city))-(select count(*) as total from '"$1"'.egwtr_connectiondetails where connectionstatus=\u0027ACTIVE\u0027 and legacy=\u0027true\u0027) as difference",
"index": "waterchargesrollout",
"type": "waterchargesrollout",
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

