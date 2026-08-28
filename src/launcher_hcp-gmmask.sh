#! /bin/bash

sid=$1

mni1mm="/usr/local/fsl/data/standard/MNI152_T1_1mm.nii.gz"
mni2mm="/usr/local/fsl/data/standard/MNI152_T1_2mm.nii.gz"
ribbon="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/ribbon.nii.gz"

gm_left="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/left.nii.gz"
gm_right="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/right.nii.gz"
gm_mask="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/sub-${sid}_space-MNI152_res-0p7mm_label-gm_mask.nii.gz"
gm_mask_1mm="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/sub-${sid}_space-MNI152_res-1mm_label-gm_mask.nii.gz"
gm_mask_2mm="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/sub-${sid}_space-MNI152_res-2mm_label-gm_mask.nii.gz"

fslmaths $ribbon -thr 3 -uthr 3 $gm_left
fslmaths $ribbon -thr 42 -uthr 42 $gm_right
fslmaths $gm_left -add $gm_right -bin $gm_mask

# for cmrglc: resample from MNI 0.7mm to MNI 1mm
antsApplyTransforms \
    -d 3 \
    -i $gm_mask \
    -r $mni1mm \
    -o $gm_mask_1mm \
    -n GenericLabel -u char 

# for fmri: resample from MNI 0.7mm to MNI 2mm
antsApplyTransforms \
    -d 3 \
    -i $gm_mask \
    -r $mni2mm \
    -o $gm_mask_2mm \
    -n GenericLabel -u char

rm $gm_left $gm_right
