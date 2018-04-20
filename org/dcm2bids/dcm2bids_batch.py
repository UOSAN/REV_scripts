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
#       - dcm2bids_batch.py
#       - subject_list.txt
#       - the study config file (e.g. REV_config.json)


##################################
# Setup
##################################

# Import libraries and configuration file
import os
import subprocess
import config_dcm2bids_batch as cfg

##################################
# Directory Check & Log Creation
##################################

# Define a function to create files
def touch(path):
    """Create a new file"""
    with open(path, 'a'):
        os.utime(path, None)


# Check/create log files and directories
if not os.path.isdir(cfg.logdir):
    os.mkdir(cfg.logdir)
if not os.path.isfile(cfg.outputlog):
    touch(cfg.outputlog)
if not os.path.isfile(cfg.errorlog):
    touch(cfg.errorlog)

# Check directory dependencies
if not os.path.isdir(cfg.niidir):
    os.mkdir(cfg.niidir)
if not os.path.isdir(cfg.dicomdir):
    with open(cfg.errorlog, 'a') as logfile:
        logfile.write("Incorrect dicom directory specified")

# Main script

def main():
    with open(cfg.subjectlist) as file: 
        lines = file.readlines()
    for line in lines:
        entry = line.strip()
        subjectdir = entry.split(",")[0]
        subject = entry.split(",")[1]
        wave = entry.split(",")[2]
        subjectpath = os.path.join(cfg.dicomdir, subjectdir)
        if os.path.isdir(subjectpath):
            with open(cfg.outputlog, 'a') as logfile:
                logfile.write(subjectdir + os.linesep)
            # Create a job to submit to the HPC with sbatch
            batch_cmd = 'module load singularity; sbatch --job-name dcm2bids_{subjectdir} --partition=short --time 00:60:00 --mem-per-cpu=2G --cpus-per-task=1 -o {logdir}/{subjectdir}_dcm2bids_output.txt -e {logdir}/{subjectdir}_dcm2bids_error.txt --wrap="singularity run -B {dicomdir} -B {niidir} -B {codedir} {image} -d {subjectpath} -s {wave} -p {subject} -c {configfile} -o {niidir}  --forceDcm2niix --clobber"'.format(logdir=cfg.logdir, subjectdir=subjectdir, dicomdir=cfg.dicomdir, wave=wave, codedir=cfg.codedir, configfile=cfg.configfile, subject=subject, niidir=cfg.niidir, subjectpath=subjectpath, group=cfg.group, image=cfg.image)
            # Submit the job
            subprocess.call([batch_cmd], shell=True)
        else:
            with open(cfg.errorlog, 'a') as logfile:
                logfile.write(subjectdir + os.linesep)
        change_permissions_recursive(cfg.logdir, 0o777)
        change_permissions_recursive(cfg.niidir, 0o777)


# Function to change permissions
def change_permissions_recursive(path, mode):
    for root, dirs, files in os.walk(path, topdown=False):
        for dir in [os.path.join(root,d) for d in dirs]:
            os.chmod(dir, mode)
    for file in [os.path.join(root, f) for f in files]:
            os.chmod(file, mode)

# Call main
main()
