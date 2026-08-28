#! /bin/bash

sid=$1
t1="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/ants-cortical-thickness/${sid}_desc-preproc_T1w.nii.gz"
t2="/RAID1/jupytertmp/mcm/data/bids/${sid}/anat/${sid}_T2w.nii.gz"
out="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/freesurfer"
logfile="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/freesurfer/recon-all.log"

if [[ -f $t2 ]]; then
    args="-T2 ${t2} -T2pial"
else
    args=""
fi

recon-all \
    -subject $sid \
    -i $t1 \
    $args \
    -all \
    -sd $out \
    -threads 5 2>&1 > $logfile
