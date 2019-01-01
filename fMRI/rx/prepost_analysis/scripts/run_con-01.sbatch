#!/bin/bash

matlab -nosplash -nodisplay -nodesktop  -r "clear; addpath('$SPM_PATH'); spm_jobman('initcfg'); script_file='$SCRIPT'; spm_jobman('run', script_file); exit"
 
