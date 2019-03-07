#!/bin/bash

# This script merges beta maps listed in 'list_of_bmaps.txt'.

# Use fslmerge command from FSL to append all beta images from all subjects. So it will be beta1, beta2, etc from subject 1, 
# then beta 1, beta 2, etc, from subject 2, etc.

cd /projects/sanlab/shared/REV/REV_scripts/fMRI/fx/React/mvpa_analysis

# This is the text file that lists the full paths for all beta files to be concatenated
b_list=`cat list_of_bmaps_baseline.txt`

# Merge all the beta maps
module load fsl
fslmerge -t "/projects/sanlab/shared/REV/archive/react_mvpa/neutr_prc_betas.nii" $b_list
