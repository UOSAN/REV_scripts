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

# for dirpath, subdirs, files in os.walk(tempdir):
# # For each sequence type in the subdirectory
# 	for subdir in subdirs:
# 		wave=subdir.split("_")[1]
	for file in files:
		sequenceNumber=file.split("_")[0]
		subject=file.split("_")[1]
		sequenceName=file.split("_")[3]
		with open(outputlog, 'a') as logfile:
			logfile.write(subject+"-"+wave+"_"+sequenceNumber+"-"+sequenceName+os.linesep)

	# If there are duplicates of any sequences of interest (task, anat, fmap)
	# Then copy the largest of those files to that participant's BIDS directory
	# If the files are the same size, check whether they have run-## in their name & if so keep the last run
	# Print that file to the output log
	# Print the smaller files to an error log

# For each directoriy in the clean_nii directory
# For each subdirectory
for dirpath, dirnames, files in os.walk(niidir):
	# for file in files:
	# 	print(file)
# For each sequence type in the subdirectory

# clear variable (last = nothing)
	for dirname in dirnames:
		# print("dirname = " + dirname)
		if dirname == "fmap" or dirname == "anat" or dirname == "func":
			fullpath = dirpath + "/" + dirname
			#print(fullpath)
# check for run string in correct place
			for file in os.listdir(fullpath):
				if file.split("_")[0] != glob.glob("run-[0-9]{2}")
				# and file.split("_")[1] != glob.glob("run-[0-9][0-9]") 
				# and file.split("_")[2] != glob.glob("run-[0-9][0-9]") 
				# and file.split("_")[3] == glob.glob("run-[0-9][0-9]")
				print(file) 


	


	#subdirs = glob.glob(dirpath + "/sub-REV*")
	# for subdir in subdirs:
		# print(subdir)
		# fmap = glob.glob(subdir + "/fmap")
		# anat = glob.glob(subdir + "/anat")
		# func = glob.glob(subdir + "/func")
		# print(fmap)
		# print(anat)
		# print(func)

			#if file in files : # has run then
		# retain the last run
		# Print that file to the output log
		# Remove the earlier runs and print them to an error log

##################################
#  Idiosyncratic Study Renaming
##################################

# Go into tmp_dcm2bids
# move and rename the fmap and mprage files based on date and sequence order


# Within clean_nii
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



