#!/bin/bash
#--------------------------------------------------------------
# Inputs:
#   * STUDY = study name
#   * SUBJLIST = subject_list.txt
#   * SCRIPT = MATLAB script to create and execute batch job
#   * PROCESS = running locally, via qsub, or on the Mac Pro
#   * Edit output and error paths
#
# Outputs:
#   * Executes spm_job.sh for $SUB and $SCRIPT
#
# D.Cos 2017.3.7
#--------------------------------------------------------------


# Set your study
STUDY=tds/tds_repo

# Set subject list
SUBJLIST=`cat subject_list.txt`
#Which SID should be replaced?
REPLACESID='101'

# Set MATLAB script path
COMPNAME=ralph #use this for help specifying paths to run locally
SCRIPT=/projects/sanlab/shared/REV/REV_scripts/fMRI/rx/prepost_analysis/scripts/rx-rev_con-01.m

#SPM Path
SPM_PATH=/projects/sanlab/shared/spm12

# Tag the results files
RESULTS_INFIX=con-01

# Set output dir
OUTPUTDIR=/projects/sanlab/shared/REV/REV_scripts/fMRI/rx/prepost_analysis/con-01

if [ ! -d "${OUTPUTDIR}" ]; then
    mkdir -v "${OUTPUTDIR}"
fi

# Set processor
# use "slurm" for HPC
# use "serlocal" for local, serial processing
# use "parlocal" for local, parallel processing

PROCESS=slurm

#Only matters for parlocal
MAXJOBS=8

#Only matters for slurm
cpuspertask=1
mempercpu=2G

# Create and execute batch job
if [ "${PROCESS}" == "slurm" ]; then 
    echo "submitting via qsub" 
    module load matlab
    sbatch --export=SCRIPT=$SCRIPT,SPM_PATH=$SPM_PATH,PROCESS=$PROCESS  \
         --job-name=${RESULTS_INFIX} \
         -o "${OUTPUTDIR}"/rx-rev_${RESULTS_INFIX}.log \
         --cpus-per-task=${cpuspertask} \
         --mem-per-cpu=${mempercpu} \
         matlab -nosplash -nodisplay -nodesktop "-singleCompThread" -r "clear; addpath('$SPM_PATH'); spm_jobman('initcfg'); script_file='$SCRIPT'; run('rx-rev_con-01.m'); spm_jobman('run',matlabbatch); exit"
     sleep .25
else
    exit
fi
