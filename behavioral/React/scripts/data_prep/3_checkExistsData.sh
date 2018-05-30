#!/bin/bash

###################################################
# Script to make sure all participants' REACT data  #
#	are in the behavioral analysis datadirs		  #
###################################################

# Change this, path to data and script repos
repopath="/Users/mmoss/Dropbox/AH_Grad_Stuff/SAP"
task="React"

# Set variables
datadir="$repopath/REV_scripts/behavioral/$task/data" # Location of the data files to be analyzed
logdir="$repopath/REV_scripts/behavioral/$task/logs"
errorlog="$logdir/errorlog_filecheck.txt"
outputlog="$logdir/outputlog_filecheck.txt"
sublist="$repopath/REV_scripts/behavioral/$task/scripts/data_prep"


cd $repopath/REV_scripts/behavioral/$task/scripts/data_prep

sublist=`cat allsubs.txt`

# create output logs
touch "${outputlog}"
touch "${errorlog}"

# Check behavioral data from the base scan
cd $datadir
runnum=$(seq 1 2)
echo "--------------PRE DATA--------------" > $outputlog
echo "--------------PRE DATA--------------" > $errorlog
for sub in ${sublist[@]}; do
	for run in $runnum; do
		if [ $(ls "${datadir}"/"${sub}"_"${task}${run}"*.mat | wc -l) -eq 1 ]; then #if it exists and there's only 1, print that shit to the log
		echo ${sub} "run" ${run} "exists" >> $outputlog
		elif [ $(ls "${datadir}"/"${sub}"_"${task}${run}"*.mat | wc -l) -gt 1 ]; then #if there's more than 1 file with that name/run, print as duplicate
			echo ${sub} "run" ${run} "duplicate" >> $errorlog
		elif [ $(ls "${datadir}"/"${sub}"_"${task}${run}"*.mat | wc -l) -eq 0 ]; then #if it doesn't exist, print as missing
			echo ${sub} "run" ${run} "missing" >> $errorlog
		fi
	done
done

# Check behavioral data from the end scan
cd $datadir
runnum=$(seq 3 4)
echo "--------------POST DATA--------------" >> $outputlog
echo "--------------POST DATA--------------" >> $errorlog
for sub in ${sublist[@]}; do
	for run in $runnum; do
		if [ $(ls "${datadir}"/"${sub}"_"${task}${run}"*.mat | wc -l) -eq 1 ]; then
		echo ${sub} "run" ${run} "exists" >> $outputlog
		elif [ $(ls "${datadir}"/"${sub}"_"${task}${run}"*.mat | wc -l) -gt 1 ]; then
			echo ${sub} "run" ${run} "duplicate" >> $errorlog
		elif [ $(ls "${datadir}"/"${sub}"_"${task}${run}"*.mat | wc -l) -eq 0 ]; then
			echo ${sub} "run" ${run} "missing" >> $errorlog
		fi
	done
done

echo "Done checking files"