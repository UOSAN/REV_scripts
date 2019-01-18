#!/bin/bash
#--------------------------------------------------------------
# Inputs:
#	* STUDY = study name
#	* SUBJLIST = subject_list.txt
#	* SCRIPT = MATLAB script to create and execute batch job
#	* PROCESS = running locally, via job scheduler, or on the Mac Pro
#	* Edit output and error paths
#
# Outputs:
#	* Executes spm_job.sh for $SUB and $SCRIPT
#
# D.Cos 2017.3.7
#--------------------------------------------------------------

STUDY=/projects/sanlab/shared/REV
SUBJLIST=`cat subject_list_sst.txt`
TASK='sst'
PATH2SCRIPTS=$STUDY/REV_scripts/fMRI/fx/SST/prepost_analysis/flexibleConCreation/scripts/run_spm
REPLACESID='REV001' # Which SID should be replaced?
SCRIPT=${PATH2SCRIPTS}/REV001_adjustedCons_prepost_analysis.m
SPM_PATH=/projects/sanlab/shared/spm12
RESULTS_INFIX=fx_contrasts # Tag the results files


if [ ! -d "${PATH2SCRIPTS}/output_logs" ]; then
    mkdir -v "${PATH2SCRIPTS}/output_logs"
fi
OUTPUTDIR=${PATH2SCRIPTS}/output_logs

# make sid_batch dir if doesn't exist
if [ ! -d "${PATH2SCRIPTS}/sid_batches_cons" ]; then
    mkdir -v "${PATH2SCRIPTS}/sid_batches_cons"
fi

if [ ! -d "${PATH2SCRIPTS}/sid_batches_cons/matlab_job_${TASK}" ]; then
    mkdir -v "${PATH2SCRIPTS}/sid_batches_cons/matlab_job_${TASK}"
fi


PROCESS=slurm
MAXJOBS=8
cpuspertask=1
mempercpu=3G


for SUB in $SUBJLIST
do
 echo "submitting via slurm"
 sbatch --export=ALL,REPLACESID=$REPLACESID,SCRIPT=$SCRIPT,SUB=$SUB,SPM_PATH=$SPM_PATH,PROCESS=$PROCESS  \
	 --job-name=${RESULTS_INFIX} \
	 -o "${OUTPUTDIR}"/"${SUB}"_${RESULTS_INFIX}.log \
	 --cpus-per-task=${cpuspertask} \
	 --mem-per-cpu=${mempercpu} \
	 spm_job_${TASK}.sh
 sleep .25
done
