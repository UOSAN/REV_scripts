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
# bidsdir = os.path.join(os.sep, "projects", group, "shared", study, "bids_data")
# logdir = os.path.join(os.sep, "projects", group, "shared", study, "REV_scripts", "org", "dcm2bids", "logs_rename")
# outputlog = os.path.join(logdir, "outputlog_rename_" + datetime.now().strftime("%Y%m%d-%H%M") + ".txt")
# errorlog = os.path.join(logdir, "errorlog_rename_" + datetime.now().strftime("%Y%m%d-%H%M") + ".txt")

bidsdir = '/Users/kristadestasio/Desktop/bids_data'
logdir = '/Users/kristadestasio/Desktop/bids_data/logs'
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
        rename_fmap_files(magnitude1_files, magnitude2_files, phasediff_files, mprage_files, subjectdir, subject_fullpath, nifti_extension, json_extension, subject, timepoint)
        rename_flipped_files()
        rename_flipped_files()
        rename_idiosyncratic_files()


def rename_idiosyncratic_files():
    extensions = '.nii.gz', '.json'
    for extension in extensions:
        target_files_002a = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV002', 'ses-wave1', 'func')) if 'sub-REV002_ses-wave1_task-react_acq-1_bold' in filename and filename.endswith(extension)]
        for target_file in target_files_002a:
            os.remove(os.path.join(bidsdir, 'sub-REV002', 'ses-wave1', 'func', target_file))
        target_files_002b = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV002', 'ses-wave1', 'func')) if 'sub-REV002_ses-wave1_task-react_acq-2_run-01_bold' in filename and filename.endswith(extension)]
        for target_file in target_files_002b:
            os.rename(
                os.path.join(bidsdir, 'sub-REV002', 'ses-wave1', 'func', target_file), 
                os.path.join(bidsdir, 'sub-REV002', 'ses-wave1', 'func', ('sub-REV002_ses-wave1_task-react_acq-2_bold' + extension))
            )
        target_files_002c = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV002', 'ses-wave1', 'func')) if 'sub-REV002_ses-wave1_task-react_acq-2_run-02_bold' in filename and filename.endswith(extension)]
        for target_file in target_files_002c:
            os.rename(
                os.path.join(bidsdir, 'sub-REV002', 'ses-wave1', 'func', target_file),
                os.path.join(bidsdir, 'sub-REV002', 'ses-wave1', 'func', ('sub-REV002_ses-wave1_task-react_acq-1_bold' + extension))
            )
        target_files_003a = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV003', 'ses-wave2', 'func')) if 'sub-REV003_ses-wave2_task-gng_acq-1_bold' in filename and filename.endswith(extension)]
        for target_file in target_files_003a:
            os.rename(
                os.path.join(bidsdir, 'sub-REV003', 'ses-wave2', 'func', target_file), 
                os.path.join(bidsdir, 'sub-REV003', 'ses-wave2', 'func', ('sub-REV003_ses-wave2_task-gng_acq-3_bold' + extension))
            )
        target_files_003b = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV003', 'ses-wave2', 'func')) if 'sub-REV003_ses-wave2_task-gng_acq-2_bold' in filename and filename.endswith(extension)]
        for target_file in target_files_003b:
            os.rename(
                os.path.join(bidsdir, 'sub-REV003', 'ses-wave2', 'func', target_file), 
                os.path.join(bidsdir, 'sub-REV003', 'ses-wave2', 'func', ('sub-REV003_ses-wave2_task-gng_acq-4_bold' + extension))
            )
        target_files_078a = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV078', 'ses-wave2', 'func')) if 'sub-REV078_ses-wave2_task-gng_acq-4_bold' in filename and filename.endswith(extension)]
        for target_file in target_files_078a:
            os.remove(os.path.join(bidsdir, 'sub-REV078', 'ses-wave2', 'func', target_file))
        target_files_078b = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV078', 'ses-wave2', 'func')) if 'sub-REV078_ses-wave2_task-sst_acq-4_run-02_bold' in filename and filename.endswith(extension)]
        for target_file in target_files_078b:
            os.rename(
                os.path.join(bidsdir, 'sub-REV078', 'ses-wave2', 'func', target_file),
                os.path.join(bidsdir, 'sub-REV078', 'ses-wave2', 'func', ('sub-REV078_ses-wave2_task-gng_acq-4_bold' + extension))
            )
        target_files_082a = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV082', 'ses-wave2', 'func')) if 'sub-REV082_ses-wave2_task-gng_acq-3_run-01_bold' in filename and filename.endswith(extension)]
        for target_file in target_files_082a:
            os.remove(os.path.join(bidsdir, 'sub-REV082', 'ses-wave2', 'func', target_file))
        target_files_082b = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV082', 'ses-wave2', 'func')) if 'sub-REV082_ses-wave2_task-gng_acq-4_bold' in filename and filename.endswith(extension)]
        for target_file in target_files_082b:
            os.rename(
                os.path.join(bidsdir, 'sub-REV082', 'ses-wave2', 'func', target_file),
                os.path.join(bidsdir, 'sub-REV082', 'ses-wave2', 'func', ('sub-REV082_ses-wave2_task-gng_acq-3_bold' + extension))
            )
        target_files_082c = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV082', 'ses-wave2', 'func')) if 'sub-REV082_ses-wave2_task-gng_acq-3_run-02_bold' in filename and filename.endswith(extension)]
        for target_file in target_files_082c:
            os.rename(
                os.path.join(bidsdir, 'sub-REV082', 'ses-wave2', 'func', target_file),
                os.path.join(bidsdir, 'sub-REV082', 'ses-wave2', 'func', ('sub-REV082_ses-wave2_task-gng_acq-4_bold' + extension))
            )
        target_files_142 = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV142', 'ses-wave1', 'func')) if 'sub-REV142_ses-wave1_task-gng_acq-2_run-02_bold' in filename and filename.endswith(extension)]
        for target_file in target_files_142:
            os.remove(os.path.join(bidsdir, 'sub-REV142', 'ses-wave1', 'func', target_file))
        target_files_144 = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV144', 'ses-wave1', 'func')) if 'sub-REV144_ses-wave1_task-gng_acq-1_run-02_bold' in filename and filename.endswith(extension)]
        for target_file in target_files_144:
            os.remove(os.path.join(bidsdir, 'sub-REV144', 'ses-wave1', 'func', target_file))
        os.remove(os.path.join(bidsdir, 'sub-REV010', 'ses-wave2', 'fmap', 'sub-REV010_ses-wave2_magnitude1.json'))
        target_files_051a = [filename for filename in os.listdir(os.path.join(bidsdir, 'sub-REV051', 'ses-wave1', 'func')) if 'sub-REV051_ses-wave1_task-bart_acq-2' in filename or '_acq-3' in filename or '_acq-4' in filename and filename.endswith(extension)]
        for target_file in target_files_051a:
            os.remove(os.path.join(bidsdir, 'sub-REV051', 'ses-wave1', 'func', target_file))



class TargetFilesFlip:
    def __init__(self, name: str, files: list):
        self.name = name
        self.files = files


files_toflip = (TargetFilesFlip('sub-REV003', {'ses-wave1':'gng'}), 
TargetFilesFlip('sub-REV004', {'ses-wave1':'gng', 'ses-wave1':'react'}), 
TargetFilesFlip('sub-REV006', {'ses-wave1':'gng', 'ses-wave1':'react'}), 
TargetFilesFlip('sub-REV009', {'ses-wave1':'gng'}), 
TargetFilesFlip('sub-REV013', {'ses-wave1':'gng', 'ses-wave1':'react'}), 
TargetFilesFlip('sub-REV014', {'ses-wave1':'gng'}), 
TargetFilesFlip('sub-REV017', {'ses-wave1':'gng', 'ses-wave1':'react'}), 
TargetFilesFlip('sub-REV098', {'ses-wave2':'gng'}))


def rename_flipped_files():
    for subject in files_toflip:
        subject_fullpath = os.path.join(bidsdir, subject.name)
        funcdir_fullpaths = [os.path.join(subject_fullpath, timepoint, 'func') for timepoint in subject.files.keys()] 
        for funcdir_fullpath in funcdir_fullpaths:
            if os.path.isdir(funcdir_fullpath):
                target_tasks = [task for task in subject.files.values()]
                rename_found_files(target_tasks, funcdir_fullpath)
            else:
                print('%s does not exist' % (funcdir_fullpath))
            

def rename_found_files(target_tasks, funcdir_fullpath):
    funcdir_contents = os.listdir(funcdir_fullpath)
    found_files = [func_file for func_file in funcdir_contents for task in target_tasks if str(task) in func_file]
    for found_file in found_files:
        write_to_outputlog('working on ' + found_file)
        acq_index = found_file.index("_acq-")
        acq_str = found_file[acq_index:acq_index + 6]
        target_file_fullpath = os.path.join(funcdir_fullpath, found_file)
        if acq_str == '_acq-1':
            os.rename(target_file_fullpath, target_file_fullpath.replace(found_file[acq_index:acq_index + 6], '_acq-A'))
        elif acq_str == '_acq-2':
            os.rename(target_file_fullpath, target_file_fullpath.replace(found_file[acq_index:acq_index + 6], '_acq-B'))
        elif acq_str == '_acq-3':
            os.rename(target_file_fullpath, target_file_fullpath.replace(found_file[acq_index:acq_index + 6], '_acq-C'))
        elif acq_str == '_acq-4':
            os.rename(target_file_fullpath, target_file_fullpath.replace(found_file[acq_index:acq_index + 6], '_acq-D'))
        elif acq_str == '_acq-A':
            os.rename(target_file_fullpath, target_file_fullpath.replace(found_file[acq_index:acq_index + 6], '_acq-1'))
        elif acq_str == '_acq-B':
            os.rename(target_file_fullpath, target_file_fullpath.replace(found_file[acq_index:acq_index + 6], '_acq-2'))
        elif acq_str == '_acq-C':
            os.rename(target_file_fullpath, target_file_fullpath.replace(found_file[acq_index:acq_index + 6], '_acq-3'))
        elif acq_str == '_acq-D':
            os.rename(target_file_fullpath, target_file_fullpath.replace(found_file[acq_index:acq_index + 6], '_acq-4'))
        else:
            print('wtf?')



def rename_fmap_files(magnitude1_files, magnitude2_files, phasediff_files, mprage_files, subjectdir, subject_fullpath, nifti_extension, json_extension, subject, timepoint):
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
