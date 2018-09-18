#!/bin/bash

###############################################
# Script to make sure all participants' data  #
#	are in the behavioral analysis datadirs	  #
######################################## 	#######

# Set variables
user=$(awk -F'"' '/^user=/ {print $2}' 0_runscript.sh ) #https://unix.stackexchange.com/questions/136151/how-do-i-get-a-variables-value-from-one-script-and-import-it-in-another-script
task=$(awk -F'"' '/^task=/ {print $2}' 0_runscript.sh )

# Set paths
data_repo="/Users/${user}/Desktop/REV_BxData"
datadir="${data_repo}/data/${task}"
logdir="${data_repo}/logs"
errorlog="$logdir/${task}_errorlog_filecheck.txt"
outputlog="$logdir/${task}_outputlog_filecheck.txt"
path_to_sublist="/Users/${user}/Desktop/REV_scripts/behavioral/${task}/scripts/data_prep"

cd $path_to_sublist
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