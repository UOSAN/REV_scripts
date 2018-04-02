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
outputlog = logdir + "/outputlog_bidsQC.txt"
errorlog = logdir + "/errorlog_bidsQC.txt"
derivatives = bidsdir + "/derivatives"
number_timepoints = 2 # will be able to use length of list of timepoints created in the class thing


# Create a dictionary (the thing below) for each timepoint in your study where the pairs are "sequence_directory_name" : "expected_number_runs"
time1_sequences = {"anat" : 2, "fmap" : 2, "func" :  }
time2_sequences =

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
def write_to_outputlog(message):
    with open(outputlog, 'a') as logfile:
        logfile.write(message + os.linesep)
    print(message)


def write_to_errorlog(message):
    with open(errorlog, 'a') as logfile:
        logfile.write(message + os.linesep)
    print(message)


############### In progress chunk / configurable part ###############

class TimePoint:
    def __init__(self, name, sequences):
        self.name = name # string
        self.sequences = sequences # list of sequences


class Sequence:
    def __init__(self, name, tasks):
        self.name = name # string
        self.tasks = tasks # dictionary


##################################################################

# Main function for explosion of awesome
def main():
    """
    Run the things.
    """
    subjectdirs = get_subjectdirs()
    for subject in subjectdirs:
        timepoints = get_timepoints(subject)
        check_timepoints(timepoints, number_timepoints, subject)
        for timepoint in timepoints:
            check_sequence(subject, timepoint, expected_numruns, sequence_type)


# Check for subject directories
def get_subjectdirs():
    """
    Returns subject directories based on the bidsdir (bids_data directory).

    @rtype:  list
    @return: list of bidsdir directories that start with the prefix sub
    """
    bidsdir_contents = os.listdir(bidsdir)
    has_sub_prefix = [file for file in bidsdir_contents if file.startswith('sub-')]
    return [file for file in has_sub_prefix if os.path.isdir(bidsdir + '/' + file)] # get subject directories


# Get the timepoints
def get_timepoints(subject):
    """
    Returns a list of ses-wave directory names in a participant's directory.

    @type subject:  string
    @param subject: subject folder name

    @rtype:  list
    @return: list of ses-wave folders in the subject directory
    """
    subject_fullpath = bidsdir + '/' + subject
    subjectdir_contents = os.listdir(subject_fullpath)
    return [f for f in subjectdir_contents if not f.startswith('.')]

# Check subjects' sessions
def check_timepoints(timepoints, expected_number_timepoints, subject):
    """
    Compare the expected number of ses-wave directories to the actual number and print the result to the output or errorlog.

    @type timepoints:                       list
    @param timepoints:                      list of ses-wave folders in the subject directory
    @type expected_number_timepoints:       integer
    @param expected_number_timepoints:      Number of timepoint folders each subject should have
    @type subject:  string
    @param subject: subject folder name
    """
    number_timepoints4realz = len(timepoints)
    log_message = subject + " has " + str(number_timepoints4realz) + " ses-wave directories."
    if expected_number_timepoints != number_timepoints4realz:
        write_to_errorlog(log_message)
    else:
        write_to_outputlog(log_message)


# Check files
def check_sequence(subject, timepoint, expected_numruns, sequence_type):
    sequence_fullpath = os.path.join(bidsdir, subject, timepoint, sequence_type)
    if not os.path.isdir(sequence_fullpath):
        write_to_errorlog(sequence_type + " folder missing for subject " + subject)
    else:
        write_to_outputlog(sequence_type + " folder exists for subject " + subject)


# Call main
main()

