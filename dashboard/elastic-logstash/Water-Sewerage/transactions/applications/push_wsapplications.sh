#!/bin/bash
LOGSTASH='/home/ubuntu/logstash-6.5.1/bin/logstash'
CONF_FILE='/home/ubuntu/esdatapush/applications/wsapplications_logstash.conf'
PATH_DATA='/home/ubuntu/esdatapush/applications/'

echo "[ $(date) ] Running for application data push for all the cities...!"
$LOGSTASH -f $CONF_FILE --path.data $PATH_DATA
