#!/bin/sh

#########################################################################
# Script to move GNG behavioral files from the directories they are in  #
# to the directories specified in the GNG analysis script.       		#
# KD 2017.04.05															#
#########################################################################

# Change this, path to data and script repos
repopath="/Users/kristadestasio/Desktop"

# Set paths 
datadir="$repopath/REV_scripts/behavioral/GNG/data"
sourcedir="$repopath/REV_BxData"
logdir="$repopath/REV_scripts/behavioral/GNG/logs"
outputlog="$logdir/outputlog_copyData.txt"
errorlog="$logdir/errorlog_copyData.txt"
allsubs="$logdir/subjectlist.txt"
outputdir="$repopath/REV_scripts/behavioral/GNG/output"

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


echo "Copying GNG data from $sourcedir to $datadir" > $outputlog
echo "Errors during copy of GNG data from $sourcedir to $datadir" > $errorlog

# Create a text file of all participants in the behavioral data folder
cd $sourcedir/scanning
sublist=$(ls -d REV*)
for subject in ${sublist[@]}; do
	echo ${subject} >> $allsubs
done

for sub in ${sublist[@]}; do
	if [ -d $sub ]; then
		cd $sub
		if [ -d base/GNG ]; then
			cd base/GNG
			if [ $(ls "${sourcedir}"/scanning/"${sub}"/base/GNG/*.mat | wc -l) -gt 0 ]; then
				for baserun in $(ls *.mat); do
					cp $baserun $datadir/$baserun
				done
				echo ${sub} "base runs copied" >> $outputlog
			else echo ${sub} "base runs do not exist" >> $errorlog	
			fi
			cd ../..
		fi
		if [ -d end/GNG ]; then
			cd end/GNG
			if [ $(ls "${sourcedir}"/scanning/"${sub}"/end/GNG/*.mat | wc -l) -gt 0 ]; then
				for endrun in $(ls *.mat); do
					cp $endrun $datadir/$endrun
				done
				echo ${sub} "end runs copied" >> $outputlog
			else echo ${sub} "end runs do not exist" >> $errorlog	
			fi
			cd ../..
		fi
		cd ..
	else echo ${sub} "scanning data directory does not exist" >> $errorlog	
	fi
done
echo "Done copying data"

