import os
from datetime import datetime
import glob

bids_dir = os.path.join(os.path.sep,"Users", "kristadestasio", "Desktop", "bids_data")
tempdir = os.path.join(bids_dir, "tmp_dcm2bids")
outputlog = os.path.join(bids_dir, "outputlog_bidsQC" + datetime.now().strftime("%Y%m%d-%H%M%S") + ".txt")
errorlog = os.path.join(bids_dir, "errorlog_bidsQC" + datetime.now().strftime("%Y%m%d-%H%M%S") + ".txt")

def main():
    """
    Run the things.
    """
    # group = "sanlab"
    # study = "REV"
    # logdir = os.path.join(os.getcwd(), "logs_rename")
    # bidsdir = os.path.join(os.sep, "projects", group, "shared", study, "bids_data")
    # tempdir = os.path.join(bidsdir, "tmp_dcm2bids") # contains subject directories
    logfile_fullpaths = outputlog, errorlog
    create_logfiles(logfile_fullpaths)
    subjectdirs = get_subjectdirs(tempdir)
    for subjectdir in subjectdirs:
        subject_fullpath = os.path.join(tempdir, subjectdir)
        subject_files = get_subjectfiles(subject_fullpath)
        subject = subjectdir.split("_")[0]
        timepoint = subjectdir.split("_")[1]
        write_to_outputlog("\n" + "-"*20 + "\n" + subject)
        write_to_outputlog("\n    " + timepoint + "\n")
        rename_anatfiles(subject_files, subject, timepoint)


def get_subjectdirs(tempdir: str) -> list:
    """
    Get a list of the directories that contain files to check.

    @type tempdir:          string
    @param tempdir:         Full path to the directory that holds the subject directories.
    """
    subjectdirs = os.listdir(tempdir)
    return [f for f in subjectdirs if not f.startswith('.') and f.startswith("sub")]
    

def get_subjectfiles(subject_fullpath:str) -> list:
    """
    Get a list of all the files in a subject directory.

    @type subject_fullpath:         string
    @param subject_fullpath:        The full path to a subject directory
    """
    subject_files = os.listdir(subject_fullpath)
    return [ f for f in subject_files]


def rename_anatfiles(subject_files:list, subject:str, timepoint:str):
    """

    """
    mprage_files = [f for f in subject_files if "mprage" in f]
    json_files = [f for f in mprage_files if f.endswith(".json")]
    nifti_files = [f for f in mprage_files if f.endswith(".nii") or f.endswith(".nii.gz")]
    if len(json_files) == 1:
        write_to_outputlog("One mprage")
        rename_mprage(mprage_files)
    elif len(json_files) > 1:
        write_to_outputlog("Multiple mprages")
    else:
        write_to_outputlog("No mprages to fix")
        
# Rename a single mprage
def rename_mprage(mprage_files:list):
    """
    """
    for mprage_file in mprage_files:
        print(mprage_file)
        
# Bad: 009_REV001_20150406_mprage_MGH_p2_20150406145550.json
# Goal: sub-REV001_ses-wave2_T1w.json


# Define a function to create files
def touch(path:str):
    """
    Create a new file
    
    @type path:             string
    @param path:            path to - including name of - file to be created
    """
    with open(path, 'a'):
        os.utime(path, None)

# Create logs
def create_logfiles(logfile_fullpaths:list):
    """
    Check if a logfile exists. If not, make one.

    @type logfile_fullpaths:         list
    @param logfile_fullpaths:        Paths to logfiles to check
    """
    for logfile_fullpath in logfile_fullpaths:
        if not os.path.isfile(logfile_fullpath):
            touch(logfile_fullpath)

# Functions to write to log files
def write_to_outputlog(message):
    """
    Write a log message to the output log. Also print it to the terminal.

    @type message:          string
    @param message:         Message to be printed to the log
    """
    with open(outputlog, 'a') as logfile:
        logfile.write(message + os.linesep)
    print(message)

def write_to_errorlog(message):
    """
    Write a log message to the error log. Also print it to the terminal.

    @type message:          string
    @param message:         Message to be printed to the log
    """
    with open(errorlog, 'a') as logfile:
        logfile.write(message + os.linesep)
    print(message)
main()


# sub-REV001_ses-wave1/015_REV001_20150406_fieldmap_20150406145550_e2.nii.gz
# sub-REV001_ses-wave2_run-02_phasediff.nii.gz 

# higher sequence number is phasediff
# with e2 has "EchoTime": 0.00683 = magnitude2
# without e2 "EchoTime": 0.00437 = magnitude1
# 
#     
        #                 {
        #     "dataType": "fmap",
        #     "modalityLabel": "phasediff",
        #     "customLabels": "",
        #     "criteria": {
        #         "ProtocolName": "fieldmap",
        #         "ImageType": "P"
        #     }
        # },
        # {
        #     "dataType": "fmap",
        #     "modalityLabel": "magnitude2",
        #     "customLabels": "",
        #     "criteria": {
        #         "ProtocolName": "fieldmap",
        #         "EchoNumber": 2,
        #         "EchoTime": 0.00683,
        #         "ImageType": "M"
        #     }
        # },
        # {
        #     "dataType": "fmap",
        #     "modalityLabel": "magnitude1",
        #     "customLabels": "",
        #     "criteria": {
        #         "ProtocolName": "fieldmap",
        #         "EchoTime": 0.00437,
        #         "ImageType": "M"
        



# 006_REV001_20150406_fieldmap_20150406145550_e1.json
# 006_REV001_20150406_fieldmap_20150406145550_e1.nii.gz
# 006_REV001_20150406_fieldmap_20150406145550_e2.json
# 006_REV001_20150406_fieldmap_20150406145550_e2.nii.gz
# 007_REV001_20150406_fieldmap_20150406145550_e2.json
# 007_REV001_20150406_fieldmap_20150406145550_e2.nii.gz
# 009_REV001_20150406_mprage_MGH_p2_20150406145550.json
# 009_REV001_20150406_mprage_MGH_p2_20150406145550.nii.gz
# 014_REV001_20150406_fieldmap_20150406145550_e2.json
# 014_REV001_20150406_fieldmap_20150406145550_e2.nii.gz
# 014_REV001_20150406_fieldmap_20150406145550.json
# 014_REV001_20150406_fieldmap_20150406145550.nii.gz
# 015_REV001_20150406_fieldmap_20150406145550_e2.json
# 015_REV001_20150406_fieldmap_20150406145550_e2.nii.gz