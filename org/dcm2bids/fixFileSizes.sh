# Replace wrong-sized bids_data files with correct-sized tmp files

# Get list of full file paths for tmp files and bids files

# repopath="/Users/brendancullen/Desktop/REV/REV_scripts/org/dcm2bids"
repopath="/projects/sanlab/shared/REV/REV_scripts/org/dcm2bids"
bids_paths=`cat $repopath/file_size_bids_paths.txt`
tmp_paths=`cat $repopath/file_size_tmp_paths.txt`
bids_files=`cat $repopath/file_size_bids_files.txt`
tmp_files=`cat $repopath/file_size_tmp_files.txt`


# Move all the files to a 'purgatory' folder 
## for each file in bids_files, move file to new directory called "purgatory"

# For each file in purgatory, chop the file name (using string split) to exlcude the run number and add wild card, e.g. REV003_ses-wave1_task-gng_acq-1*.nii.gz
## save a list of these wild card names

# cd into bids_data folder 

# for each wild card name, search recursively through bids_data folder, get the bids_data file name, replace the file in purgatory folder with this file name, then move the bids_data file into `tmp_dcm2bids`

# for each re-named purgatory file, move the file to bids_path folder


## GENERAL NOTE: MAKE SURE YOU CHECK THE NOTES IN THE FOLLOWING GOOGLE SHEET TO MAKE SURE YOU ACCOUNT FOR THE FEW CASES THAT WERE MISNAMED
# https://docs.google.com/spreadsheets/d/1AXgCxuoqd-vQo6LJVRDfbUmjEf0OQpV3eZ5AXC9pkNM/edit#gid=0