# higher sequence number is phasediff
# with e2 has "EchoTime": 0.00683 = magnitude2
# without e2 "EchoTime": 0.00437 = magnitude1

import os
from datetime import datetime
import shutil

bids_dir = os.path.join(os.path.sep,"Users", "kristadestasio", "Desktop", "bids_data")
outputlog = os.path.join(bids_dir, "outputlog_bidsQC" + datetime.now().strftime("%Y%m%d-%H%M%S") + ".txt")


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
    create_logfile(outputlog)
    subjectdirs = get_subjectdirs(tempdir)
    for subjectdir in subjectdirs:
        subject_fullpath = os.path.join(tempdir, subjectdir)
        subject_files = get_subjectfiles(subject_fullpath)
        subject = subjectdir.split("_")[0]
        timepoint = subjectdir.split("_")[1]
        write_to_outputlog("\n" + "-"*20 + "\n" + subject)
        write_to_outputlog("\n    " + timepoint + "\n")
        json_extension = ".json"
        nifti_extension = ".nii.gz"
        fieldmap_files = get_fieldmap_files(subject_files)
        magnitude1_files = get_magnitude1_files(fieldmap_files)
        magnitude1_jsons = [f for f in magnitude1_files if f.endswith(json_extension)]
        magnitude1_numbers = [int(f.split("_")[0]) for f in magnitude1_jsons]
        phasediff_files = get_phasediff_files(fieldmap_files, magnitude1_numbers)
        magnitude2_files = get_magnitude2_files(fieldmap_files, magnitude1_numbers)
        mprage_files = get_mprage_files(subject_files)
        rename_mprage_files([f for f in mprage_files if f.endswith(json_extension)], subjectdir, subject_fullpath, json_extension)
        rename_mprage_files([f for f in mprage_files if f.endswith(nifti_extension)], subjectdir, subject_fullpath, nifti_extension)
        rename_fieldmap_files([f for f in magnitude1_files if f.endswith(json_extension)], subjectdir, subject_fullpath, "_magnitude1_", json_extension)
        rename_fieldmap_files([f for f in magnitude1_files if f.endswith(nifti_extension)], subjectdir, subject_fullpath, "_magnitude1_", nifti_extension)
        rename_fieldmap_files([f for f in magnitude2_files if f.endswith(json_extension)], subjectdir, subject_fullpath, "_magnitude2_", json_extension)
        rename_fieldmap_files([f for f in magnitude2_files if f.endswith(nifti_extension)], subjectdir, subject_fullpath, "_magnitude2_", nifti_extension)
        rename_fieldmap_files([f for f in phasediff_files if f.endswith(json_extension)], subjectdir, subject_fullpath, "_phasediff_", json_extension)
        rename_fieldmap_files([f for f in phasediff_files if f.endswith(nifti_extension)], subjectdir, subject_fullpath, "_phasediff_", nifti_extension)


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
    magnitude2_files = [f for f in fieldmap_files if any(f.startswith(p.zfill(3)) for p in magnitude1_prefixes) and not f.endswith("e2.nii.gz") and not f.endswith( "e2.json")]
    return magnitude2_files


def get_phasediff_files(fieldmap_files: list, magnitude1_numbers: list):
    phasediff_prefixes = [str((n + 1)) for n in magnitude1_numbers] 
    phasediff_files = [f for f in fieldmap_files if any(f.startswith(p.zfill(3)) for p in phasediff_prefixes)]
    return phasediff_files


def rename_mprage_files(mprage_files:list, subjectdir:str, subject_fullpath:str, extension:str):
    if len(mprage_files) == 1:
        write_to_outputlog("One mprage")
        for target_file in mprage_files:
            do_mprage_file(target_file, subjectdir, extension, subject_fullpath)
    elif len(mprage_files) > 1:
        i = 1
        for target_file in mprage_files:
            do_mprage_files(target_file, subjectdir, extension, subject_fullpath, i)
            i = i + 1
    else:
        write_to_outputlog("no mprage %s files to fix" % (extension))


def do_mprage_file(target_file:str, subjectdir:str, extension:str, subject_fullpath:str):
    """
    """
    mprage_filename = subjectdir + "_T1w" + extension
    mprage_fullpath = os.path.join(subject_fullpath, mprage_filename)
    print(mprage_fullpath)
    write_to_outputlog("RENAME: %s to %s\n" % (target_file, mprage_filename))
    #shutil.move(target_file, mprage_fullpath)


def do_mprage_files(target_file:str, subjectdir:str, extension:str, subject_fullpath:str, runnum:int):
    runstr = str(runnum).zfill(2)
    mprage_filename = subjectdir + "_run-" + runstr + "_T1w"  + extension
    mprage_fullpath = os.path.join(subject_fullpath, mprage_filename)
    print(target_file + " " + mprage_fullpath)
    write_to_outputlog("RENAME: %s to %s" % (target_file, mprage_filename))
    #shutil.move(target_file, mprage_fullpath)


def rename_fieldmap_files(target_files:list, subjectdir:str, subject_fullpath:str, suffix:str, extension:str):
    if len(target_files) == 1:
        write_to_outputlog("One fieldmap %s file to rename" % (extension))
        for target_file in target_files:
            do_fieldmap_file(target_file, subjectdir, suffix, extension, subject_fullpath)
    elif len(target_files) > 1:
        i = 1
        for target_file in target_files:
            do_fieldmap_files(target_file, subjectdir, suffix, extension, subject_fullpath, i)
            i = i + 1
    else:
        write_to_outputlog("no fieldmap %s to fix" % (extension))
         

def do_fieldmap_file(target_file:str, subjectdir:str, suffix:str, extension:str, subject_fullpath:str):
    fmap_filename = subjectdir + suffix + extension
    fmap_fullpath = os.path.join(subject_fullpath, fmap_filename)
    print(target_file + " " + fmap_fullpath)
    write_to_outputlog("RENAME: %s to %s" % (target_file, fmap_filename))
    #shutil.move(target_file, fmap_fullpath)

       
def do_fieldmap_files(target_file:str, subjectdir:str, suffix:str, extension:str, subject_fullpath:str, runnum:int):
    runstr = str(runnum).zfill(2)
    fmap_filename = subjectdir + "_run-" + runstr + suffix + extension
    fmap_fullpath = os.path.join(subject_fullpath, fmap_filename)
    print(target_file + " " + fmap_fullpath)
    write_to_outputlog("RENAME: %s to %s" % (target_file, fmap_filename))
    #shutil.move(target_file, fmap_fullpath)


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


main()