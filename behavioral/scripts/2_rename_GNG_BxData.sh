#!/bin/sh

#########################################################################
# Script to move GNG behavioral files from the directories they are in  #
# to the directories specified in the GNG analysis script.       		#
# KD 2017.04.05															#
#########################################################################

# Set variables
user=$(awk -F'"' '/^user=/ {print $2}' 0_runscript.sh ) #https://unix.stackexchange.com/questions/136151/how-do-i-get-a-variables-value-from-one-script-and-import-it-in-another-script
task="GNG"

# Set paths 
data_repo="/Users/${user}/Desktop/REV_BxData"
datadir="${data_repo}/data/${task}"
logdir="${data_repo}/logs"
outputlog="$logdir/${task}_outputlog_rename.txt"


# create output logs
touch "${outputlog}"

# Idiosyncratic file renaming to correct naming errors
echo "-------------------Renaming GNG files-------------------" > $outputlog
cd $datadir
mv REV12_REV_GNG1.txt_30-Apr-2015_18-53.mat REV012_REV_GNG1.txt_30-Apr-2015_18-53.mat
echo "REV12_REV_GNG1.txt_30-Apr-2015_18-53.mat REV012_REV_GNG1.txt_30-Apr-2015_18-53.mat" >> $outputlog
mv REV12_REV_GNG2.txt_30-Apr-2015_18-45.mat REV012_REV_GNG2.txt_30-Apr-2015_18-45.mat
echo "REV12_REV_GNG2.txt_30-Apr-2015_18-45.mat REV012_REV_GNG2.txt_30-Apr-2015_18-45.mat" >> $outputlog
mv REV13_REV_GNG4.txt_04-May-2015_10-25.mat REV013_REV_GNG4.txt_04-May-2015_10-25.mat
echo "REV13_REV_GNG4.txt_04-May-2015_10-25.mat REV013_REV_GNG4.txt_04-May-2015_10-25.mat" >> $outputlog
mv REV13_REV_GNG3.txt_04-May-2015_10-33.mat REV013_REV_GNG3.txt_04-May-2015_10-33.mat
echo "REV13_REV_GNG3.txt_04-May-2015_10-33.mat REV013_REV_GNG3.txt_04-May-2015_10-33.mat" >> $outputlog
mv 32_REV_GNG3.txt_10-Jul-2015_13-40.mat REV032_REV_GNG3.txt_10-Jul-2015_13-40.mat
echo "32_REV_GNG3.txt_10-Jul-2015_13-40.mat REV032_REV_GNG3.txt_10-Jul-2015_13-40.mat" >> $outputlog
mv 32_REV_GNG4.txt_10-Jul-2015_13-47.mat REV032_REV_GNG4.txt_10-Jul-2015_13-47.mat
echo "32_REV_GNG4.txt_10-Jul-2015_13-47.mat REV032_REV_GNG4.txt_10-Jul-2015_13-47.mat" >> $outputlog
mv 102_REV_GNG2.txt_19-Jan-2016_18-02.mat REV102_REV_GNG2.txt_19-Jan-2016_18-02.mat
echo "102_REV_GNG2.txt_19-Jan-2016_18-02.mat REV102_REV_GNG2.txt_19-Jan-2016_18-02.mat" >> $outputlog
mv 102_REV_GNG1.txt_19-Jan-2016_17-53.mat REV102_REV_GNG1.txt_19-Jan-2016_17-53.mat
echo "102_REV_GNG1.txt_19-Jan-2016_17-53.mat REV102_REV_GNG1.txt_19-Jan-2016_17-53.mat" >> $outputlog

mv REV12_GNG1.mat REV012_GNG1.mat
echo "REV12_GNG1.mat REV012_GNG1.mat" >> $outputlog
mv REV12_GNG2.mat REV012_GNG2.mat
echo "REV12_GNG2.mat REV012_GNG2.mat" >> $outputlog

# Rename all files to format ID_run
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