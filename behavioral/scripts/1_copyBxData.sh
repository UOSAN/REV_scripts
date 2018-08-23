#!/bin/sh

#########################################################################
# Script to move React behavioral files from the directories they are in  #
# to the directories specified in the React analysis script.       		#
# KD 2017.04.05															#
#########################################################################

# Set variables
user=$(awk -F'"' '/^user=/ {print $2}' 0_runscript.sh ) #https://unix.stackexchange.com/questions/136151/how-do-i-get-a-variables-value-from-one-script-and-import-it-in-another-script
task=$(awk -F'"' '/^task=/ {print $2}' 0_runscript.sh )

# Set paths 
data_repo="/Users/${user}/Desktop/REV_BxData"
datadir="${data_repo}/data/${task}"
data_source_dir="/Users/${user}/Desktop/REV_BxData"
logdir="${data_repo}/logs"
outputlog="${logdir}/${task}_outputlog_copyData.txt"
errorlog="${logdir}/${task}_errorlog_copyData.txt"
allsubs="${data_repo}/subjectlist.txt"

# Check directory dependencies

if [ ! -d "${data_repo}/data" ]; then
    mkdir -v "${data_repo}/data"
fi

if [ ! -d "${datadir}" ]; then
	mkdir -v "${datadir}"
fi

if [ ! -d "${data_source_dir}" ]; then
    echo "Path to behavioral data source folder is incorrect."
fi

if [ ! -d "${logdir}" ]; then
	mkdir -v "${logdir}"
fi

# create output logs
touch "${outputlog}"
touch "${errorlog}"
touch "${allsubs}"


echo "Copying $task data from $data_repo to $datadir" > $outputlog
echo "Errors during copy of $task data from $data_repo to $datadir" > $errorlog

# Create a text file of all participants in the behavioral data folder
cd $data_repo/scanning
sublist=$(ls -d REV*)
for subject in ${sublist[@]}; do
	echo ${subject} >> $allsubs
done

# Loop through subject directories to find data
for sub in ${sublist[@]}; do
	if [ -d $sub ]; then
		cd $sub
        for dir in ${task[@]}; do
    		if [ -d base/*"${dir}" ]; then #if directory in base called 'React' exists...
    			cd base/*"${dir}"
    			if [ $(ls "${data_repo}"/scanning/"${sub}"/base/*"${dir}"/*.mat | wc -l) -gt 0 ]; then
    				for baserun in $(ls *.mat); do
    					cp $baserun $datadir/$baserun
    				done
    				echo ${sub} "base runs copied" >> $outputlog
    			else echo ${sub} "base runs do not exist" >> $errorlog	
    			fi
    			cd ../..
            fi
    		if [ -d end/*"${dir}" ]; then
    			cd end/*"${dir}"
    			if [ $(ls "${data_repo}"/scanning/"${sub}"/end/*"${dir}"/*.mat | wc -l) -gt 0 ]; then
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

