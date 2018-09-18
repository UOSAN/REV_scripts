#!/bin/bash
#
# This batch file calls on your subject list (which contains both ID and wave number: SID000,wave1). 
# And runs the job_fmriprep.sh file for each subject. 
# It saves the ouput and error files in specified directories.
#

# Define paths and variables
output_dir=/projects/sanlab/shared/REV/REV_scripts/fMRI/expression_maps/output #set path to output directory
log_name=expression_maps #log output name
script=expression_maps.sh #shell script name

# Make the output directory if it does not exist
if [ ! -d "${output_dir}" ]; then
    mkdir -v "${output_dir}"
fi

# Set subject list
subject_list=`cat expression_maps_subject_list.txt` 

# Loop through subjects and run shell script
for subid in $subject_list; do
  
sbatch --export subid=${subid} --job-name expression_maps --partition=short --cpus-per-task=1 -o "${output_dir}"/"${subid}"_"${log_name}"_out.log -e "${output_dir}"/"${subid}"_"${log_name}"_error.log "${script}"
	
done
