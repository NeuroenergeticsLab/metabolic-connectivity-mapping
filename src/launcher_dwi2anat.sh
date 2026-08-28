#! /bin/bash

sid=$1

b0="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/mrtrix/${sid}_desc-b0_dwi.nii.gz"
t1="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/ants-cortical-thickness/${sid}_desc-preproc_T1w.nii.gz"
brain="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/ants-cortical-thickness/${sid}_desc-preproc_label-brain_T1w.nii.gz"
wm="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/ants-cortical-thickness/${sid}_desc-preproc_label-WM_mask.nii.gz"
out="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/registration/${sid}_dwi2anat_bbr"
logfile="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/registration/dwi2anat.log"

epi_reg \
    --epi=$b0 \
    --t1=$t1 \
    --t1brain=$brain \
    --wmseg=$wm \
    --out=$out 2>&1 > $logfile 