#!/bin/bash
#
# This batch file calls on your subject list (which contains both ID and wave number: SID000,wave1). 
# And runs the job_mriqc.sh file for each subject. 
# It saves the ouput and error files in specified directories.
#
# Set your directories

container=containers/poldracklab_fmriprep_latest-2017-12-07-ba92e815fc4e.img
group_dir=/projects/sanlab/shared/ #set path to directory within which study folder lives
study="REV" 
study_dir="${study_dir}""${study}"

# Set subject list
SUBJLIST=`cat subject_list_test.txt` 

# Loop through subjects and run job_mriqc
for SUBJ in $SUBJLIST; do

SUBID=`echo $SUBJ|awk '{print $1}' FS=","`
SESSID=`echo $SUBJ|awk '{print $2}' FS=","`
  
sbatch --export subid=${SUBID},sessid=${SESSID},group_dir=${group_dir},study_dir=${study_dir},study=${study},container=${container} --job-name fmriprep --partition=long -n16 --mem=75G --time=20:00:00 -o "${study_dir}"/"${study}"/REV_scripts/fMRI/ppc/output/"${SUBID}"_"${SESSID}"_fmriprep_output.txt -e "${study_dir}"/"${study}"/REV_scripts/fMRI/ppc/output/"${SUBID}"_"${SESSID}"_fmriprep_error.txt job_fmriprep.sh
	
done
