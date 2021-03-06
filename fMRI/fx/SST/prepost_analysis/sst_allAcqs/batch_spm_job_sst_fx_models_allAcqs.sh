#!/bin/bash
#--------------------------------------------------------------
# Inputs:
#   * STUDY = study name
#   * SUBJLIST = subject_list.txt
#   * SCRIPT = MATLAB script to create and execute batch job
#   * PROCESS = running locally, via job scheduler, or on the Mac Pro
#   * Edit output and error paths
#
# Outputs:
#   * Executes spm_job.sh for $SUB and $SCRIPT
#
# D.Cos 2017.3.7
#--------------------------------------------------------------

# Set your study
STUDY=/projects/sanlab/shared/REV

# Set task
TASK='sst'

# Set subject list
SUBSET='allAcqs'
SUBJLIST=`cat subject_list_${TASK}_${SUBSET}.txt`

# Set script folder
PATH2SCRIPTS=${STUDY}/REV_scripts/fMRI/fx/SST/prepost_analysis/${TASK}_${SUBSET}

# Which SID should be replaced?
REPLACESID='REV001'

# Set MATLAB script path
#COMPNAME=ralph #use this for help specifying paths to run locally
SCRIPT=${PATH2SCRIPTS}/matlabbatch_job_${TASK}_${SUBSET}.m

#SPM Path
SPM_PATH=/projects/sanlab/shared/spm12

# Tag the results files
RESULTS_INFIX=fx_models

# Set output dir
if [ ! -d "${PATH2SCRIPTS}/output_logs" ]; then
    mkdir -v "${PATH2SCRIPTS}/output_logs"
fi
OUTPUTDIR=${PATH2SCRIPTS}/output_logs

# make sid_batch dir if doesn't exist
if [ ! -d "${PATH2SCRIPTS}/sid_batches" ]; then
    mkdir -v "${PATH2SCRIPTS}/sid_batches"
fi

if [ ! -d "${PATH2SCRIPTS}/sid_batches/matlab_job_${TASK}" ]; then
    mkdir -v "${PATH2SCRIPTS}/sid_batches/matlab_job_${TASK}"
fi

# Set processor
# use "slurm" for Talapas
# use "serlocal" for local, serial processing
# use "parlocal" for local, parallel processing

PROCESS=slurm

# Only matters for parlocal
MAXJOBS=8

# Only matters for slurm
cpuspertask=1
mempercpu=3G

# Create and execute batch job
if [ "${PROCESS}" == "slurm" ]; then 
    for SUB in $SUBJLIST
    do
        if [ ! -d "${STUDY}/bids_data/derivatives/prepost_analysis/sub-${SUB}" ]; then
            mkdir -v "${STUDY}/bids_data/derivatives/prepost_analysis/sub-${SUB}"
        fi
        if [ ! -d "${STUDY}/bids_data/derivatives/prepost_analysis/sub-${SUB}/fx" ]; then
            mkdir -v "${STUDY}/bids_data/derivatives/prepost_analysis/sub-${SUB}/fx"
        fi
        if [ ! -d "${STUDY}/bids_data/derivatives/prepost_analysis/sub-${SUB}/fx/${TASK}" ]; then
            mkdir -v "${STUDY}/bids_data/derivatives/prepost_analysis/sub-${SUB}/fx/${TASK}"
        fi
     echo "submitting via slurm"
     sbatch --export=ALL,REPLACESID=$REPLACESID,SCRIPT=$SCRIPT,SUB=$SUB,SPM_PATH=$SPM_PATH,PROCESS=$PROCESS  \
         --job-name=${RESULTS_INFIX} \
         -o "${OUTPUTDIR}"/"${SUB}"_${RESULTS_INFIX}.log \
         --cpus-per-task=${cpuspertask} \
         --mem-per-cpu=${mempercpu} \
         spm_job_${TASK}.sh
     sleep .25
    done
elif [ "${PROCESS}" == "serlocal" ]; then 
    for SUB in $SUBJLIST
    do
     echo "submitting locally"
     bash spm_job_${TASK}.sh ${REPLACESID} ${SCRIPT} ${SUB} > "${OUTPUTDIR}"/"${SUBJ}"_${RESULTS_INFIX}_output.txt 2> /"${OUTPUTDIR}"/"${SUBJ}"_${RESULTS_INFIX}_error.txt
    done
elif [ "${PROCESS}" == "parlocal" ]; then 
    parallel --verbose --results "${OUTPUTDIR}"/{}_${RESULTS_INFIX}_output -j${MAXJOBS} bash spm_job_${TASK}.sh ${REPLACESID} ${SCRIPT} :::: ${SUBJTXT}
fi
