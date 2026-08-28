#! /bin/bash

subjects=( 3 7 12 14 17 20 23 25 26 28 29 30 31 32 33 34 35 36 37 38 )
i=0
for subject in "${subjects[@]}"; do 
    sid=$(printf "s%03d" $subject)
    input="/RAID1/jupytertmp/mcm/data/bids/sub-${sid}/anat/sub-${sid}_T1w.nii.gz"
    out="/RAID1/jupytertmp/mcm/data/bids/derivatives/anat-preproc/sub-${sid}"
    logfile="/RAID1/jupytertmp/mcm/data/bids/logs/sub-${sid}_anat-preproc.log"
    device=$(( $i % 2 ))
    bash /RAID1/jupytertmp/roman/scripts/anat-preproc/anat-preproc.sh -i $input -o $out -g $device >> $logfile &
    pid=$!
    ((i+=1))
    if ! (( $i % 5 )); then
        echo "${i}, waiting for: ${pid}"
        wait $pid
        sleep 500
    fi
done