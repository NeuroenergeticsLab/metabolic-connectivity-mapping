#! /bin/bash

subjects=( 3 7 12 14 17 20 23 25 26 28 29 30 31 32 33 34 35 36 37 38 )

for subject in "${subjects[@]}"; do 
    sid=$(printf "s%03d" $subject)
    out="/RAID1/jupytertmp/mcm/data/bids/${sid}.zip"
    curl --netrc -X GET http://10.0.3.12/data/projects/fdgquant2016/subjects/${sid}/experiments/${sid}-AUF/resources/bids/files?format=zip --output $out && \
    unzip $out -d /RAID1/jupytertmp/mcm/data/bids/ && \
    mv "/RAID1/jupytertmp/mcm/data/bids/${sid}-AUF/resources/bids/files/sub-${sid}" /RAID1/jupytertmp/mcm/data/bids && \
    rm -r ${sid}{-AUF,.zip}
done