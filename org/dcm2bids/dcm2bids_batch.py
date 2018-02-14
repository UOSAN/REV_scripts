# This script will convert all of the dicoms in the sourcedir 
# for participant directories that are listed in the subject_list.txt file.
# Niftis will be renamed and put into BIDS structure using the dcm2Bids package
# 
# See the dcm2Bids repo for instructions to create the config file:
# https://github.com/cbedetti/Dcm2Bids
#
# More detailed instructions on san wiki: 
# https://uosanlab.atlassian.net/wiki/spaces/SW/pages/44269646/Convert+DICOM+to+BIDS
#
# In your current directory, you will need:
#		- nii2bids_batch.py
#		- subject_list.txt
#		- the study config file (e.g. REV_config.json) (actually, maybe this will be in the container?)


##################################
# Setup
##################################

# Import libraries
import os
import subprocess 

# Set study info (change these for your study)
group="sanlab"
study="REV"

# Set directories
logdir=os.getcwd()+"/logs_dcm2bids"
dicomdir="/projects/lcni/dcm/" + group + "/Archive/" + study
archivedir="/projects/" + group + "/shared/" + study + "/archive"
niidir=archivedir + "/clean_nii"
codedir= "/projects/" + group + "/shared/" + study + "/" + study + "_scripts/org/dcm2bids/" # Contains subject_list.txt, config file, and dcm2bids_batch.py
configfile= codedir + study + "_config.json" # path to and name of config file
image= "/projects/" + group + "/shared/containers/Dcm2Bids-master.simg"

outputlog=logdir + "/outputlog_nii2bids.txt"
errorlog=logdir + "/errorlog_nii2bids.txt"

# Source the subject list (needs to be in your current working directory)
subjectlist="subject_list.txt" 

##################################
# Directory Check & Log Creation
##################################

# Create log files
## Define a function to create files
def touch(path):
	with open(path, 'a'):
		os.utime(path, None)

## Check/create log files
if not os.path.isdir(logdir):
	os.mkdir(logdir)
if not os.path.isfile(outputlog):
	touch(outputlog)
if not os.path.isfile(errorlog):
	touch(errorlog)

# Check directory dependencies
if not os.path.isdir(niidir):
	touch(niidir)
if not os.path.isdir(dicomdir):
	with open(errorlog, 'a') as logfile:
			logfile.write("Incorrect dicom directory specified")
if not os.path.isdir(archivedir):
		with open(errorlog, 'a') as logfile:
			logfile.write("Incorrect archive directory specified")

##################################
# DICOM To BIDS Conversion
##################################

# Convert the dicoms of each participant in the subject_list.txt file
with open(subjectlist) as file:
	lines = file.readlines() # set variable name to file and read the lines from the file

# Split the subject list into participant ID and session number
for line in lines:
	entry=line.strip()
	subjectdir=entry.split(",")[0]
	subject=subjectdir.split("_")[0]
	wave=entry.split(",")[1]
	subjectpath=dicomdir+"/"+subjectdir
	if os.path.isdir(subjectpath):
		with open(outputlog, 'a') as logfile:
			logfile.write(subjectdir+os.linesep)
		# Create a job to submit to the HPC with sbatch 
		batch_cmd = 'module load singularity; sbatch --job-name dcm2bids_{subjectdir} --partition=short --time 00:60:00 --mem-per-cpu=2G --cpus-per-task=1 -o {logdir}/{subjectdir}_dcm2bids_output.txt -e {logdir}/{subjectdir}_dcm2bids_error.txt --wrap="singularity run -B {dicomdir} -B {niidir} -B {codedir} {image} -d {subjectpath} -s {wave} -p {subject} -c {configfile} -o {niidir}  --forceDcm2niix --clobber"'.format(logdir=logdir,subjectdir=subjectdir,dicomdir=dicomdir,wave=wave,codedir=codedir,configfile=configfile,subject=subject,niidir=niidir,subjectpath=subjectpath,group=group,image=image)
		# Submit the job
		subprocess.call([batch_cmd], shell=True)
	else:
		with open(errorlog, 'a') as logfile:
			logfile.write(subjectdir+os.linesep)
