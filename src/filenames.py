from pathlib import Path


'''
Directories are pathlib.Path, files are str
'''

ROOTDIR         = Path("/RAID1/jupytertmp/mcm/")
DERIVS          = ROOTDIR / "data/bids/derivatives"

MNI152          = str(ROOTDIR / "data/external/mni/MNI152_T1_1mm_brain.nii.gz")
MNI_ICBM        = str(ROOTDIR / "data/external/mni/mni_icbm152_nlin_asym_09a/mni_icbm152_t1_tal_nlin_asym_09a_brain.nii.gz") 
SCHAEFER        = str(ROOTDIR / "data/external/schaefer/Schaefer2018_400Parcels_7Networks_order_FSLMNI152_1mm.nii.gz")
GLASSER         = str(ROOTDIR / "data/external/hcp_mmp/HCP-MMP1_on_MNI152_ICBM2009a_nlin.nii.gz")

# derivatives directories
cpac            = DERIVS / "sub-s{id:03}/cpac"
mrtrix          = DERIVS / "sub-s{id:03}/mrtrix"
niftypet        = DERIVS / "sub-s{id:03}/niftypet-recon"
quantification  = DERIVS / "sub-s{id:03}/quantification"
ants            = DERIVS / "sub-s{id:03}/ants-cortical-thickness"
registration    = DERIVS / "sub-s{id:03}/registration"
degree_centrality = DERIVS / "sub-s{id:03}/degree-centrality"


# fmri
bold            = str(cpac / "sub-s{id:03}_task-rest_desc-preproc_bold.nii.gz")
bold_mc         = str(cpac / "sub-s{id:03}_task-rest_desc-mc_bold.nii.gz")
bold_brain_mask = str(cpac / "sub-s{id:03}_task-rest_desc-brain_mask.nii.gz")
bold_mean       = str(cpac / "sub-s{id:03}_task-rest_desc-mc_stat-mean_bold.nii.gz")
bold_std        = str(cpac / "sub-s{id:03}_task-rest_desc-mc_stat-std_bold.nii.gz")
bold_snr        = str(cpac / "sub-s{id:03}_task-rest_desc-mc_stat-snr_bold.nii.gz")
bold_snr_mask   = str(cpac / "sub-s{id:03}_task-rest_desc-mc_stat-snr_thr-25_mask.nii.gz")
bold_snr_gm_mask = str(cpac / "sub-s{id:03}_task-rest_desc-mc_stat-snr_thr-25_label-GM_mask.nii.gz")

# dc
dc              = str(degree_centrality / "sub-s{id:03}_degree.nii.gz")
dc_binary       = str(degree_centrality / "sub-s{id:03}_desc-binary_degree.nii.gz")
dc_weighted     = str(degree_centrality / "sub-s{id:03}_desc-weighted_degree.nii.gz")
dc_smooth       = str(degree_centrality / "sub-s{id:03}_desc-weighted_proc-smooth_degree.nii.gz")

# dwi
fod             = str(mrtrix / "sub-s{id:03}_fod.mif")
dwi             = str(mrtrix / "sub-s{id:03}_desc-preproc_dwi.mif")
b0              = str(mrtrix / "sub-s{id:03}_desc-b0_dwi.nii.gz")
tracts          = str(mrtrix / "sub-s{id:03}_tracts.tck")
tracts_sift     = str(mrtrix / "sub-s{id:03}_desc-sifted_tracts.tck")
sift2_weights   = str(mrtrix / "sub-s{id:03}_desc-sift2_weights.txt")
sift2_mu        = str(mrtrix / "sub-s{id:03}_desc-sift2_mu.txt")
sift2_weights_mu = str(mrtrix / "sub-s{id:03}_desc-sift2_weightsmu.txt")
act_5tt         = str(mrtrix / "sub-s{id:03}_desc-5tt_segmentation.nii.gz")
connectome      = str(mrtrix / "sub-s{id:03}_connectome.csv")
connectome_sift2= str(mrtrix / "sub-s{id:03}_desc-sift2_connectome.csv")

# pet
aif             = str(niftypet / "sub-s{id:03}_blood.crv")
recon_info      = str(niftypet / "sub-s{id:03}_pet.json")
pet             = str(niftypet / "sub-s{id:03}_desc-preproc_pet.nii.gz")
pet_last5       = str(niftypet / "sub-s{id:03}_desc-preproc_frames-last5_pet.nii.gz")
pet_mean        = str(niftypet / "sub-s{id:03}_desc-preproc_frames-last5_stat-mean_pet.nii.gz")
pet_brain       = str(niftypet / "sub-s{id:03}_desc-preproc_frames-last5_stat-mean_label-brain_pet.nii.gz")
pet_brainmask   = str(niftypet / "sub-s{id:03}_desc-preproc_frames-last5_stat-mean_label-brain_mask.nii.gz")
pet_headmask    = str(niftypet / "sub-s{id:03}_desc-preproc_frames-last5_stat-mean_label-head_mask.nii.gz")

# quantification
blood_params    = str(quantification / "sub-s{id:03}_blood_params.joblib")
pet_params      = str(quantification / "sub-s{id:03}_pet_params.joblib")
cmrglc_3mm      = str(quantification / "sub-s{id:03}_quant-cmrglc_res-3mm_pet.nii.gz")
cmrglc_1mm      = str(quantification / "sub-s{id:03}_quant-cmrglc_res-1mm_desc-10frames_pet.nii.gz")
cmrglc_5frames  = str(quantification / "sub-s{id:03}_quant-cmrglc_res-1mm_desc-5frames_pet.nii.gz")

cmrglc_mni1mm = str(quantification / "sub-s{id:03}_quant-cmrglc_res-1mm_desc-10frames_space-mni1mm_pet.nii.gz")
cmrglc_mniICBM = str(quantification / "sub-s{id:03}_quant-cmrglc_res-1mm_desc-10frames_space-mniICBM2009cNlinAsym_pet.nii.gz")

# anat
t1              = str(ants / "sub-s{id:03}_desc-preproc_T1w.nii.gz")
t1_brain        = str(ants / "sub-s{id:03}_desc-preproc_label-brain_T1w.nii.gz")
t1_brainmask    = str(ants / "sub-s{id:03}_desc-preproc_label-brain_mask.nii.gz")
thickness       = str(ants / "sub-s{id:03}_thickness.nii.gz")

csf_prob        = str(ants / "sub-s{id:03}_desc-preproc_label-CSF_probseg.nii.gz")
gm_prob         = str(ants / "sub-s{id:03}_desc-preproc_label-GM_probseg.nii.gz")
wm_prob         = str(ants / "sub-s{id:03}_desc-preproc_label-WM_probseg.nii.gz")
sgm_prob        = str(ants / "sub-s{id:03}_desc-preproc_label-SGM_probseg.nii.gz")
bs_prob         = str(ants / "sub-s{id:03}_desc-preproc_label-BS_probseg.nii.gz")
cbm_prob        = str(ants / "sub-s{id:03}_desc-preproc_label-CBM_probseg.nii.gz")

csf_mask        = str(ants / "sub-s{id:03}_desc-preproc_label-CSF_mask.nii.gz")
gm_mask         = str(ants / "sub-s{id:03}_desc-preproc_label-GM_mask.nii.gz")
wm_mask         = str(ants / "sub-s{id:03}_desc-preproc_label-WM_mask.nii.gz")
sgm_mask        = str(ants / "sub-s{id:03}_desc-preproc_label-SGM_mask.nii.gz")
bs_mask         = str(ants / "sub-s{id:03}_desc-preproc_label-BS_mask.nii.gz")
cbm_mask        = str(ants / "sub-s{id:03}_desc-preproc_label-CBM_mask.nii.gz")

# transformations
anat2mniICBM_aff        = str(registration / "sub-s{id:03}_anat2mniICBM2009cNlinAsym_0GenericAffine.mat")
anat2mniICBM_warp       = str(registration / "sub-s{id:03}_anat2mniICBM2009cNlinAsym_1Warp.nii.gz")
anat2mniICBM_invwarp    = str(registration / "sub-s{id:03}_anat2mniICBM2009cNlinAsym_1InverseWarp.nii.gz")

anat2mni1mm_aff         = str(registration / "sub-s{id:03}_anat2mni1mm_0GenericAffine.mat")
anat2mni1mm_warp        = str(registration / "sub-s{id:03}_anat2mni1mm_1Warp.nii.gz")
anat2mni1mm_invwarp     = str(registration / "sub-s{id:03}_anat2mni1mm_1InverseWarp.nii.gz")

pet2anat        = str(registration / "sub-s{id:03}_pet2anat_0GenericAffine.mat")
func2anat       = str(registration / "sub-s{id:03}_func2anat_bbr_0GenericAffine.mat")
dwi2anat        = str(registration / "sub-s{id:03}_dwi2anat_bbr_0GenericAffine.mat")

# these are the inputs to mcm
schaefer_func   = str(DERIVS / "sub-s{id:03}" / ("sub-s{id:03}_" + Path(SCHAEFER).name.replace(".nii.gz", "_space-func.nii.gz")))
schaefer_dwi    = str(DERIVS / "sub-s{id:03}" / ("sub-s{id:03}_" + Path(SCHAEFER).name.replace(".nii.gz", "_space-dwi.nii.gz")))
schaefer_pet    = str(DERIVS / "sub-s{id:03}" / ("sub-s{id:03}_" + Path(SCHAEFER).name.replace(".nii.gz", "_space-pet.nii.gz")))

gm_mask_func    = gm_mask.replace("_mask.nii.gz", "_space-func_mask.nii.gz")
gm_mask_dwi     = gm_mask.replace("_mask.nii.gz", "_space-dwi_mask.nii.gz")
gm_mask_pet     = gm_mask.replace("_mask.nii.gz", "_space-pet_mask.nii.gz")


def get(name: str):
    return __import__(__name__).__dict__[name]