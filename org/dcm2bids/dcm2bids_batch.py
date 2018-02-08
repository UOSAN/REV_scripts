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

# Set directories
currentdir=os.getcwd()
dicomdir="/projects/" + group + "/shared/DICOMS/" + study
archivedir="/projects/" + group + "/shared/" + study + "/archive"
niidir=archivedir + "/clean_nii"
bidsdir="/projects/" + group + "/shared/" + study + "bids_data"

outputlog=currentdir + "/outputlog_nii2bids.txt"
errorlog=currentdir + "/errorlog_nii2bids.txt"

configdir= "/projects/" + group + "/shared/" + study + "/" + study + "_scripts/org/dcm2bids/" 
configfile= configdir + study + "_config.json"
image= "/projects/" + group + "/shared/" + "containers/Dcm2Bids-master.simg"


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
if not os.path.isdir(niidir + "/logs"):
	os.mkdir(niidir + "/logs")

##################################
# DICOM To Nifti Conversion
##################################

# Source the subject list (needs to be in your current working directory)
subjectlist="subject_list_test.txt" 

# Create a function to write files
def touch(path): # make a function: 
    with open(path, 'a'): # open it in append mode, but don't do anything to it yet
        os.utime(path, None) # make the file


# Convert the dicoms of each participant in the subject_list.txt file
with open(subjectlist) as file:
	lines = file.readlines() # set variable name to file and read the lines from the file

# Split the subject list into participant ID and session number
for line in lines:
	entry=line.strip()
	subject=entry.split(",")[0]
	wave=entry.split(",")[1]
	subjectpath=dicomdir+"/"+subject
	if os.path.isdir(subjectpath):
		with open(outputlog, 'a') as logfile:
			logfile.write(subject+os.linesep)
		# Create a job to submit to the HPC with sbatch 
		batch_cmd = 'sbatch --job-name dcm2bids_{subject} --partition=short --time 00:60:00 --mem-per-cpu=2G --cpus-per-task=1 -o {niidir}/logs/{subject}_dcm2bids_output.txt -e {niidir}/logs/{subject}_dcm2bids_error.txt --wrap="singularity run -B {dicomdir} -B {niidir} -B {configdir} {image} -d {subjectpath} -s {wave} -p {subject} -c {configfile} -o {niidir}"'.format(dicomdir=dicomdir,wave=wave,configdir=configdir,configfile=configfile,subject=subject,niidir=niidir,subjectpath=subjectpath,group=group,image=image)
		# Submit the job
		subprocess.call([batch_cmd], shell=True)
	else:
		with open(errorlog, 'a') as logfile:
			logfile.write(subject+os.linesep)
