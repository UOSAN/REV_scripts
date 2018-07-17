#fix_REVtags.m
Write appropriate labels to the `tags` column for the `go/no-go` and `react` tasks to make them consistent for all participants. This script is run after the `data_prep` scripts, prior to the `makeVecs` scripts.   

#makeVecs_MSS_GNG.m
Pull names, onsets, and durations and write them to a `.mat` file for all participants and all runs of the “Go/No-go” task.

#makeVecs_MSS_React.m
Pull names, onsets, and durations and write them to a `.mat` file for all participants and all runs of the “Cue Reactivity” task.  

#matlabbatch.mat

#REV_Fx_Models.mat
1. Unzip the nifti.gz files. 
2. Smooth with a 6mm smoothing kernal. 
3. Create the first level model contrasts. 
4. Apply the first level models, including motion regressors and conditions. 

#subset_confounds.R
1. Read in the confounds.tsv files from the fmriprep output for each subject & timepoint.  
2. Select the `X`, `Y`, `Z`, `RotX`, `RotY`, `RotZ`, `stdDVARS`, & `FramewiseDisplacement` columns.  
3. Write the selected columns to a .txt file and save to the folder from which it was pulled.  