#! /bin/bash

for hemi in lh rh; do
    parallel \
        --results "/RAID1/jupytertmp/mcm/data/fsa5-geodistance/${hemi}_pial-node{}_gdist.txt" \
        --verbose \
        --jobs 20 \
        --delay 0.5 \
        SurfDist \
            -i "/RAID1/jupytertmp/mcm/data/external/fsaverage5/gifti/${hemi}_pial.gii" \
            -input "/RAID1/jupytertmp/mcm/data/fsa5-geodistance/nodes.1D" \
            -from_node {} ::: $(seq 0 10241)
done