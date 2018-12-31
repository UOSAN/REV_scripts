#!/bin/bash
#--------------------------------------------------------------
# Inputs:
#	* STUDY = study name
#	* SUBJLIST = subject_list.txt
#	* SCRIPT = MATLAB script to create and execute batch job
#	* PROCESS = running locally, via qsub, or on the Mac Pro
#	* Edit output and error paths
#
# Outputs:
#	* Executes spm_job.sh for $SUB and $SCRIPT
#
#--------------------------------------------------------------

# Set your study
STUDY=/projects/sanlab/shared/REV

#SPM Path
SPM_PATH=/projects/sanlab/shared/spm12

# Set MATLAB script path
SCRIPT=${STUDY}/REV_scripts/fMRI/rx/prepost_analysis/scripts/rx-rev_con-01.m

# Tag the results files
RESULTS_INFIX=rx-rev_con-01

# Set output dir
OUTPUTDIR=${STUDY}/REV_scripts/fMRI/rx/prepost_analysis/con-01

if [ ! -d ${OUTPUTDIR} ]; then
    mkdir -v ${OUTPUTDIR}
fi


# Set processor
# use "qsub" for HPC
# use "local" for local machine
# use "parlocal" for local parallel processing

PROCESS=slurm

# Max jobs only matters for par local
MAXJOBS=8

#Only matters for slurm
cpuspertask=1
mempercpu=10G

# Create and execute batch job
if [ "${PROCESS}" == "slurm" ]; then
    echo "submitting via slurm"
    sbatch SCRIPT=$SCRIPT, SPM_PATH=$SPM_PATH  \
        --job-name=${RESULTS_INFIX} \
        -o "${OUTPUTDIR}"/"${RESULTS_INFIX}".log \
        --cpus-per-task=${cpuspertask} \
        --mem-per-cpu=${mempercpu} \
        spm_job.sh
    sleep .25

elif [ "${PROCESS}" == "local" ]; then 
	for SUB in $SUBJLIST
	do
	 echo "submitting locally"
	 bash spm_job.sh ${REPLACESID} ${SCRIPT} ${SUB} > "${OUTPUTDIR}"/"${SUBJ}"_"${RESULTS_INFIX}"_output.txt 2> /"${OUTPUTDIR}"/"${SUBJ}"_"${RESULTS_INFIX}"_error.txt
	done

elif [ "${PROCESS}" == "parlocal" ]; then 
	parallel --verbose --results "${OUTPUTDIR}"/{}_${RESULTS_INFIX}_output -j${MAXJOBS} bash spm_job.sh ${REPLACESID} ${SCRIPT} :::: subject_list.txt
fi