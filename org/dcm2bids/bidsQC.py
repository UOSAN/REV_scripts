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
logdir=os.getcwd()+"/logs/bidsQC"
niidir="/projects/" + group + "/shared/" + study + "/archive/clean_nii"
tempdir=niidir + "/tmp_dcm2bids"
bidsdir="/projects/" + group + "/shared/" + study + "bids_data"
outputlog=logdir + "/outputlog_bidsQC.txt"
errorlog=logdir + "/errorlog_bidsQC.txt"

# Sequence identifiers

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
# for dirpath, subdirs, files in os.walk(tempdir):
# # For each sequence type in the subdirectory
# 	for subdir in subdirs:
# 		wave=subdir.split("_")[1]
# 	for file in files:
# 		sequenceNumber=file.split("_")[0]
# 		subject=file.split("_")[1]
# 		sequenceName=file.split("_")[3]
# 		with open(outputlog, 'a') as logfile:
# 			logfile.write(subject+"-"+wave+"_"+sequenceNumber+"-"+sequenceName+os.linesep)

	# If there are duplicates of any sequences of interest (task, anat, fmap)
	# Then copy the largest of those files to that participant's BIDS directory
	# Rename that file with BIDS format
	# Print that file to the output log
	# Print the smaller files to an error log

# For each directoriy in the clean_nii directory
# For each subdirectory
for dirpath, subdirs, files in os.walk(niidir):
# For each sequence type in the subdirectory
	for subdir in subdirs:
		directory = subdir.glob.glob("*_*")
		for each in directory:
			print("subdir " + each)
			#if file in files : # has run then
		# retain the last run
		# Print that file to the output log
		# Remove the earlier runs and print them to an error log

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



