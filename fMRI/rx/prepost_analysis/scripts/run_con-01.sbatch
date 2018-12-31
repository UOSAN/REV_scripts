#!/bin/bash
 
matlab -nosplash -nodisplay -nodesktop "-singleCompThread" -r "clear; addpath('$SPM_PATH'); spm_jobman('initcfg'); script_file='$SCRIPT'; run('rx-rev_con-01.m'); spm_jobman('run',matlabbatch); exit"
