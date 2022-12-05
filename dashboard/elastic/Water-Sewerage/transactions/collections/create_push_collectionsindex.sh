#!/bin/bash
export PATH=/home/ubuntu/bin:/home/ubuntu/.local/bin:/usr/share/jdk1.8.0_131/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

export PGPASSWORD=<input db user password here>
legacypath="adampur ajnala alawalpur amargarh amloh badhnikalan balachaur bareta banga banur bhikhi boha bassipathana batala budhlada begowal bhadaur bhadson gidderbaha bhawanigarh bhogpur bhulath malout mansa cheema dhariwal dhilwan dhuri dinanagar dirba doraha faridkot fatehgarhchurian fazilka ferozepur garhdiwala garhshankar ghagga ghanaur handiaya hariana jaitu jalalabad jandialaguru sardulgarh kartarpur khamano khanauri kharar khemkaran kotkapura sangatmandi kurali lalru talwandisabo lehragaga longowal machiwara mahilpur majitha mallanwala maloud raman mamdot bariwala morinda mudki mukerian bhuchomandi nadala nakodar goniana nihalsinghwala nurmahal patran payal phillaur quadian rahon raikot rajasansi rajpura kotfatta ramdass rayya ropar samana samrala sanaur maur shahkot sujanpur shamchurasi sirhind srihargobindpur sunam talwandibhai talwara tapa tarntaran urmartanda gurdaspur mandigobindgarh dasuya abohar kapurthala patti derababananak zira makhu guruharsahai baghapurana dharamkot sultanpurlodhi nangal jagraon barnala ahmedgarh derabassi nabha malerkotla moonak mullanpurdakha goraya mohali sangrur rampuraphul hoshiarpur dhanaula moga phagwara"
for d in $legacypath; do
  echo $d
  sh ./push_wt_es_index.sh $d
  echo "Water and Sewerage Collections/Receipts Statistics pushed to ES for city "$d
done

