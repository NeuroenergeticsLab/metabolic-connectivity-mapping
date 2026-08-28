#! /bin/bash

# parallel --jobs 5 --delay 60 --progress /RAID1/jupytertmp/mcm/src/launcher_hcp-anat2mni.sh ::: *  

sid=$1

anat="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/T1w_acpc_dc_restore_brain.nii.gz"
mni="/usr/local/fsl/data/standard/MNI152_T1_1mm_brain.nii.gz"
out="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/sub-${sid}_anat2mni1mm_"
logfile="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/anat2mni1mm.log"

# antsRegistrationSyN.sh \
#     -d 3 \
#     -n 5 \
#     -t b \
#     -f $mni \
#     -m $anat \
#     -o $out 2>&1 >> $logfile


atlas="/RAID1/jupytertmp/mcm/data/external/schaefer/Schaefer2018_400Parcels_7Networks_order_FSLMNI152_1mm.nii.gz"
anat2mni_affine="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/sub-${sid}_anat2mni1mm_0GenericAffine.mat"
anat2mni_invwarp="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/sub-${sid}_anat2mni1mm_1InverseWarp.nii.gz"
out="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/sub-${sid}_Schaefer2018_400Parcels_7Networks_space-dwi_res-0p7mm_parcellation.nii.gz"
# antsApplyTransforms \
#     -d 3 \
#     -i $atlas \
#     -r $anat \
#     -o $out \
#     -n GenericLabel \
#     -t [ $anat2mni_affine,1 ] \
#     -t $anat2mni_invwarp 2>&1 >> $logfile


# Resample the parcellation to the diffusion data 
dwi_ref="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/Diffusion.bedpostX/mean_fsumsamples.nii.gz"
out="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/sub-${sid}_Schaefer2018_400Parcels_7Networks_space-dwi_res-1p25mm_parcellation.nii.gz"

# antsApplyTransforms \
#     -d 3 \
#     -i $atlas \
#     -r $dwi_ref \
#     -o $out \
#     -n GenericLabel \
#     -t [ $anat2mni_affine,1 ] \
#     -t $anat2mni_invwarp 2>&1 >> $logfile


# Spearate the atlas in diffusion space into indivindual masks for probtrackx
masks_dir="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/sub-${sid}_Schaefer2018_400Parcels_7Networks_space-dwi_res-1p25mm_masks"
atlas=$out
masks_file="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/sub-${sid}_Schaefer2018_400Parcels_7Networks_space-dwi_res-1p25mm_masks/masks.txt"
if [[ ! -d $masks_dir ]]; then
    mkdir $masks_dir
fi
touch $masks_file

for roi in {001..400}; do 
    fslmaths $atlas -thr $roi -uthr $roi "${masks_dir}/${roi}"
    echo "${masks_dir}/${roi}.nii.gz" >> $masks_file
done