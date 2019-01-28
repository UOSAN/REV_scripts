#!/bin/bash

MATLABVER=R2018a
SINGLECOREMATLAB=true
ADDITIONALOPTIONS=""

if "$SINGLECOREMATLAB"; then
    ADDITIONALOPTIONS="-singleCompThread"
fi

module load matlab
MATLABCOMMAND=matlab

echo "Running ${SCRIPT}"
date

$MATLABCOMMAND -nosplash -nodisplay -nodesktop ${ADDITIONALOPTIONS} -r "clear; addpath('$SPM_PATH'); spm_jobman('initcfg'); script_file='$SCRIPT'; spm_jobman('run', script_file); exit"
