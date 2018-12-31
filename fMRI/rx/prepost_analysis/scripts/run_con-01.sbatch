#!/bin/bash

matlab -nosplash -nodisplay -nodesktop "-singleCompThread" -r "clear; addpath('$SPM_PATH'); spm('defaults','fmri'); spm_jobman('initcfg'); script_file='$SCRIPT'; spm_jobman('run',matlabbatch); exit"
 
