# /bin/bash 

sid=$1

anat="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/ants-cortical-thickness/${sid}_desc-brain_T1w.nii.gz"

# mni="/RAID1/jupytertmp/mcm/data/external/mni/mni_icbm152_nlin_asym_09c/mni_icbm152_t1_tal_nlin_asym_09c_brain.nii.gz"
# out="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/registration/${sid}_anat2mniICBM2009cNlinAsym_"
# logfile="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/registration/anat2mniICBM2009cNlinAsym.log"

mni="/usr/local/fsl/data/standard/MNI152_T1_1mm_brain.nii.gz"
out="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/registration/${sid}_anat2mni1mm_"
logfile="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/registration/anat2mni1mm.log"

antsRegistrationSyN.sh \
    -d 3 \
    -n 5 \
    -t b \
    -f $mni \
    -m $anat \
    -o $out 2>&1 > $logfile

# -x "$mni_mask,$anat_mask" \
# anat_mask="/RAID1/jupytertmp/mcm/data/bids/derivatives/${sid}/ants-cortical-thickness/${sid}_desc-brain_mask.nii.gz"
# mni_mask="/RAID1/jupytertmp/mcm/data/external/mni/mni_icbm152_nlin_asym_09c/mni_icbm152_t1_tal_nlin_asym_09c_mask.nii.gz"
# mni_mask="/usr/local/fsl/data/standard/MNI152_T1_1mm_brain_mask.nii.gz"