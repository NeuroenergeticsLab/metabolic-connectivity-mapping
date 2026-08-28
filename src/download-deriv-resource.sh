#! /bin/bash

subjects=( 3 7 12 14 17 20 23 25 26 28 29 30 31 32 33 34 35 36 37 38 )
resource="ants-cortical-thickness"

for subject in "${subjects[@]}"; do 

    sid=$(printf "s%03d" $subject)
    zip_download="/RAID1/jupytertmp/mcm/data/tmp/${sid}.zip"
    dest="/RAID1/jupytertmp/mcm/data/bids/derivatives/${resource}/sub-${sid}"

    curl --netrc -X GET http://10.0.3.12/data/projects/fdgquant2016/subjects/${sid}/experiments/${sid}-AUF/resources/${resource}/files?format=zip --output $zip_download && \
    unzip $zip_download -d /RAID1/jupytertmp/mcm/data/tmp/ && \
    mkdir $dest && \
    mv /RAID1/jupytertmp/mcm/data/tmp/${sid}-AUF/resources/${resource}/files/* $dest && \
    rm -r $zip_download /RAID1/jupytertmp/mcm/data/tmp/${sid}-AUF
done