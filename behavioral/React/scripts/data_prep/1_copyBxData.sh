#!/bin/sh

#########################################################################
# Script to move GNG behavioral files from the directories they are in  #
# to the directories specified in the GNG analysis script.       		#
# KD 2017.04.05															#
#########################################################################

# Change this, path to data and script repos
repopath="/Users/mmoss/Dropbox/AH_Grad_Stuff/SAP"
task="React"

taskdir=(React cueReact)

# Set paths 
datadir="$repopath/REV_scripts/behavioral/$task/data"
sourcedir="$repopath/REV_BxData"
logdir="$repopath/REV_scripts/behavioral/$task/logs"
outputlog="$logdir/outputlog_copyData.txt"
errorlog="$logdir/errorlog_copyData.txt"
allsubs="$logdir/subjectlist.txt"
outputdir="$repopath/REV_scripts/behavioral/$task/output"

# Check directory dependencies
if [ ! -d "${datadir}" ]; then
	mkdir -v "${datadir}"
fi

if [ ! -d "${sourcedir}" ]; then
	mkdir -v "${sourcedir}"
fi

if [ ! -d "${logdir}" ]; then
	mkdir -v "${logdir}"
fi

if [ ! -d "${outputdir}" ]; then
	mkdir -v "${outputdir}"
fi

# create output logs
touch "${outputlog}"
touch "${errorlog}"
touch "${allsubs}"


echo "Copying $task data from $sourcedir to $datadir" > $outputlog
echo "Errors during copy of $task data from $sourcedir to $datadir" > $errorlog

# Create a text file of all participants in the behavioral data folder
cd $sourcedir/scanning
sublist=$(ls -d REV*)
for subject in ${sublist[@]}; do
	echo ${subject} >> $allsubs
done

for sub in ${sublist[@]}; do
	if [ -d $sub ]; then
		cd $sub
        for dir in ${taskdir[@]}; do
    		if [ -d base/$dir ]; then #if directory in base called 'React' exists...
    			cd base/$dir
    			if [ $(ls "${sourcedir}"/scanning/"${sub}"/base/"${dir}"/*.mat | wc -l) -gt 0 ]; then
    				for baserun in $(ls *.mat); do
    					cp $baserun $datadir/$baserun
    				done
    				echo ${sub} "base runs copied" >> $outputlog
    			else echo ${sub} "base runs do not exist" >> $errorlog	
    			fi
    			cd ../..
            fi
    		if [ -d end/$dir ]; then
    			cd end/$dir
    			if [ $(ls "${sourcedir}"/scanning/"${sub}"/end/"${dir}"/*.mat | wc -l) -gt 0 ]; then
    				for endrun in $(ls *.mat); do
    					cp $endrun $datadir/$endrun
    				done
    				echo ${sub} "end runs copied" >> $outputlog
    			else echo ${sub} "end runs do not exist" >> $errorlog	
    			fi
    			cd ../..
    		fi
        done
		cd ..
	else echo ${sub} "scanning data directory does not exist" >> $errorlog	
	fi
done
echo "Done copying data"

