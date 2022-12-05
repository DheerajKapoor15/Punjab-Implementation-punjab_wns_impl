#!/bin/bash
LOGSTASH='/home/ubuntu/logstash-6.5.1/bin/logstash'
CONF_FILE='/home/ubuntu/esdatapush/applications/collections/application_collections_logstash.conf'
PATH_DATA='/home/ubuntu/esdatapush/applications/collections/'

echo "[ $(date) ] Running Application collection data for all cities...!"
$LOGSTASH -f $CONF_FILE --path.data $PATH_DATA
