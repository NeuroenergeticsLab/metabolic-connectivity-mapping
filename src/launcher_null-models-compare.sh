#! /bin/bash 

# time parallel --link --jobs 20 --progress /RAID1/jupytertmp/mcm/src/launcher_null-models-compare.sh ::: $(seq 1 10000 | shuf) ::: $(seq 1 10000 | shuf) >> /RAID1/jupytertmp/mcm/data/null-models/undirected-similarity-distro.txt

i1=$1
i2=$2

outfile="/RAID1/jupytertmp/mcm/data/null-models/undirected-similarity-distro.txt"
tum_null="/RAID1/jupytertmp/mcm/data/null-models/tum/undirected/undirected_null-$(printf '%05d' $i1).npz"
hcp_null="/RAID1/jupytertmp/mcm/data/null-models/hcp/undirected/undirected_null-$(printf '%05d' $i2).npz"
/RAID1/miniconda3/envs/roman/bin/python /RAID1/jupytertmp/mcm/src/null-models-similarity.py --a1 $tum_null --a2 $hcp_null >> $outfile

outfile="/RAID1/jupytertmp/mcm/data/null-models/directed-similarity-distro.txt"
tum_null="/RAID1/jupytertmp/mcm/data/null-models/tum/directed/directed_null-$(printf '%05d' $i1).npz"
hcp_null="/RAID1/jupytertmp/mcm/data/null-models/hcp/directed/directed_null-$(printf '%05d' $i2).npz"
/RAID1/miniconda3/envs/roman/bin/python /RAID1/jupytertmp/mcm/src/null-models-similarity.py --a1 $tum_null --a2 $hcp_null --directed >> $outfile