#!/bin/bash

# [documentation]

# load afni
module load afni

echo $subid

# # define paths
# fxDir=/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-"${subid}"/fx
# mapDir=/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/neurosynth_maps
# outputDir=/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/expression_maps

# # Capacity
# # define maps
# sstMap="${fxDir}"/sst/spmT_0001.nii 
# icMap="${mapDir}"/inhibitory_control_uniformity-test_z_FDR_0.01.nii.gz

# # align maps
# 3dAllineate -source "${icMap}" -master "${sstMap}" -final NN -1Dparam_apply '1D: 12@0'\' -prefix "${mapDir}"/aligned_maps/aligned_inhibitory_control_"${subid}"
# aligned_icMap="${mapDir}"/aligned_maps/aligned_inhibitory_control_"${subid}"+tlrc.BRIK

# # multiply maps
# echo "${subid}" SST_SST `3ddot -dodot "${sstMap}" "${sstMap}"` >> "${outputDir}"/"${subid}".txt
# echo "${subid}" SST_NeuroSynth_IC `3ddot -dodot "${sstMap}" "${aligned_icMap}"` >> "${outputDir}"/"${subid}".txt


# # Tendency
# # define maps
# reactMap="${fxDir}"/react/spmT_0001.nii 
# crMap="${mapDir}"/reappraisal_uniformity-test_z_FDR_0.01.nii.gz

# # align maps
# 3dAllineate -source "${crMap}" -master "${reactMap}" -final NN -1Dparam_apply '1D: 12@0'\' -prefix "${mapDir}"/aligned_maps/aligned_reappraisal_"${subid}"
# aligned_crMap="${mapDir}"/aligned_maps/aligned_reappraisal_"${subid}"+tlrc.BRIK

# # multiply maps
# echo "${subid}" SST_React `3ddot -dodot "${sstMap}" "${reactMap}"` >> "${outputDir}"/"${subid}".txt
# echo "${subid}" React_NeuroSynth_IC `3ddot -dodot "${reactMap}" "${aligned_icMap}"` >> "${outputDir}"/"${subid}".txt
# echo "${subid}" React_NeuroSynth_CR `3ddot -dodot "${reactMap}" "${aligned_crMap}"` >> "${outputDir}"/"${subid}".txt
