#!/bin/bash
 
matlab -nosplash -nodisplay -nodesktop "-singleCompThread" -r "clear; addpath('$SPM_PATH'); script_file='$SCRIPT'; spm_jobman('run',matlabbatch); exit"
