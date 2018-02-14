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
logdir=os.getcwd()+"/logs_bidsQC"
niidir="/projects/" + group + "/shared/" + study + "/archive/clean_nii"
bidsdir="/projects/" + group + "/shared/" + study + "bids_data"
outputlog=logdir + "/outputlog_bidsQC.txt"
errorlog=logdir + "/errorlog_bidsQC.txt"
derivatives=bidsdir + "/derivatives"

subjectlist="subject_list.txt" 


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
#  Get File Info
##################################


# For each sequence type in the subdirectory
os.chdir(niidir)
for filename in glob.glob('*REV*.nii*'):
	sequence_number=filename.split("_")[0]
	subject=filename.split("_")[1]
	scan_date=filename.split("_")[2]
	sequence_name=filename.split("_")[3]

# Get info about which files belong to which wave from the subject_list.txt
with open(subjectlist) as file:
	lines = file.readlines()
for line in lines:
	entry=line.strip()
	subject_identifier=entry.split(",")[0]
	wave=entry.split(",")[1]

##################################
#  Standard Options
##################################

	# If there are duplicates of any sequences of interest (task, anat, fmap)
	# Then copy the largest of those files to that participant's BIDS directory
	# Rename that file with BIDS format
	# Print that file to the output log
	# Print the smaller files to an error log

# For each subject directoriy in the clean_nii directory
		#for filename in filenames:
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



