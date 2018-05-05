#!/bin/bash

# This script runs mriqc on subjects located in the BIDS directory 
# and saves quality control outputs in the derivatives folder.

# Set bids directories
bids_dir="${group_dir}""${study}"/bids_data
derivatives="${bids_dir}"/derivatives/
working_dir="${derivatives}"/working
image="${group_dir}""${container}"

echo -e "\nfMRIprepon ${subid}_${sessid}"
echo -e "\nContainer: $image"
echo -e "\nSubject directory: $bids_dir"

# Load packages
module load singularity

# Create working directory
mkdir -p $working_dir

# Run container using singularity
cd $bids_dir

singularity run --bind "${group_dir}":"${group_dir}" $image $bids_dir $derivatives participant --participant_label $subid --session-id $sessid -w $working_dir --n_procs 16 --mem_gb 64

echo -e "\n"
echo -e "\ndone"
echo -e "\n-----------------------"
