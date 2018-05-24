# Janky single use script for REV. Run after dcm2bids, before bidsQC.
# This will only work once because magnitude2 and phasediff files are identified by relation to magnitude1 images.
# For the same reason, it also will not work if the magnitude1 images are missing.

# higher sequence number is phasediff
# with e2 has "EchoTime": 0.00683 = magnitude2
# without e2 "EchoTime": 0.00437 = magnitude1

import os
from datetime import datetime
import shutil


group = "sanlab"
study = "REV"
bidsdir = os.path.join(os.sep, "projects", group, "shared", study, "bids_data")
logdir = os.path.join(os.sep, "projects", group, "shared", study, "REV_scripts", "org", "dcm2bids", "logs_rename")
outputlog = os.path.join(logdir, "outputlog_rename_" + datetime.now().strftime("%Y%m%d-%H%M") + ".txt")
errorlog = os.path.join(logdir, "errorlog_rename_" + datetime.now().strftime("%Y%m%d-%H%M") + ".txt")


def main():
    """
    Run the things.
    """    
    tempdir = os.path.join(bidsdir, "tmp_dcm2bids") # contains subject directories
    check = logdir, bidsdir
    check_dirs(check)
    logfile_fullpaths = errorlog, outputlog
    create_logfiles(logfile_fullpaths)
    subjectdirs = get_subjectdirs(tempdir)
    for subjectdir in subjectdirs:
        subject_fullpath = os.path.join(tempdir, subjectdir)
        subject_files = get_subjectfiles(subject_fullpath)
        subject = subjectdir.split("_")[0]
        timepoint = subjectdir.split("_")[1]
        dirs_tocheck = os.path.join(bidsdir, subject), os.path.join(bidsdir, subject, timepoint), os.path.join(bidsdir, subject), os.path.join(bidsdir, subject, timepoint, "anat"), os.path.join(bidsdir, subject, timepoint, "fmap"), os.path.join(bidsdir, subject, timepoint, "func")
        check_dirs(dirs_tocheck)
        write_to_outputlog("\n" + "-"*20 + "\n" + subject)
        write_to_outputlog("\n    " + timepoint + "\n")
        write_to_errorlog("\n" + "-"*20 + "\n" + subject)
        write_to_errorlog("\n    " + timepoint + "\n")
        json_extension = ".json"
        nifti_extension = ".nii.gz"
        fieldmap_files = get_fieldmap_files(subject_files)
        magnitude1_files = get_magnitude1_files(fieldmap_files)
        magnitude1_jsons = [f for f in magnitude1_files if f.endswith(json_extension)]
        magnitude1_numbers = [int(f.split("_")[0]) for f in magnitude1_jsons]
        phasediff_files = get_phasediff_files(fieldmap_files, magnitude1_numbers)
        magnitude2_files = get_magnitude2_files(fieldmap_files, magnitude1_numbers)
        mprage_files = get_mprage_files(subject_files)
        rename_bidsify_files([f for f in magnitude1_files if f.endswith(json_extension)], subjectdir, subject_fullpath, "_magnitude1", json_extension, "fmap", subject, timepoint)
        rename_bidsify_files([f for f in magnitude1_files if f.endswith(nifti_extension)], subjectdir, subject_fullpath, "_magnitude1", nifti_extension, "fmap", subject, timepoint)
        rename_bidsify_files([f for f in magnitude2_files if f.endswith(json_extension)], subjectdir, subject_fullpath, "_magnitude2", json_extension, "fmap", subject, timepoint)
        rename_bidsify_files([f for f in magnitude2_files if f.endswith(nifti_extension)], subjectdir, subject_fullpath, "_magnitude2", nifti_extension, "fmap", subject, timepoint)
        rename_bidsify_files([f for f in phasediff_files if f.endswith(json_extension)], subjectdir, subject_fullpath, "_phasediff", json_extension, "fmap", subject, timepoint)
        rename_bidsify_files([f for f in phasediff_files if f.endswith(nifti_extension)], subjectdir, subject_fullpath, "_phasediff", nifti_extension, "fmap", subject, timepoint)
        rename_bidsify_files([f for f in mprage_files if f.endswith(json_extension)], subjectdir, subject_fullpath, "_T1w", json_extension, "anat", subject, timepoint)
        rename_bidsify_files([f for f in mprage_files if f.endswith(nifti_extension)], subjectdir, subject_fullpath, "_T1w", nifti_extension, "anat", subject, timepoint)


def check_dirs(dir_fullpaths:list):
    """
    Check if a directory exists. If not, create it.

    @type dir_fullpaths:        list
    @param dir_fullpaths:       Paths to directorys to check
    """
    for dir_fullpath in dir_fullpaths:
        if not os.path.isdir(dir_fullpath):
            os.mkdir(dir_fullpath)


def create_logfiles(logfile_fullpaths:list):
    """
    Check if a logfile exists. If not, make one.

    @type logfile_fullpaths:         list
    @param logfile_fullpaths:        Paths to logfiles to check
    """
    for logfile_fullpath in logfile_fullpaths:
        if not os.path.isfile(logfile_fullpath):
            touch(logfile_fullpath)


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


def get_mprage_files(subject_files:list):
    """
    """
    mprage_files = [f for f in subject_files if "mprage" in f]
    return mprage_files


def get_fieldmap_files(subject_files:list):
    fieldmap_files = [f for f in subject_files if "fieldmap" in f]
    fieldmap_files.sort()
    return fieldmap_files


def get_magnitude1_files(fieldmap_files: list):
    magnitude1_files = [f for f in fieldmap_files if not f.endswith("e2.nii.gz") and not f.endswith( "e2.json")]    
    return magnitude1_files
    

def get_magnitude2_files(fieldmap_files: list, magnitude1_numbers:list):
    magnitude1_prefixes = [str(n) for n in magnitude1_numbers]
    magnitude2_files = [f for f in fieldmap_files if any(f.startswith(p.zfill(3)) for p in magnitude1_prefixes)]
    return magnitude2_files


def get_phasediff_files(fieldmap_files: list, magnitude1_numbers: list):
    phasediff_prefixes = [str((n + 1)) for n in magnitude1_numbers] 
    phasediff_files = [f for f in fieldmap_files if any(f.startswith(p.zfill(3)) for p in phasediff_prefixes)]
    return phasediff_files


def rename_bidsify_files(target_files:list, subjectdir:str, subject_fullpath:str, suffix:str, extension:str, sequence_type:str, subject:str, timepoint:str):
    if len(target_files) == 1:
        write_to_outputlog("One %s %s %s file to rename" % (sequence_type, suffix, extension))
        for target_file in target_files:
            if os.path.isfile(os.path.join(subject_fullpath, target_file)):
                rename_move_file(target_file, subjectdir, suffix, extension, subject_fullpath, subject, timepoint, sequence_type)
            else:
                write_to_errorlog("WARNING: %s %s %s does not exist" % (sequence_type, suffix, extension))
    elif len(target_files) > 1:
        i = 1
        for target_file in target_files:
            if os.path.isfile(os.path.join(subject_fullpath, target_file)):
                rename_move_files(target_file, subjectdir, suffix, extension, subject_fullpath, subject, timepoint, sequence_type, i)
                i = i + 1
            else:
                write_to_errorlog("WARNING: %s %s %s does not exist" % (sequence_type, suffix, extension))
                i = i + 1
    else:
        write_to_outputlog("no %s %s %s to fix" % (sequence_type, suffix, extension))
         

def rename_move_file(target_file:str, subjectdir:str, suffix:str, extension:str, subject_fullpath:str, subject:str, timepoint:str, sequence_type:str):
    new_filename = subjectdir + suffix + extension
    new_fullpath = os.path.join(subject_fullpath, new_filename)
    write_to_outputlog("RENAME: %s to %s" % (target_file, new_filename))
    shutil.move(os.path.join(subject_fullpath, target_file), new_fullpath)
    shutil.move(new_fullpath, os.path.join(bidsdir, subject, timepoint, sequence_type, new_filename))

       
def rename_move_files(target_file:str, subjectdir:str, suffix:str, extension:str, subject_fullpath:str, subject:str, timepoint:str, sequence_type:str, runnum:int):
    runstr = str(runnum).zfill(2)
    new_filename = subjectdir + "_run-" + runstr + suffix + extension
    new_fullpath = os.path.join(subject_fullpath, new_filename)
    write_to_outputlog("RENAME: %s to %s" % (target_file, new_filename))
    shutil.move(os.path.join(subject_fullpath, target_file), new_fullpath)
    shutil.move(new_fullpath, os.path.join(bidsdir, subject, timepoint, sequence_type, new_filename))


def touch(path:str):
    """
    Create a new file
    
    @type path:             string
    @param path:            path to - including name of - file to be created
    """
    with open(path, 'a'):
        os.utime(path, None)


def create_logfile(logfile_fullpath:str):
    """
    Check if a logfile exists. If not, make one.

    @type logfile_fullpath:         str
    @param logfile_fullpath:        Path to logfiles to check
    """
    if not os.path.isfile(logfile_fullpath):
        touch(logfile_fullpath)


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