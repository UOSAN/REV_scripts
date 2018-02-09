##################################
#  Setup
##################################

# Import libraries
import os

# Set study info (change these for your study)
group="sanlab"
study="REV"

# Set directories
currentdir=os.getcwd()
niidir="/projects/" + group + "/shared/" + study + "/archive/clean_nii"
tempdir=niidir + "/tmp_dcm2bids"
bidsdir="/projects/" + group + "/shared/" + study + "bids_data"

outputlog=currentdir + "/outputlog_bidsQC.txt"
errorlog=currentdir + "/errorlog_bidsQC.txt"

# Define a function to create files
def touch(path):
	with open(path, 'a'):
		os.utime(path, None)

# Check/create log files
if not os.path.isfile(outputlog):
	touch(outputlog)
if not os.path.isfile(errorlog):
	touch(errorlog)

##################################
#  Standard Options
##################################

# Create a list of subjects in the temp directory

# Print a list of files in the error log

# Copy the largest file



##################################
#  Idiosyncratic Study Renaming
##################################

# Fix incorrect sequence names

# Fix incorrect participant IDs



##################################
#  Populate BIDS Directory
##################################

# Copy all directories from the clean_nii folder to bids_data



##################################
#  Cleanup
##################################

# Remove tmp_dcm2bids directory and its contents



