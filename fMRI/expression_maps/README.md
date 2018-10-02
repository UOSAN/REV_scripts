#expression_maps_loop.sh
This is a bash script that will multiply contrast maps (via dot product multiplication function in AFNI, i.e. 3ddot) that were generated from fx models. This yields .txt files containing scalar values that represent IC Capacity and IC tendency. Note that the list of subjects is hard-coded in this script, and the script is looped through each subject ID.
 
#concatenate_expression_maps.R
This R script takes all of the .txt files created by expression_maps.sh, puts them into a single data frame, converts to wide format, and writes out "pattern_response_values.csv".

NOTE: Do not use batch_expression_maps.sh, expression_maps.sh, or expression_maps_subject_list.sh. These are not working correctly because the subject list is not being read in correctly. 