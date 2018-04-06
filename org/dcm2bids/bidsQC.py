##################################
#  Setup
##################################

####### NOTES: DO THIS STUFF
# os.path.join filepaths
# Defined objects are usually capital

# Import libraries
import os
import fnmatch
import os.path
from datetime import datetime

# Set study info (change these for your study)
group = "sanlab"
study = "REV"

# Set directories (Check these for your study)
# logdir = os.getcwd() + "/logs_bidsQC"
# bidsdir = "/projects/" + group + "/shared/" + study + "bids_data"
# tempdir = bidsdir + "/tmp_dcm2bids"
# outputlog = logdir + "/outputlog_bidsQC.txt"
# errorlog = logdir + "/errorlog_bidsQC.txt"
# derivatives = bidsdir + "/derivatives"

# Set directories for local testing
bidsdir = "/Users/kristadestasio/Desktop/bids_data"
logdir = bidsdir + "/logs_bidsQC"
tempdir = bidsdir + "/tmp_dcm2bids"
outputlog = logdir + "/outputlog_bidsQC_" + datetime.now().strftime("%Y%m%d-%H%M%S") + ".txt"
errorlog = logdir + "/errorlog_bidsQC_" + datetime.now().strftime("%Y%m%d-%H%M%S") + ".txt"
derivatives = bidsdir + "/derivatives"


############### In progress chunk / configurable part ###############

class TimePoint:
    def __init__(self, name: str, sequences: list):
        self.name = name # string
        self.sequences = sequences # list of sequences


class Sequence:
    def __init__(self, name: str, files: dict):
        self.name = name # string
        self.files = files # dictionary


##################################################################


# Create a dictionary (the thing below) for each timepoint in your study where the pairs are "sequence_directory_name" : "expected_number_runs"
sequence1 = Sequence("func", {"bart": 1, "gng1":1, "gng2":1, "react1":1, "react2":1, "sst1":1, "sst2":1})
sequence2 = Sequence("func", {"bart": 1, "gng3":1, "gng4":1, "react3":1, "react4":1, "sst3":1, "sst4":1})
sequence3 = Sequence("anat", {"T1w":1})
sequence4 = Sequence("fmap", {"magnitude1":2, "magnitude2":2, "phasediff":2 })
timepoint1 = TimePoint("ses-wave1", [sequence1]) #, sequence3, sequence4])
timepoint2 = TimePoint("ses-wave2", [sequence2]) #, sequence3, sequence4])
expected_timepoints = [timepoint1, timepoint2]  


# Define a function to create files
def touch(path):
    """Create a new file"""
    with open(path, 'a'):
        os.utime(path, None)


# Check and create directories
if not os.path.isdir(bidsdir):
    os.mkdir(bidsdir)
if not os.path.isdir(derivatives):
    os.mkdir(derivatives)
if not os.path.isdir(logdir):
    os.mkdir(logdir)
if not os.path.isdir(tempdir):
    os.mkdir(tempdir)

# Check/create log files
if not os.path.isfile(outputlog):
    touch(outputlog)
if not os.path.isfile(errorlog):
    touch(errorlog)


# Functions to write to log files
######################################################
######### Give log file name date and time #########
######################################################

def write_to_outputlog(message):
    with open(outputlog, 'a') as logfile:
        logfile.write(message + os.linesep)
    print(message)


def write_to_errorlog(message):
    with open(errorlog, 'a') as logfile:
        logfile.write(message + os.linesep)
    print(message)



# Main function for explosion of awesome
def main():
    """
    Run the things.
    """
    subjectdirs = get_subjectdirs()
    for subject in subjectdirs:
        write_to_errorlog("-"*20 + "\n" + subject + "\n" + "-"*20)
        write_to_outputlog("-"*20 + "\n" + subject + "\n" + "-"*20)
        timepoints = get_timepoints(subject)
        check_timepoint_count(timepoints, expected_timepoints, subject)
        for timepoint in timepoints:
            sequence_folder_names = get_sequences(subject, timepoint)
            expected_timepoint = [etp for etp in expected_timepoints if etp.name == timepoint]
            if len(expected_timepoint) == 1:
                check_sequence_folder_count(sequence_folder_names, expected_timepoint[0].sequences, subject, timepoint)
            else:
                write_to_errorlog("TIMEPOINT ERROR! " + timepoint + " missing or user entered duplicate or non-existant timepoint.")
            for sequence_folder_name in sequence_folder_names:
                expected_sequence = [es for es in expected_timepoint[0].sequences if es.name == sequence_folder_name]
                if len(expected_sequence) == 1:
                    check_sequence_files(subject, timepoint, sequence_folder_name, expected_sequence[0])
                else:
                    write_to_errorlog("SEQUENCE DIRECTORY ERROR! " + sequence_folder_name + " missing or user entered duplicate or non-existant sequence folder name.")


# Check for subject directories
def get_subjectdirs() -> list:
    """
    Returns subject directory names (not full path) based on the bidsdir (bids_data directory).

    @rtype:  list
    @return: list of bidsdir directories that start with the prefix sub
    """
    bidsdir_contents = os.listdir(bidsdir)
    has_sub_prefix = [file for file in bidsdir_contents if file.startswith('sub-')]
    return [file for file in has_sub_prefix if os.path.isdir(bidsdir + '/' + file)] # get subject directories


# Get the timepoints
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


# Check subjects' sessions
def check_timepoint_count(timepoints: list, expected_timepoints: list, subject: str):
    """
    Compare the expected number of ses-wave directories to the actual number and print the result to the output or errorlog.

    @type timepoints:                       list
    @param timepoints:                      list of ses-wave folders in the subject directory
    @type expected_timepoints:              list
    @param expected_timepoints:             Number of timepoint folders each subject should have
    @type subject:                          string
    @param subject:                         subject folder name
    """
    number_timepoints_exist = len(timepoints)
    log_message = subject + " has " + str(number_timepoints_exist) + " ses-wave directories."
    if len(expected_timepoints) != number_timepoints_exist:
        write_to_errorlog("TIMEPOINT ERROR! " + log_message + " Expected " + str(len(expected_timepoints)))
    else:
        write_to_outputlog(log_message)

# Get sequences
def get_sequences(subject: str, timepoint: str) -> list:
    """
    Returns a list of sequence directory names (e.g. anat, fmap, etc.) in a participant's directory at a given timepoint.
    
    @type subject:    string
    @param subject:   Subject folder name    
    @type timepoint:  string
    @param timepoint: Timepoint folder name

    @rtype:  list
    @return: list of sequence folders in the subject directory
    """
    timepoint_fullpath = os.path.join(bidsdir, subject, timepoint)
    timepoint_contents = os.listdir(timepoint_fullpath)
    return [f for f in timepoint_contents if not f.startswith('.')]


# Check subjects' sessions
def check_sequence_folder_count(sequence_folder_names: list, expected_sequences: list, subject: str, timepoint: str):
    """
    Compare the expected number of ses-wave directories to the actual number and print the result to the output or errorlog.

    @type sequence_folder_names:            list
    @param sequence_folder_names:           List of sequence folders in the subject directory (e.g. anat, fmap, etc.)
    @type expected_sequences:               list
    @param expected_sequences:              Number of sequence folders each subject should have within the timepoint
    @type subject:                          string
    @param subject:                         Subject folder name
    @type timepoint:                        string
    @param timepoint:                       Timepoint folder name
    """
    number_sequences_exist = len(sequence_folder_names)
    log_message = subject + " " + timepoint + " has " + str(number_sequences_exist) + " total sequence directories."
    if len(expected_sequences) != number_sequences_exist:
        write_to_errorlog("SEQUENCE DIRECTORY ERROR! " + log_message + " Expected " + str(len(expected_sequences)))
    else:
        write_to_outputlog(log_message)


# Check files
def check_sequence_files(subject: str, timepoint: str, sequence: str, expected_sequence: object):
    """
    Compare the contents of a given sequence folder to the expected contents.
    
    @type subject:                          string
    @param subject:                         Subject folder name   
    @type timepoint:                        string
    @param timepoint:                       Name of timepoint
    @type sequence:                         str
    @param sequence:                        Name of sequence folder
    @type expected_sequence:                object
    @param expected_sequence:               The expected sequence
    """
    sequence_fullpath = os.path.join(bidsdir, subject, timepoint, sequence)
    if not os.path.isdir(sequence_fullpath):
        write_to_errorlog("ERROR! " + sequence + " folder missing for " + subject)
    else:
        write_to_outputlog(sequence + " folder exists for subject " + subject)
    sequence_files = os.listdir(sequence_fullpath)
    for key in expected_sequence.files.keys():
        json_files_found = 0
        nifti_files_found = 0
        for sf in sequence_files:
            if key in sf and sf.endswith('.json'):
                json_files_found += 1
            if key in sf and sf.endswith('.nii.gz'):
                nifti_files_found += 1
        if json_files_found != expected_sequence.files[key]:
            write_to_errorlog("JSON ERROR! " + subject + " missing " + key)
        #else:
         #   write_to_outputlog(subject + )
        if nifti_files_found != expected_sequence.files[key]:
            write_to_errorlog("NIFTI ERROR! " + subject + " missing " + key)
        #else:
            #write_to_outputlog(subject + ": nifti file number match.")


# if sequence in TimePoint.sequences

# Call main
main()

