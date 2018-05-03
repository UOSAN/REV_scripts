import os
from datetime import datetime
import glob
import shutil

bids_dir = os.path.join(os.path.sep,"Users", "kristadestasio", "Desktop", "bids_data")
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
    tempdir = os.path.join(bids_dir, "tmp_dcm2bids")
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
        check_mprages(subject_files, subject, timepoint, subjectdir, subject_fullpath)
        fieldmap_files = get_fieldmap_files(subject_files, subject, timepoint, subjectdir, subject_fullpath)
        magnitude1_files = get_magnitude1_files(fieldmap_files)
        magnitude1_jsons = [f for f in magnitude1_files if f.endswith(".json")]
        magnitude1_numbers = [int(f.split("_")[0]) for f in magnitude1_jsons]
        phasediff_files = get_phasediff_files(fieldmap_files, magnitude1_numbers)
        magnitude2_files = get_magnitude2_files(fieldmap_files, magnitude1_numbers)
        rename_fieldmaps(magnitude1_files, subjectdir, subject_fullpath, "_magnitude1_")
        

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


def check_mprages(subject_files:list, subject:str, timepoint:str, subjectdir:str, subject_fullpath:str):
    """
    """
    mprage_files = [f for f in subject_files if "mprage" in f]
    json_files = [f for f in mprage_files if f.endswith(".json")]
    nifti_files = [f for f in mprage_files if f.endswith(".nii.gz")]
    if len(json_files) == 1:
        write_to_outputlog("One mprage")
        for json_file in json_files:
            rename_mprages(json_file, subjectdir, ".json", subject_fullpath)
        for nifti_file in nifti_files:
            rename_mprages(nifti_file, subjectdir, ".nii.gz", subject_fullpath) 
    elif len(json_files) > 1:
        write_to_outputlog("Multiple mprages")
    else:
        write_to_outputlog("No mprages to fix")


# Rename a single mprage
def rename_mprages(target_file:str, subjectdir:str, extension:str, subject_fullpath:str):
    """
    """
    mprage_filename = subjectdir + "_T1w" + extension
    mprage_fullpath = os.path.join(subject_fullpath, mprage_filename)
    print(mprage_fullpath)
    #shutil.move(target_file, mprage_fullpath)


def get_fieldmap_files(subject_files:list, subject:str, timepoint:str, subjectdir:str, subject_fullpath:str):
    fieldmap_files = [f for f in subject_files if "fieldmap" in f]
    fieldmap_files.sort()
    return fieldmap_files


def get_magnitude1_files(fieldmap_files: list):
    magnitude1_files = [f for f in fieldmap_files if not f.endswith("e2.nii.gz") and not f.endswith( "e2.json")]    
    return magnitude1_files
    

def get_magnitude2_files(fieldmap_files: list, magnitude1_numbers:list):
    magnitude1_prefixes = [str(n) for n in magnitude1_numbers]
    magnitude2_files = [f for f in fieldmap_files if any(f.startswith(p.zfill(3)) for p in magnitude1_prefixes) and not f.endswith("e2.nii.gz") and not f.endswith( "e2.json")]
    return magnitude2_files


def get_phasediff_files(fieldmap_files: list, magnitude1_numbers: list):
    phasediff_prefixes = [str((n + 1)) for n in magnitude1_numbers] 
    phasediff_files = [f for f in fieldmap_files if any(f.startswith(p.zfill(3)) for p in phasediff_prefixes)]
    return phasediff_files
    

def rename_fieldmaps(fieldmap_files:list, subjectdir:str, subject_fullpath:str, suffix:str):
    json_files = [f for f in fieldmap_files if f.endswith(".json")]
    nifti_files = [f for f in fieldmap_files if f.endswith(".nii.gz")]
    if len(json_files) == 1:
        write_to_outputlog("One fieldmap json file to rename")
        for target_file in json_files:
            do_rename_fieldmap(target_file, subjectdir, suffix, ".json", subject_fullpath)
    if len(nifti_files) == 1:
        write_to_outputlog("One fieldmap nifti file to rename")
        for target_file in nifti_files:
            do_rename_fieldmap(target_file, subjectdir, suffix, ".nii.gz", subject_fullpath)
    if len(json_files) > 1:
        # name with run numbers
        for target_file in json_files:
            extension = ".json"
            target_filename = subjectdir + suffix + extension
            if not os.path.isfile(os.path.join(subject_fullpath, target_filename)):
                do_rename_fieldmap(target_file, subjectdir, suffix, extension, subject_fullpath)
            else:
                # start index at 0
                # i + 1 each time a file is found
                # if i = 0, rename without `run-##` 
                # if i >= 1, rename with `run-##
                yield target_file
                prefix, ext = os.path.splitext(target_file)
                for i in itertools.count(start=1, step=1):
                    yield prefix + ' ({0})'.format(i) + ext
                fieldmap_filename = subjectdir + suffix + "_run" + index + "_" + extension
                



def do_rename_fieldmap(target_file:str, subjectdir:str, suffix:str, extension:str, subject_fullpath:str):
    fmap_filename = subjectdir + suffix + extension
    fmap_fullpath = os.path.join(subject_fullpath, fmap_filename)
    print(target_file + " " + fmap_fullpath)
    #shutil.move(target_file, fmap_fullpath)

# 014_REV001_20150406_fieldmap_20150406145550_e2.json
# 014_REV001_20150406_fieldmap_20150406145550_e2.nii.gz
# 014_REV001_20150406_fieldmap_20150406145550.json
# 014_REV001_20150406_fieldmap_20150406145550.nii.gz
# 015_REV001_20150406_fieldmap_20150406145550_e2.json
# 015_REV001_20150406_fieldmap_20150406145550_e2.nii.gz


# old: 015_REV001_20150406_fieldmap_20150406145550_e2.nii.gz
# target: sub-REV001_ses-wave2_run-01_magnitude1.nii.gz

# sub-REV001_ses-wave1/015_REV001_20150406_fieldmap_20150406145550_e2.nii.gz
# sub-REV001_ses-wave2_run-02_phasediff.nii.gz 

# higher sequence number is phasediff
# with e2 has "EchoTime": 0.00683 = magnitude2
# without e2 "EchoTime": 0.00437 = magnitude1


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