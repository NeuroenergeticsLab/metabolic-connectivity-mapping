#! /bin/bash

# time parallel --jobs 1 --delay 600 --progress /RAID1/jupytertmp/mcm/src/launcher_hcp-tractography.sh ::: *

sid=$1

masks="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/sub-${sid}_Schaefer2018_400Parcels_7Networks_space-dwi_res-1p25mm_masks/masks.txt"
samples="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/Diffusion.bedpostX/merged"
brain="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/Diffusion.bedpostX/nodif_brain_mask"
output="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/probtrackx"
logfile="/RAID1/jupytertmp/mcm/data/external/hcp/${sid}/T1w/probtrackx.log"

if [[ -d $output ]]; then
    echo "$output already exists!" && exit 1
fi

probtrackx2_gpu \
    --network \
    -V 2 \
    -x $masks \
    -l \
    --onewaycondition \
    --loopcheck \
    -c 0.2 \
    -S 2000 \
    --steplength=0.5 \
    -P 5000 \
    --fibthresh=0.01 \
    --distthresh=0.0 \
    --sampvox=0.0 \
    --forcedir \
    --opd \
    --pd \
    --ompl \
    -s $samples \
    -m $brain \
    --dir=$output 2>&1 > $logfile