#!/bin/bash

# This script is an adaptation of expression_maps_loop.sh that creates a pattern expression value for each trial of 
# Cue Reactivity for each subject using Neurosynth "inhibitory control" and "craving" maps. 

# load afni
module load afni

# define subs
#subject_list=`cat expression_maps_subject_list.txt` 
subject_list=(REV001 REV002 REV003 REV005 REV006 REV010 REV011 REV012 REV013 REV014 REV015 REV016 REV017 REV018 REV019 REV020 REV021 REV022 REV023 REV024 REV029 REV030 REV031 REV032 REV033 REV035 REV036 REV037 REV038 REV039 REV040 REV041 REV042 REV043 REV044 REV045 REV046 REV047 REV048 REV049 REV050 REV051 REV052 REV053 REV054 REV055 REV056 REV057 REV059 REV060 REV062 REV063 REV064 REV065 REV067 REV068 REV069 REV070 REV072 REV073 REV074 REV075 REV076 REV077 REV078 REV079 REV080 REV082 REV084 REV085 REV086 REV088 REV089 REV090 REV091 REV093 REV094 REV095 REV097 REV098 REV100 REV101 REV102 REV104 REV105 REV107 REV108 REV109 REV110 REV111 REV112 REV113 REV114 REV115 REV116 REV118 REV119 REV120 REV121 REV122 REV124 REV125 REV126 REV127 REV128 REV129 REV130 REV131 REV132 REV134 REV135 REV136 REV137 REV138 REV140 REV141 REV142 REV144)



echo $subject_list

for subid in ${subject_list[@]}
do
	echo $subid
	# define paths
	betaDir=/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-"${subid}"/fx/react/betaseries
	echo $betaDir
	mapDir=/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/neurosynth_maps/betaseries
	outputDir=/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/expression_maps/betaseries

	betas=`cat /projects/sanlab/shared/REV/REV_scripts/fMRI/expression_maps/betaseries/subject_beta_info/all_"${subid}".txt` #list of beta map file names

	for beta in ${betas[@]}; do 

	### IC Pattern Expression Values

	# define maps
	react_betaMap="${betaDir}"/"${beta}"
	icMap="${mapDir}"/inhibitory_control_uniformity-test_z_FDR_0.01.nii.gz

	# align maps
	3dAllineate -source "${icMap}" -master "${react_betaMap}" -final NN -1Dparam_apply '1D: 12@0'\' -prefix "${mapDir}"/aligned_maps/aligned_inhibitory_control_"${subid}"
	aligned_icMap="${mapDir}"/aligned_maps/aligned_inhibitory_control_"${subid}"+tlrc.BRIK

	# multiply maps
	echo "${subid}" "${beta}" NeuroSynth_IC `3ddot -dodot "${react_betaMap}" "${aligned_icMap}"` >> "${outputDir}"/"${subid}".txt

 
	### Craving Expression Values

	# define maps
	react_betaMap="${betaDir}"/"${beta}"
	cravingMap="${mapDir}"/craving_uniformity-test_z_FDR_0.01.nii.gz

	# align maps
	3dAllineate -source "${cravingMap}" -master "${react_betaMap}" -final NN -1Dparam_apply '1D: 12@0'\' -prefix "${mapDir}"/aligned_maps/aligned_craving_"${subid}"
	aligned_cravingMap="${mapDir}"/aligned_maps/aligned_craving_"${subid}"+tlrc.BRIK

	# multiply maps
	echo "${subid}" "${beta}" NeuroSynth_Craving `3ddot -dodot "${react_betaMap}" "${aligned_cravingMap}"` >> "${outputDir}"/"${subid}".txt
done
done

