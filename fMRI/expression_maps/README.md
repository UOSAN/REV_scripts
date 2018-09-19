#expression_maps.sh
This is a bash script that will multiply contrast maps (via dot product multiplication function in AFNI, i.e. 3ddot) that were generated from fx models. This yields .txt files containing scalar values that represent IC Capacity and IC tendency. 
 
#concatenate_expression_maps.R
This R script takes all of the .txt files created by expression_maps.sh, puts them into a single data frame, converts to wide format, and writes out "pattern_response_values.csv".