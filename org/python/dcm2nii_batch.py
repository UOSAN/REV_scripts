# This script will convert all of the dicoms in the sourcedir 
# for participant directories that are listed in the subject_list.txt file.
#
# Link to dcm2niix wiki https://www.nitrc.org/plugins/mwiki/index.php/dcm2nii:MainPage

# Import modules
import os
import subprocess 

# Change these for your study
group="sanlab"
study="REV"

# Set paths
archivedir="/projects/" + group + "/shared/" + study + "/archive"
dicomdir="/projects/" + group + "/shared/DICOMS/" + study
niidir=archivedir + "/clean_nii"
outputlog=niidir + "/outputlog_dcm2nii.txt"
errorlog=niidir + "/errorlog_dcm2nii.txt"
dcm2niix="/projects/" + group + "/shared/dcm2niix/build/bin/dcm2niix"

# Source the subject list (needs to be in your current working directory)
subjectlist="subject_list.txt" 

# Create a function to write files
def touch(path): # make a function: 
    with open(path, 'a'): # open it in append mode, but don't do anything to it yet
        os.utime(path, None) # make the file

# Check/create the log files
if not os.path.isfile(outputlog): # if the file does not exist...
	touch(outputlog)
if not os.path.isfile(errorlog):
	touch(errorlog)

# Convert the dicoms
with open(subjectlist) as file:
	lines = file.readlines() # set variable name to file and read the lines from the file

for line in lines:
	subject=line.strip()
	subjectpath=dicomdir+"/"+subject
	if os.path.isdir(subjectpath):
		with open(outputlog, 'a') as logfile:
			logfile.write(subject+os.linesep)
		# Create a job to submit to the HPC with sbatch 
		batch_cmd = 'sbatch --job-name dcm2nii_{subject} --partition=short --time 00:60:00 --mem-per-cpu=2G --cpus-per-task=1 -o {niidir}/{subject}_dcm2nii_output.txt -e {niidir}/{subject}_dcm2nii_error.txt --wrap="/projects/{group}/shared/dcm2niix/build/bin/dcm2niix -o {niidir} {subjectpath}"'.format(subject=subject,niidir=niidir,subjectpath=subjectpath,group=group)
		# Submit the job
		subprocess.call([batch_cmd], shell=True)
	else:
		with open(errorlog, 'a') as logfile:
			logfile.write(subject+os.linesep)
