#!/bin/bash

###################################################
# Script to make sure all participants' GNG data  #
#	are in the behavioral analysis datadirs		  #
###################################################

# Change this, path to data and script repos
#repopath="/Users/kristadestasio/Desktop"
repopath="/Users/mmoss/Dropbox/REV_repos"

# Set variables
datadir="$repopath/REV_scripts/behavioral/GNG/data" # Location of the data files to be analyzed
logdir="$repopath/REV_scripts/behavioral/GNG/logs"
errorlog="$logdir/errorlog_filecheck.txt"
outputlog="$logdir/outputlog_filecheck.txt"
sublist="$repopath/REV_scripts/behavioral/GNG/scripts/data_prep"


cd $repopath/REV_scripts/behavioral/GNG/scripts/data_prep

sublist=`cat allsubs.txt`

# create output logs
touch "${outputlog}"
touch "${errorlog}"

# Check behavioral GNG data from the base scan
cd $datadir
runnum=$(seq 1 2)
echo "--------------PRE DATA--------------" > $outputlog
echo "--------------PRE DATA--------------" > $errorlog
for sub in ${sublist[@]}; do
	for run in $runnum; do
		if [ $(ls "${datadir}"/"${sub}_GNG${run}".mat | wc -l) -eq 1 ]; then
		echo ${sub} "run" ${run} "exists" >> $outputlog
		elif [ $(ls "${datadir}"/"${sub}_GNG${run}".mat | wc -l) -gt 1 ]; then
			echo ${sub} "run" ${run} "duplicate" >> $errorlog
		elif [ $(ls "${datadir}"/"${sub}_GNG${run}".mat | wc -l) -eq 0 ]; then
			echo ${sub} "run" ${run} "missing" >> $errorlog
		fi
	done
done

# Check behavioral GNG data from the end scan
cd $datadir
runnum=$(seq 3 4)
echo "--------------POST DATA--------------" >> $outputlog
echo "--------------POST DATA--------------" >> $errorlog
for sub in ${sublist[@]}; do
	for run in $runnum; do
		if [ $(ls "${datadir}"/"${sub}_GNG${run}".mat | wc -l) -eq 1 ]; then
		echo ${sub} "run" ${run} "exists" >> $outputlog
		elif [ $(ls "${datadir}"/"${sub}_GNG${run}".mat | wc -l) -gt 1 ]; then
			echo ${sub} "run" ${run} "duplicate" >> $errorlog
		elif [ $(ls "${datadir}"/"${sub}_GNG${run}".mat | wc -l) -eq 0 ]; then
			echo ${sub} "run" ${run} "missing" >> $errorlog
		fi
	done
done

echo "Done checking files"