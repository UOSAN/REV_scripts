#!/bin/bash

# [documentation]

# load afni
module load afni

# define subs
#subject_list=`cat expression_maps_subject_list.txt` 
subject_list=(REV001 REV002 REV003 REV006 REV010 REV011 REV012 REV013 REV015 REV016 REV017 REV018 REV020 REV021 REV022 REV023 REV024 REV029 REV030 REV031 REV033 REV035 REV036 REV037 REV038 REV039 REV040 REV041 REV042 REV044 REV046 REV048 REV050 REV052 REV053 REV054 REV056 REV057 REV060 REV063 REV064 REV065 REV067 REV068 REV069 REV070 REV073 REV074 REV075 REV076 REV077 REV078 REV079 REV080 REV082 REV084 REV085 REV086 REV089 REV090 REV091 REV093 REV094 REV095 REV097 REV098 REV100 REV101 REV102 REV104 REV105 REV107 REV108 REV109 REV110 REV111 REV112 REV113 REV114 REV115 REV118 REV119 REV120 REV121 REV124 REV126 REV127 REV129 REV130 REV131 REV132 REV135 REV136 REV137 REV140 REV141 REV142 REV144)

echo $subject_list

for subid in ${subject_list[@]}
do
	echo $subid
	# define paths
	fxDir=/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-"${subid}"/fx
	echo $fxDir
	mapDir=/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/neurosynth_maps
	outputDir=/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/expression_maps

	# Capacity
	# define maps
	sstMap="${fxDir}"/sst/spmT_0001.nii 
	icMap="${mapDir}"/inhibitory_control_uniformity-test_z_FDR_0.01.nii.gz

	# align maps
	3dAllineate -source "${icMap}" -master "${sstMap}" -final NN -1Dparam_apply '1D: 12@0'\' -prefix "${mapDir}"/aligned_maps/aligned_inhibitory_control_"${subid}"
	aligned_icMap="${mapDir}"/aligned_maps/aligned_inhibitory_control_"${subid}"+tlrc.BRIK

	# multiply maps
	echo "${subid}" SST_SST `3ddot -dodot "${sstMap}" "${sstMap}"` >> "${outputDir}"/"${subid}".txt
	echo "${subid}" SST_NeuroSynth_IC `3ddot -dodot "${sstMap}" "${aligned_icMap}"` >> "${outputDir}"/"${subid}".txt


	# Tendency
	# define maps
	reactMap="${fxDir}"/react/spmT_0001.nii 
	crMap="${mapDir}"/reappraisal_uniformity-test_z_FDR_0.01.nii.gz

	# align maps
	3dAllineate -source "${crMap}" -master "${reactMap}" -final NN -1Dparam_apply '1D: 12@0'\' -prefix "${mapDir}"/aligned_maps/aligned_reappraisal_"${subid}"
	aligned_crMap="${mapDir}"/aligned_maps/aligned_reappraisal_"${subid}"+tlrc.BRIK

	# multiply maps
	echo "${subid}" SST_React `3ddot -dodot "${sstMap}" "${reactMap}"` >> "${outputDir}"/"${subid}".txt
	echo "${subid}" React_NeuroSynth_IC `3ddot -dodot "${reactMap}" "${aligned_icMap}"` >> "${outputDir}"/"${subid}".txt
	echo "${subid}" React_NeuroSynth_CR `3ddot -dodot "${reactMap}" "${aligned_crMap}"` >> "${outputDir}"/"${subid}".txt
done
