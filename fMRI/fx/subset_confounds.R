# Set working directory
#working_dir = "/projects/sanlab/shared/REV/bids_data/derivatives/fmriprep"
working_dir = "/Users/melmo/Downloads"
setwd(working_dir)

# Get a list of all the confounds.tsv files
confound_pattern = "*confounds*.tsv"
confounds_paths = list.files(working_dir, pattern = confound_pattern, full.names = TRUE, recursive = TRUE)

# Import the confounds.tsv files
for (path in confounds_paths) {
    # Import the confounds.tsv file
    confounds_file <- rio::import(path)
    # Select only the motion paramters of interest
    new_confounds_file <- dplyr::select(confounds_file, c(X, Y, Z, RotX, RotY, RotZ, stdDVARS, FramewiseDisplacement))
    # export to .txt
    new_file_name <- paste0(substr(path, 1, nchar(path) - 3), "txt") 
    write.table(new_confounds_file, new_file_name, sep = "\t", row.names = FALSE, col.names = FALSE)
}