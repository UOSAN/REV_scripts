#!/bin/bash

# This script runs fmriprep on subjects located in the BIDS directory 
# and saves ppc-ed output and motion confounds
# in the derivatives folder.

# Set bids directories
bids_dir="${group_dir}""${study}"/bids_data
derivatives="${bids_dir}"/derivatives
working_dir="${derivatives}"/working/
image="${group_dir}""${container}"

echo -e "\nfMRIprep on ${subid}_${sessid}"
echo -e "\nContainer: $image"
echo -e "\nSubject directory: $bids_dir"

# Source task list
#tasks=`cat tasks.txt` 
tasks=(sst gng bart react)

# Load packages
module load singularity

# Create working directory
mkdir -p $working_dir

# Run container using singularity
cd $bids_dir

for task in ${tasks[@]}; do

echo -e "\nStarting on: $task"
echo -e "\n"

PYTHONPATH="" singularity run --bind "${group_dir}":"${group_dir}" $image $bids_dir $derivatives participant --participant_label $subid -t $task --output-space {template,T1w,fsnative} --nthreads 1 --mem-mb 100000 --fs-license-file /projects/sanlab/shared/REV/REV_scripts/fMRI/license.txt


echo -e "\n"
echo -e "\ndone"
echo -e "\n-----------------------"

done
