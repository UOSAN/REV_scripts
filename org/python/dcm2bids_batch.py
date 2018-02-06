# This script will convert all of the dicoms in the sourcedir 
# for participant directories that are listed in the subject_list.txt file.
# Niftis will be renamed and put into BIDS structure using the dcm2Bids package
# 
# See the dcm2Bids repo for instructions to create the config file
# < link to dcm2Bids >
# < link to more detailed instructions on san wiki >
#
# In your current directory, you will need:
#		- nii2bids_batch.py
#		- subject_list.txt
#		- the study config file (e.g. REV_config.json) (actually, maybe this will be in the container?)
#


##################################
# Setup
##################################

# Import libraries
import os
import glob
import subprocess 

# Set study info (change these for your study)
group="sanlab"
study="REV"
subid=glob.glob('REV[0-9][0-9[0-9]')

# Set directories
currentdir=os.getcwd()
dicomdir="/projects/" + group + "/shared/DICOMS/" + study
archivedir="/projects/" + group + "/shared/" + study + "/archive"
niidir=archivedir + "/clean_nii"
bidsdir="/projects/" + group + "/shared/" + study + "bids_data"

outputlog=currentdir + "/outputlog_nii2bids.txt"
errorlog=currentdir + "/errorlog_nii2bids.txt"
#######################
#######################
# NEED TO CREATE THESE
configfile= currentdir + group"_config.json"
wave=
#######################
#######################

# Create log files
## Define a function to create files
def touch(path):
	with open(path, 'a'):
		os.utime(path, None)

## Check/create log files
if not os.path.isfile(outputlog):
	touch(outputlog)
if not os.path.isfile(errorlog):
	touch(errorlog)

# Check directory dependencies
if not os.path.isdir(dicomdir):
	print("Incorrect dicom directory specified")
if not os.path.isdir(niidir):
	print("Incorrect nifti directory specified")
if not os.path.isdir(archivedir):
	print("Incorrect archive directory specified")
if not os.path.isdir(bidsdir):
	os.mkdir(bidsdir)
if not os.path.isdir(bidsdir + "/derivatives"):
	os.mkdir(bidsdir + "/derivatives")	

##################################
# DICOM To Nifti Conversion
##################################

# Source the subject list (needs to be in your current working directory)
subjectlist="subject_list.txt" 

# Create a function to write files
def touch(path): # make a function: 
    with open(path, 'a'): # open it in append mode, but don't do anything to it yet
        os.utime(path, None) # make the file


# If the subid appears once
	# then assign that directory to wave1
 
# If the subid appears twice
	# then assign the directory with earlier date to wave1 and the later date to wave2
# If the subid appears thrice
	# then assign the directory with earliest date to wave1, the directory with the second date to wave2, and the third date to wave2
# else, print an error to the error log





# Convert the dicoms of each participant in the subject_list.txt file
with open(subjectlist) as file:
	lines = file.readlines() # set variable name to file and read the lines from the file

for line in lines:
	subject=line.strip()
	subjectpath=dicomdir+"/"+subject
	if os.path.isdir(subjectpath):
		with open(outputlog, 'a') as logfile:
			logfile.write(subject+os.linesep)
		# Create a job to submit to the HPC with sbatch 
		batch_cmd = 'sbatch --job-name dcm2bids_{subject} --partition=short --time 00:60:00 --mem-per-cpu=2G --cpus-per-task=1 -o {niidir}/{subject}_dcm2bids_output.txt -e {niidir}/{subject}_dcm2bids_error.txt --wrap="singulariy exec dcm2bids.img dcm2bids -d {subjectpath} -s {wave} -p {subject} -c {configfile}"'.format(wave=wave,configfile=configfile,subject=subject,niidir=niidir,subjectpath=subjectpath,group=group)
		# Submit the job
		subprocess.call([batch_cmd], shell=True)
	else:
		with open(errorlog, 'a') as logfile:
			logfile.write(subject+os.linesep)

##################################
# BIDS-ification
##################################

# Code example for my sanity, iteratively printing items in a list
>>> x=["a", "bunch", "of", "words"]
>>> i=0
>>> while i<len(x):
...     print(x[i])
...     i=i+1
... 

