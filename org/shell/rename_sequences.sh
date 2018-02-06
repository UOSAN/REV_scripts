#!/bin/bash

###################################################################
# Script to check sequence names of nifti files for the REV study #
###################################################################

# define directories and files
niftidir='/projects/sanlab/shared/REV/niftis'
outputlog=$niftidir/outputlog_sequences.txt
errorlog=$niftidir/errorlog_sequences.txt

# create output log
touch "${outputlog}"
touch "${errorlog}"

echo "----------------CHECK PARTICIPANT IDS----------------" >> $outputlog
echo "----------------CHECK PARTICIPANT IDS----------------" >> $errorlog

# Check which participants have un-numbered base scan mprages
# Create a list of those participants
# Correct the naming of mprages, fmaps, and tasks for those participants

