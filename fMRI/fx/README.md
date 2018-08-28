#approxTR.m
Calculate the aproximate number of TRs based on behavioral data. This script doesn't actually work correctly, and we won't be using it. 

#fix_REVtags.m
Write appropriate labels to the `tags` column for the `go/no-go` and `react` tasks to make them consistent for all participants. This script is run after the `data_prep` scripts, prior to the `makeVecs` scripts.   

#makeVecs_MSS_GNG.m
Pull names, onsets, and durations and write them to a `.mat` file for all participants and all runs of the “Go/No-go” task.

#makeVecs_MSS_React.m
Pull names, onsets, and durations and write them to a `.mat` file for all participants and all runs of the “Cue Reactivity” task.  

#subset_confounds.R
1. Read in the confounds.tsv files from the fmriprep output for each subject & timepoint.  
2. Select the `FramewiseDisplacement` column.  
3. Write the selected columns to a .txt file and save to a new output folder in `derivatives`.  