#! /bin/bash

sid=$1

anat="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/ants-cortical-thickness/${sid}_desc-preproc_label-brain_T1w.nii.gz"
pet="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/niftypet-recon/${sid}_desc-preproc_frames-last5_stat-mean_label-brain_pet.nii.gz"
out="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/registration/${sid}_pet2anat_"
logfile="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/registration/pet2anat.log"

antsRegistrationSyN.sh \
    -d 3 \
    -n 3 \
    -t r \
    -f $anat \
    -m $pet \
    -o $out 2>&1 > $logfile
    # -x $anat_mask \
