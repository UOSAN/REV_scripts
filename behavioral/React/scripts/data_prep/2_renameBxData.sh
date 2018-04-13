#!/bin/sh

#########################################################################
# Script to move GNG behavioral files from the directories they are in  #
# to the directories specified in the GNG analysis script.       		#
# KD 2017.04.05															#
#########################################################################

# Change this, path to data and script repos
repopath="/Users/kristadestasio/Desktop"
task="React"

# Set paths 
outputdir="$repopath/REV_scripts/behavioral/$task/data"
logdir="$repopath/REV_scripts/behavioral/$task/logs"
outputlog="$logdir/outputlog_rename.txt"

# create output logs
touch "${outputlog}"

# Idiosyncratic file renaming to correct naming errors
echo "-------------------Renaming $task files-------------------" > $outputlog
cd $outputdir
# mv REV13_REV_GNG4.txt_04-May-2015_10-25.mat REV013_REV_GNG4.txt_04-May-2015_10-25.mat
# echo "REV13_REV_GNG4.txt_04-May-2015_10-25.mat REV013_REV_GNG4.txt_04-May-2015_10-25.mat" >> $outputlog
# mv REV13_REV_GNG3.txt_04-May-2015_10-33.mat REV013_REV_GNG3.txt_04-May-2015_10-33.mat
# echo "REV13_REV_GNG3.txt_04-May-2015_10-33.mat REV013_REV_GNG3.txt_04-May-2015_10-33.mat" >> $outputlog
# mv 32_REV_GNG3.txt_10-Jul-2015_13-40.mat REV032_REV_GNG3.txt_10-Jul-2015_13-40.mat
# echo "32_REV_GNG3.txt_10-Jul-2015_13-40.mat REV032_REV_GNG3.txt_10-Jul-2015_13-40.mat" >> $outputlog
# mv 32_REV_GNG4.txt_10-Jul-2015_13-47.mat REV032_REV_GNG4.txt_10-Jul-2015_13-47.mat
# echo "32_REV_GNG4.txt_10-Jul-2015_13-47.mat REV032_REV_GNG4.txt_10-Jul-2015_13-47.mat" >> $outputlog
# mv 102_REV_GNG2.txt_19-Jan-2016_18-02.mat REV102_REV_GNG2.txt_19-Jan-2016_18-02.mat
# echo "102_REV_GNG2.txt_19-Jan-2016_18-02.mat REV102_REV_GNG2.txt_19-Jan-2016_18-02.mat" >> $outputlog
# mv 102_REV_GNG1.txt_19-Jan-2016_17-53.mat REV102_REV_GNG1.txt_19-Jan-2016_17-53.mat
# echo "102_REV_GNG1.txt_19-Jan-2016_17-53.mat REV102_REV_GNG1.txt_19-Jan-2016_17-53.mat" >> $outputlog

# Rename all task files to format ID_run
for file in $(ls *.mat)
	do
		new=$(echo "$file" | sed -E 's/_REV//')
		mv $file $new
done

for file in $(ls *.mat)
	do
		new=$(echo "$file" | sed -E 's/.{22}\.mat/.mat/')
		mv $file $new
done
echo "Done renaming files"