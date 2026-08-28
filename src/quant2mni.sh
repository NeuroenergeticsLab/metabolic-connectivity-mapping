#! /bin/bash

ROOT="/RAID1/jupytertmp/mcm/data"
ids=( 17 20 23 28 29 30 31 32 33 34 35 37 )
container="46ed9e90a9b4"
MNI="${ROOT}/external/mni/MNI152_T1_1mm_brain.nii.gz"

for id in "${ids[@]}"; do

    sid="sub-$(printf "%03d" $id)"
    quant="${ROOT}/${sid}/quant/${sid}_quant-1mm_desc-10frames_cmrglc.nii.gz"
    pet2mni="${ROOT}/${sid}/deriv-schaefer/${sid}_pet2mni.mat"
    if [[ ! -f $pet2mni ]]; then echo deos not exist: $pet2mni; fi
    if [[ ! -f $quant ]]; then echo deos not exist: $quant; fi
    output="${quant%.nii.gz}_space-MNI152.nii.gz"

    docker exec $container flirt \
        -in $quant \
        -ref $MNI \
        -init $pet2mni \
        -applyxfm \
        -interp spline \
        -out $output
    echo "done: ${sid}"
    echo '============================'
    echo
done