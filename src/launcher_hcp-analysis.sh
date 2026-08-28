#! /bin/bash

# time parallel --jobs 10 --delay 10 --progress /RAID1/jupytertmp/mcm/src/launcher_hcp-analysis.sh ::: *

sid=$1

func_image="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/rfMRI_REST1_LR.nii.gz"
func_mask="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/sub-${sid}_space-MNI152_res-2mm_label-gm_mask.nii.gz"
func_atlas="/RAID1/jupytertmp/mcm/data/external/schaefer/Schaefer2018_400Parcels_7Networks_order_FSLMNI152_2mm.nii.gz"
pet_image="/RAID1/jupytertmp/mcm/data/cmrglc-maps/quant-cmrglc_res-1mm_desc-10frames_space-mni1mm_pet.nii.gz"
pet_mask="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/sub-${sid}_space-MNI152_res-1mm_label-gm_mask.nii.gz"
pet_atlas="/RAID1/jupytertmp/mcm/data/external/schaefer/Schaefer2018_400Parcels_7Networks_order_FSLMNI152_1mm.nii.gz"
probtrackx_dir="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/probtrackx"

output="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/sub-${sid}_data.joblib"

/RAID1/jupytertmp/mcm/src/run.py \
    --subject $sid \
    --func $func_image $func_mask $func_atlas \
    --pet $pet_image $pet_mask $pet_atlas \
    --probtrackx $probtrackx_dir \
    --output $output