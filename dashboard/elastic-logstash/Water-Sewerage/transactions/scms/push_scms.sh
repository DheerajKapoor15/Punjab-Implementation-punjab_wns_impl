#!/bin/bash
LOGSTASH='/home/ubuntu/logstash-6.5.1/bin/logstash'
CONF_FILE='/home/ubuntu/esdatapush/scms/scms_logstash.conf'
PATH_DATA='/home/ubuntu/esdatapush/scms/'

#legacypath="adampur ajnala alawalpur amargarh amloh badhnikalan balachaur bareta banga banur bhikhi boha bassipathana batala budhlada begowal bhadaur bhadson gidderbaha bhawanigarh bhogpur bhulath malout mansa cheema dhariwal dhilwan dhuri dinanagar dirba doraha faridkot fatehgarhchurian fazilka ferozepur garhdiwala garhshankar ghagga ghanaur handiaya hariana jaitu jalalabad jandialaguru sardulgarh kartarpur khamano khanauri kharar khemkaran kotkapura sangatmandi kurali lalru talwandisabo lehragaga longowal machiwara mahilpur majitha mallanwala maloud raman mamdot bariwala morinda mudki mukerian bhuchomandi nadala nakodar goniana nihalsinghwala nurmahal patran payal phillaur quadian rahon raikot rajasansi rajpura kotfatta ramdass rayya ropar samana samrala sanaur maur shahkot sujanpur shamchurasi sirhind srihargobindpur sunam talwandibhai talwara tapa tarntaran urmartanda gurdaspur mandigobindgarh dasuya abohar kapurthala patti derababananak zira makhu guruharsahai baghapurana dharamkot sultanpurlodhi nangal jagraon barnala ahmedgarh derabassi nabha malerkotla moonak mullanpurdakha goraya mohali sangrur rampuraphul hoshiarpur dhanaula moga phagwara nawanshahr kiratpursahib amritsar anandpursahib"
#for city in $legacypath; 
#do
#  echo "[ $(date) ] Running for $city ...!"	
#  export CITY_NAME=${city} && $LOGSTASH -f $CONF_FILE --path.data $PATH_DATA
#done
echo "[ $(date) ] Running for all cities...!"
$LOGSTASH -f $CONF_FILE --path.data $PATH_DATA
