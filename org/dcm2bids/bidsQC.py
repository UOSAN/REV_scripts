##################################
#  Setup
##################################

# Import libraries
import os
import glob

# Set study info (change these for your study)
group="sanlab"
study="REV"

# Set directories
logdir=os.getcwd()+"/logs"
niidir="/projects/" + group + "/shared/" + study + "/archive/clean_nii"
tempdir=niidir + "/tmp_dcm2bids"
bidsdir="/projects/" + group + "/shared/" + study + "bids_data"
outputlog=logdir + "/outputlog_bidsQC.txt"
errorlog=logdir + "/errorlog_bidsQC.txt"

### SET THIS ###
derivatives=bidsdir + "/derivatives"

# Define a function to create files
def touch(path):
	with open(path, 'a'):
		os.utime(path, None)

# Check and create directories
if not os.path.isdir(bidsdir):
	os.mkdir(bidsdir)
if not os.path.isdir(derivatives):
	os.mkdir(derivatives)	
if not os.path.isdir(logdir):
	os.mkdir(logdir)

# Check/create log files
if not os.path.isfile(outputlog):
	touch(outputlog)
if not os.path.isfile(errorlog):
	touch(errorlog)

##################################
#  Standard Options
##################################

# For each directoriy in the temp directory
# For each subdirectory
for dirpath, dirnames, files in os.walk(tempdir):
# For each sequence type in the subdirectory
	for file in files:
		with open(outputlog, 'a') as logfile:
			logfile.write(os.path.join(dirpath, file))
	# If there are duplicates of any sequences of interest (task, anat, fmap)
	# Then copy the largest of those files to that participant's BIDS directory
	# Rename that file with BIDS format
	# Print that file to the output log
	# Print the smaller files to an error log


##################################
#  Idiosyncratic Study Renaming
##################################

# Fix incorrect sequence names

# Fix incorrect participant IDs

# Move the files into the subject directories



##################################
#  Populate BIDS Directory
##################################

# Copy all directories from the clean_nii folder to bids_data



##################################
#  Cleanup
##################################

# Remove tmp_dcm2bids directory and its contents



