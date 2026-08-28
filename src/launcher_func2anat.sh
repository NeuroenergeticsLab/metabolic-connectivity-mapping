#! /bin/bash

sid=$1

epi="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/cpac/${sid}_task-rest_desc-mc_stat-mean_bold.nii.gz"
t1="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/ants-cortical-thickness/${sid}_desc-preproc_T1w.nii.gz"
brain="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/ants-cortical-thickness/${sid}_desc-preproc_label-brain_T1w.nii.gz"
wm="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/ants-cortical-thickness/${sid}_desc-preproc_label-WM_mask.nii.gz"
out="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/registration/${sid}_func2anat_bbr"
logfile="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/registration/func2anat.log"

epi_reg \
    --epi=$epi \
    --t1=$t1 \
    --t1brain=$brain \
    --wmseg=$wm \
    --out=$out 2>&1 > $logfile 

# fsl_mat="${out}.mat"
# itk_mat="${out}_itk.mat"
# c3d_affine_tool \
#     -ref $t1 \
#     -src $epi \
#     -i $fsl_mat \
#     -fsl2ras \
#     -oitk $itk_mat
