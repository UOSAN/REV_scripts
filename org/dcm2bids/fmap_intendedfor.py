import os
import json
from pprint import pprint

bidsdir = os.path.join(os.sep, 'projects', 'sanlab', 'shared', 'REV', 'bids_data')
logdir = os.path.join(os.sep, "projects", 'sanlab', "shared", 'REV', 'REV_scripts', "org", "dcm2bids", 'logs_fmapintended')
outputlog = os.path.join(logdir, "outputlog_dcmn2bids" + datetime.now().strftime("%Y%m%d-%H%M") + ".txt")
errorlog = os.path.join(logdir, "errorlog_dcm2bids" + datetime.now().strftime("%Y%m%d-%H%M") + ".txt")
#os.path.join(os.sep, 'Users', 'kristadestasio', 'Desktop', 'bids_data')
include_echo_time = True
echo_time1 = '0.00437'
echo_time2 = '0.00683'


def main():
    check_dirs(logdir)
    logfile_fullpaths = (outputlog, errorlog)
    create_logfiles(logfile_fullpaths)
    subjectdirs = get_subjectdirs()
    for subjectdir in subjectdirs:
        write_to_errorlog(subjectdir)
        write_to_outputlog(subjectdir)
        timepoints = get_timepoints(subjectdir)
        for timepoint in timepoints:
            write_to_errorlog(timepoint)
            write_to_outputlog(timepoint)
            func_dir_path = os.path.join(bidsdir, subjectdir, timepoint, 'func')
            fmap_dir_path = os.path.join(bidsdir, subjectdir, timepoint, 'fmap')
            if os.path.isdir(func_dir_path):
                func_niftis_partialpath = get_funcdir_niftis(func_dir_path, timepoint)
                if os.path.isdir(fmap_dir_path):
                    fmap_jsons = get_fmap_jsons(fmap_dir_path)
                    write_to_json(func_niftis_partialpath, fmap_jsons, fmap_dir_path, echo_time1, echo_time2)
            else:
                continue


# Define a function to create files
def touch(path:str):
    """
    Create a new file
    
    @type path:     string
    @param path:    path to - including name of - file to be created
    """
    with open(path, 'a'):
        os.utime(path, None)

# Check and create directories
def check_dirs(dir_fullpaths:list):
    """
    Check if a directory exists. If not, create it.

    @type dir_fullpaths:        list
    @param dir_fullpaths:       Paths to directorys to check
    """
    for dir_fullpath in dir_fullpaths:
        if not os.path.isdir(dir_fullpath):
            os.mkdir(dir_fullpath)

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
    with open(cfg.outputlog, 'a') as logfile:
        logfile.write(message + os.linesep)
    print(message)

def write_to_errorlog(message):
    """
    Write a log message to the error log. Also print it to the terminal.

    @type message:          string
    @param message:         Message to be printed to the log
    """
    with open(cfg.errorlog, 'a') as logfile:
        logfile.write(message + os.linesep)
    print(message)


def get_subjectdirs() -> list:
    """
    Returns subject directory names (not full path) based on the bidsdir (bids_data directory).

    @rtype:  list
    @return: list of bidsdir directories that start with the prefix sub
    """
    bidsdir_contents = os.listdir(bidsdir)
    has_sub_prefix = [subdir for subdir in bidsdir_contents if subdir.startswith('sub-')]
    subjectdirs = [subdir for subdir in has_sub_prefix if os.path.isdir(os.path.join(bidsdir, subdir))]
    subjectdirs.sort()
    return subjectdirs


def get_timepoints(subject: str) -> list:
    """
    Returns a list of ses-wave directory names in a participant's directory.

    @type subject:  string
    @param subject: subject folder name

    @rtype:  list
    @return: list of ses-wave folders in the subject directory
    """
    subject_fullpath = os.path.join(bidsdir, subject)
    subjectdir_contents = os.listdir(subject_fullpath)
    return [f for f in subjectdir_contents if not f.startswith('.')]


def get_funcdir_niftis(func_dir_path:str, timepoint:str) -> list:
    """
    Returns a list of json files in the func directory.
    """
    func_niftis_partialpath = [os.path.join('func/', f) for f in os.listdir(func_dir_path) if f.endswith('.nii.gz')]
    write_to_outputlog('Getting func jsons')
    return func_niftis_partialpath


def get_fmap_jsons(fmap_dir_path):
    fmap_jsons = [f for f in os.listdir(fmap_dir_path) if f.endswith('.json')]
    write_to_outputlog('Getting fmap jsons')
    return fmap_jsons


def write_to_json(func_niftis_partialpath:list, fmap_jsons:list, fmap_dir_path:str, echo_time1:str, echo_time2:str):
    for fmap_json in fmap_jsons:
        json_path = os.path.join(fmap_dir_path, fmap_json)
        with open(json_path) as target_json:
            json_file = json.load(target_json)
            json_file['IntendedFor'] = func_niftis_partialpath
            write_to_outputlog(['Adding IntendedFor field to json'])
            if include_echo_time:
                write_to_outputlog('Writing EchoTime fields to json')
                json_file['EchoTime1'] = echo_time1
                json_file['EchoTime2'] = echo_time2
        with open(json_path, 'w') as target_json:
            json.dump(json_file, target_json, indent=4)

main()
