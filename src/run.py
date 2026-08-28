#! /RAID1/miniconda3/envs/roman/bin/python

import argparse
from pathlib import Path

import numpy as np
from nibabel import load
from nilearn.masking import apply_mask
import joblib
from bct import threshold_proportional

import pymcm


def main(subject_id: int, func_img: Path, func_mask: Path, func_atlas: Path, pet_img: Path, pet_mask: Path, pet_atlas: Path, sc_file: Path, voxel_counts: Path) -> pymcm.data.Subject:
    
    # Create a subject and populate with imaging data
    subject = pymcm.data.Subject(id=subject_id, name=f'sub{subject_id}')
    fmri = pymcm.data.ImagingSpace(name='fmri')
    fmri.add_raws(
        img=load(func_img),
        mask=load(func_mask),
        atlas=load(func_atlas)
    )

    pet = pymcm.data.ImagingSpace(name='cmrglc')
    pet.add_raws(
        img=load(pet_img),
        mask=load(pet_mask),
        atlas=load(pet_atlas)
    )

    dwi = pymcm.data.ImagingSpace(name='diff')

    subject.add_raws(
        fmri=fmri,
        dwi=dwi,
        pet=pet
    )
    
    # Find the intersection of images
    for space in subject.iterraw():
        if 'diff' in space.name:
            continue
        intersection = pymcm.processing.voxel_intersection(space.img, space.atlas, space.mask)
        data = apply_mask(space.img, intersection)
        labels = apply_mask(space.atlas, intersection)
        space.add_derivs(
            voxint_mask=intersection,
            masked_data=data,
            masked_labels=labels
        )

        for img in space.iterraw():
            img.uncache()


    # Find the region averages
    for space in subject.iterraw():
        if 'diff' in space.name:
            continue
        data, labels = space['masked_data'], space['masked_labels']
        roiavgs = pymcm.processing.roi_stat(data=data, labels=labels, func='mean')
        space.add_derivs(roiavgs=roiavgs)


    # Functional connectivity
    timeseries = subject.fmri['roiavgs']
    fc = pymcm.processing.connectivity(timeseries, func=pymcm.array.corr, zero_diag=True, positive=True)
    pfc = pymcm.processing.connectivity(timeseries, func=pymcm.array.partial_corr, zero_diag=True, positive=True)
    degree = fc.sum(axis=0)
    subject.fmri.add_derivs(fc=fc, pfc=pfc, degree=degree)

    # Structural connectivity
    sc_raw = np.loadtxt(sc_file)
    counts = np.loadtxt(voxel_counts)
    N = counts[:, np.newaxis] + counts[np.newaxis, :]
    M = sc_raw + sc_raw.T
    sc_weight = M / (5000 * N)
    sc_bin = sc_weight > 0
    sc_thr = threshold_proportional(sc_weight, 0.2)
    sc_thr = sc_thr > 0
    degree = sc_weight.sum(axis=0)
    subject.dwi.add_derivs(sc_raw=sc_raw, sc_weight=sc_weight, sc_bin=sc_bin, sc_thr=sc_thr, counts=counts, degree=degree)

    # # PET logratio
    # degree = subject[conn_method].sum(axis=0) # adjustment for the cmrglc averages
    # cmrglc_adj = subject.pet['roiavgs'] / degree # adjusted roi averages of cmrglc 
    # logratio = pymcm.processing.pet_logratio(cmrglc_adj)
    # dir_weights, undir_weights = pymcm.processing.logratio_to_weights(logratio)

    # subject.add_derivs(
    #     degree=degree,
    #     cmrglc_adj=cmrglc_adj,
    #     logratio=logratio, 
    #     dir_weights=dir_weights, 
    #     undir_weights=undir_weights
    #     )



    # # Directed and undirected connectivity
    # directed = subject[conn_method] * dir_weights * sc_mask
    # undirected = subject[conn_method] * undir_weights * sc_mask

    # subject.add_derivs(
    #     directed=directed, 
    #     undirected=undirected
    # )

    return subject



if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--subject', type=str, required=True, help='Subject id')
    parser.add_argument('--func', nargs=3, required=True, help='Specify images in functional space in order: main image, mask, atlas')
    parser.add_argument('--pet', nargs=3, required=True, help='Specify images in PET space in order: main image, mask, atlas')
    parser.add_argument('--probtrackx', required=True, help='Specify base path to the probtrackx outputs')
    parser.add_argument('--conn_method', required=False, type=str, choices=['pfc', 'fc', 'sc'], default='fc')
    parser.add_argument('--output', type=str, default='/RAID1/jupytertmp/mcm/data/subject.joblib', help='Path of the resulting subject obj')

    args = parser.parse_args()

    func_image, func_mask, func_atlas = [Path(p) for p in args.func]
    pet_image, pet_mask, pet_atlas = [Path(p) for p in args.pet]

    probtrackx = Path(args.probtrackx)
    sc_file = probtrackx / 'fdt_network_matrix'
    voxel_counts = probtrackx / 'NumSeeds_of_ROIs'

    subject = main(args.subject, func_image, func_mask, func_atlas, pet_image, pet_mask, pet_atlas, sc_file=sc_file, voxel_counts=voxel_counts)
    _ = joblib.dump(subject, args.output)
