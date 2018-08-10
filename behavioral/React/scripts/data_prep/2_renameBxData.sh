#!/bin/sh

#########################################################################
# Script to move GNG behavioral files from the directories they are in  #
# to the directories specified in the GNG analysis script.       		#
# KD 2017.04.05															#
#########################################################################

# Change this, path to data and script repos
#repopath="/Users/kristadestasio/Desktop/REV_scripts"
#"/Users/mmoss/Dropbox/AH_Grad_Stuff/SAP"
repopath="/Users/brendancullen/Desktop/REV/REV_scripts" 
task="React"

# Set paths 
outputdir="$repopath/behavioral/$task/data"
logdir="$repopath/behavioral/$task/logs"
outputlog="$logdir/outputlog_rename.txt"

# create output logs
touch "${outputlog}"

# Idiosyncratic file renaming to correct naming errors
echo "-------------------Renaming $task files-------------------" > $outputlog
cd $outputdir
 mv REV12_REV_GNG1.txt_30-Apr-2015_18-53.mat REV012_REV_GNG1.txt_30-Apr-2015_18-53.mat
 echo "REV12_REV_GNG1.txt_30-Apr-2015_18-53.mat REV012_REV_GNG1.txt_30-Apr-2015_18-53.mat" >> $outputlog
 mv REV12_REV_GNG2.txt_30-Apr-2015_18-45.mat REV012_REV_GNG2.txt_30-Apr-2015_18-45.mat
 echo "REV12_REV_GNG2.txt_30-Apr-2015_18-45.mat REV012_REV_GNG2.txt_30-Apr-2015_18-45.mat" >> $outputlog
 mv REV057_REV_React2.txt_25-Aug-2015_18-15.mat REV057_REV_React1.txt_25-Aug-2015_18-15.mat   
 echo "REV057_REV_React2.txt_25-Aug-2015_18-15.mat REV057_REV_React1.txt_25-Aug-2015_18-15.mat" >> $outputlog
 mv REV027_REV_React4.txt_12-Jun-2015_11-18.mat REV027_REV_React3.txt_12-Jun-2015_11-18.mat
 echo "REV027_REV_React4.txt_12-Jun-2015_11-18.mat REV027_REV_React3.txt_12-Jun-2015_11-18.mat" >> $outputlog

# Rename all task files to format ID_run
for file in $(ls *.mat)
	do
		new=$(echo "$file" | sed -E 's/_REV//')
		mv $file $new
done

for file in $(ls *.mat)
	do
		new=$(echo "$file" | sed -E 's/.{22}\.mat/.mat/') #22 indicates index (check how things are indexed here)
		mv $file $new
done

mv REV12_React1.mat REV012_React1.mat
echo "mv REV12_React1.mat REV012_React1.mat" >> $outputlog
mv REV12_React2.mat REV012_React2.mat
echo "mv REV12_React2.mat REV012_React2.mat" >> $outputlog
mv 102_React1.mat REV102_React1.mat
echo "mv 102_React1.mat REV102_React1.mat" >> $outputlog
mv 102_React2.mat REV102_React2.mat
echo "mv 102_React2.mat REV102_React2.mat" >> $outputlog
mv REV13_React3.mat REV013_React3.mat
echo "mv REV13_React3.mat REV013_React3.mat" >> $outputlog
mv REV13_React4.mat REV013_React4.mat
echo "mv REV13_React4.mat REV013_React4.mat" >> $outputlog
mv 32_React3.mat REV032_React3.mat
echo "mv 32_React3.mat REV032_React3.mat" >> $outputlog
mv 32_React4.mat REV032_React4.mat
echo "mv 32_React4.mat REV032_React4.mat" >> $outputlog

echo "Done renaming files"