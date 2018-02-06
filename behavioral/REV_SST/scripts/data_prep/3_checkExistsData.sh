#!/bin/bash

###################################################
# Script to make sure all participants' SST data  #
#	are in the behavioral analysis datadirs		  #
###################################################

# Set variables
pre_sublist=(sub1 sub2 sub3 sub4 sub5 sub6 sub9 sub10 sub11 sub12 sub13 sub14 sub15 sub16 sub17 sub18 sub19 sub20 sub21 sub22 sub23 sub24 sub25 sub26 sub27 sub29 sub30 sub31 sub32 sub33 sub34 sub35 sub36 sub37 sub38 sub39 sub40 sub41 sub42 sub43 sub44 sub45 sub46 sub47 sub48 sub49 sub50 sub51 sub52 sub53 sub54 sub55 sub56 sub57 sub58 sub59 sub60 sub61 sub62 sub63 sub64 sub65 sub66 sub67 sub68 sub69 sub70 sub73 sub74 sub75 sub76 sub77 sub78 sub79 sub80 sub82 sub84 sub85 sub86 sub88 sub89 sub90 sub91 sub93 sub94 sub95 sub97 sub98 sub100 sub101 sub102 sub104 sub105 sub106 sub107 sub108 sub109 sub110 sub111 sub112 sub113 sub114 sub115 sub116 sub117 sub118 sub119 sub120 sub121 sub122 sub123 sub124 sub125 sub126 sub127 sub128 sub129 sub130 sub131 sub132 sub133 sub134 sub135 sub136 sub137 sub138 sub140 sub141 sub142 sub144)
train_sublist=(sub1 sub2 sub3 sub6 sub9 sub10 sub11 sub13 sub16 sub17 sub18 sub19 sub20 sub21 sub22 sub23 sub24 sub25 sub26 sub27 sub29 sub30 sub31 sub32 sub33 sub34 sub35 sub36 sub37 sub38 sub39 sub40 sub41 sub42 sub43 sub44 sub45 sub46 sub47 sub48 sub49 sub50 sub51 sub52 sub53 sub54 sub55 sub56 sub57 sub58 sub59 sub60 sub62 sub63 sub64 sub65 sub67 sub68 sub69 sub70 sub73 sub74 sub75 sub76 sub77 sub78 sub79 sub80 sub82 sub84 sub85 sub86 sub88 sub89 sub90 sub91 sub93 sub94 sub95 sub97 sub98 sub100 sub101 sub102 sub104 sub105 sub106 sub107 sub108 sub109 sub110 sub111 sub113 sub114 sub115 sub116 sub117 sub118 sub119 sub120 sub121 sub122 sub123 sub124 sub125 sub126 sub127 sub128 sub129 sub130 sub131 sub132 sub133 sub134 sub135 sub136 sub137 sub138 sub140 sub141 sub142 sub144)
post_sublist=(sub1 sub2 sub3 sub6 sub9 sub10 sub11 sub13 sub16 sub17 sub18 sub19 sub20 sub21 sub22 sub23 sub24 sub26 sub27 sub29 sub31 sub32 sub34 sub35 sub36 sub37 sub38 sub39 sub41 sub43 sub44 sub46 sub47 sub48 sub49 sub50 sub51 sub52 sub53 sub54 sub55 sub56 sub57 sub59 sub60 sub62 sub65 sub67 sub68 sub69 sub70 sub73 sub74 sub75 sub76 sub77 sub78 sub80 sub82 sub84 sub86 sub88 sub89 sub90 sub91 sub93 sub94 sub97 sub98 sub100 sub102 sub104 sub107 sub108 sub109 sub110 sub111 sub112 sub114 sub115 sub116 sub117 sub118 sub119 sub120 sub121 sub124 sub126 sub127 sub129 sub130 sub131 sub134 sub135 sub136 sub137 sub138 sub140 sub141 sub142 sub144)
datadir="/Users/kristadestasio/Desktop/REV_scripts/behavioral/REV_SST/output" # Location of the data files to be analyzed
errorlog=$datadir/errorlog_filecheck.txt
outputlog=$datadir/outputlog_filecheck.txt

# create output logs
touch "${outputlog}"
touch "${errorlog}"

# Check behavioral SST data from the base scan
cd $datadir/pre
runnum=$(seq 1 2)
echo "--------------PRE DATA--------------" >> $outputlog
echo "--------------PRE DATA--------------" >> $errorlog
for sub in ${pre_sublist[@]}; do
	for run in $runnum; do
		if [ $(ls "${datadir}"/pre/"${sub}_run${run}_"*.mat | wc -l) -eq 1 ]; then
		echo ${sub} "run" ${run} "exists" >> $outputlog
		elif [ $(ls "${datadir}"/pre/"${sub}_run${run}_"*.mat | wc -l) -gt 1 ]; then
			echo ${sub} "run" ${run} "duplicate" >> $errorlog
		elif [ $(ls "${datadir}"/pre/"${sub}_run${run}_"*.mat | wc -l) -eq 0 ]; then
			echo ${sub} "run" ${run} "missing" >> $errorlog
		fi
	done
done

# Check behavioral SST data from the training sessions
cd ../train
runnum=$(seq 3 12)
echo "----------------TRAINING BEHAVIORAL DATA----------------" >> $outputlog
echo "----------------TRAINING BEHAVIORAL DATA----------------" >> $errorlog
for sub in ${train_sublist[@]}; do
	for run in $runnum; do
		if [ $(ls "${datadir}"/train/"${sub}_run${run}_"*.mat | wc -l) -eq 1 ]; then
		echo ${sub} "run" ${run} "exists" >> $outputlog
		elif [ $(ls "${datadir}"/train/"${sub}_run${run}_"*.mat | wc -l) -gt 1 ]; then
			echo ${sub} "run" ${run} "duplicate" >> $errorlog
		elif [ $(ls "${datadir}"/train/"${sub}_run${run}_"*.mat | wc -l) -eq 0 ]; then
			echo ${sub} "run" ${run} "missing" >> $errorlog
		fi
	done
done

# Check behavioral SST data from the end scan
cd $datadir/post
runnum=$(seq 13 14)
echo "--------------POST DATA--------------" >> $outputlog
echo "--------------POST DATA--------------" >> $errorlog
for sub in ${post_sublist[@]}; do
	for run in $runnum; do
		if [ $(ls "${datadir}"/post/"${sub}_run${run}_"*.mat | wc -l) -eq 1 ]; then
		echo ${sub} "run" ${run} "exists" >> $outputlog
		elif [ $(ls "${datadir}"/post/"${sub}_run${run}_"*.mat | wc -l) -gt 1 ]; then
			echo ${sub} "run" ${run} "duplicate" >> $errorlog
		elif [ $(ls "${datadir}"/post/"${sub}_run${run}_"*.mat | wc -l) -eq 0 ]; then
			echo ${sub} "run" ${run} "missing" >> $errorlog
		fi
	done
done

echo "done"