#!/bin/bash

matlab -nosplash -nodisplay -nodesktop  -r "clear; addpath('$SPM_PATH'); spm_jobman('initcfg'); script_file='$SCRIPT'; load script_file; spm_jobman('run', matlabbatch); exit"
 
