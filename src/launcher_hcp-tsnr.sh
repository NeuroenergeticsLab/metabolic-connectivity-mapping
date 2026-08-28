#! /bin/bash

sid=$1

for dir in LR RL; do

    func="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/rfMRI_REST1_${dir}.nii.gz"
    mean="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/sub-${sid}_dir-${dir}_stat-mean_bold.nii.gz"
    std="${func%.nii.gz}_std.nii.gz"
    snr="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/sub-${sid}_dir-${dir}_stat-tsnr_bold.nii.gz"

    fslmaths $func -Tmean $mean
    fslmaths $func -Tstd $std
    fslmaths $mean -div $std $snr
    rm $std

done
