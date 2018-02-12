#!/bin/bash

###################################################
# Script to make sure all participants' SST data  #
#	are in the behavioral analysis folders				  #
###################################################

# Change this, path to data and script repos
repopath="/Users/kristadestasio/Desktop"
 
# Set paths
datadir= $repopath/REV_scripts/behavioral/REV_SST/output
outputlog=$datadir/outputlog_renamed.txt

# Create output log
touch "${outputlog}"
echo "----------------CORRECTING RUN NUMBERS----------------" > $outputlog
echo "----------------ERRORS IN RENAMING----------------" > $outputlog

# Rename files in the pre folder
cd $datadir/pre

old=*run11_*.mat
for file in $(ls); do
	if [[ $file = $old ]]; then
		mv $file ${file/run11_/run1_} 
		echo $file >> $outputlog
	fi
done
old=*run12_*.mat
for file in $(ls); do
	if [[ $file = $old ]]; then
		mv $file ${file/run12_/run2_} 
		echo $file >> $outputlog
	fi
done

# Idiosyncratic renaming/removal of files
echo "----------------MOVING PRE FILES TO OMITTED FOLDER----------------" >> $outputlog
mv sub114_run13_scan3_17-Feb-2016_14-57.mat sub114_run1_scan1_17-Feb-2016_14-57.mat
echo "removed sub114_run13_scan3_17-Feb-2016_14-57.mat" >> $outputlog

cd ../train
echo "----------------RENAMING TRAINING FILES----------------" >> $outputlog
mv sub34_run8_train7_25-Jun-2015_10-38.mat sub34_run9_train7_25-Jun-2015_10-38.mat
echo "sub34_run8_train7_25-Jun-2015_10-38.mat renamed to sub34_run9_train7_25-Jun-2015_10-38.mat" >> $outputlog
mv sub38_run8_train7_18-Aug-2015_16-41.mat sub38_run9_train7_18-Aug-2015_16-41.mat
echo "sub38_run8_train7_18-Aug-2015_16-41.mat renamed to sub38_run9_train7_18-Aug-2015_16-41.mat" >> $outputlog
mv sub11_run8_train7_14-May-2015_15-38.mat sub11_run9_train7_14-May-2015_15-38.mat 
echo "sub11_run8_train7_14-May-2015_15-38.mat renamed to sub11_run9_train7_14-May-2015_15-38.mat" >> $outputlog
echo "----------------MOVING TRAINING FILES TO OMITTED FOLDER----------------" >> $outputlog
mv sub6_run4_train2_18-Mar-2015_10-02.mat ../omitted/sub6_run4_train2_18-Mar-2015_10-02.mat
echo "removed sub6_run4_train2_18-Mar-2015_10-02.mat" >> $outputlog
mv sub11_run8_train6_14-May-2015_15-38.mat ../omitted/sub11_run8_train6_14-May-2015_15-38.mat
echo "removed sub11_run8_train6_14-May-2015_15-38.mat" >> $outputlog
mv sub18_run3_train1_06-Apr-2015_12-14.mat ../omitted/sub18_run3_train1_06-Apr-2015_12-14.mat
echo "removed sub18_run3_train1_06-Apr-2015_12-14.mat" >> $outputlog


cd ../post
echo "----------------RENAMING POST FILES----------------" >> $outputlog
mv sub55_run12_scan1_05-Sep-2015_10-10.mat sub55_run13_scan3_05-Sep-2015_10-10.mat
echo "sub55_run12_scan1_05-Sep-2015_10-10.mat renamed to sub55_run13_scan3_05-Sep-2015_10-10.mat" >> $outputlog

echo "----------------MOVING POST FILES TO OMITTED FOLDER----------------" >> $outputlog
mv sub17_run13_scan3_23-Apr-2015_10-32.mat ../omitted/sub17_run13_scan3_23-Apr-2015_10-32.mat
echo "removed sub17_run13_scan3_23-Apr-2015_10-32.mat" >> $outputlog 
mv sub17_run14_scan4_23-Apr-2015_10-41.mat ../omitted/sub17_run14_scan4_23-Apr-2015_10-41.mat 
echo "removed sub17_run14_scan4_23-Apr-2015_10-41.mat" >> $outputlog
mv sub116_run11_scan1_25-Mar-2016_11-34.mat ../omitted/sub116_run11_scan1_25-Mar-2016_11-34.mat >> $outputlog
echo "removed sub116_run11_scan1_25-Mar-2016_11-34.mat" >> $outputlog

echo "done renaming files"