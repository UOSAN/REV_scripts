
#!/bin/bash

#########################################################################
# Script to check participant IDs in nifti file names for the REV study #
#########################################################################

# define directories and files
niftidir='/projects/sanlab/shared/REV/niftis'
prefix=REV???_*
outputlog=$niftidir/outputlog_IDs.txt
errorlog=$niftidir/errorlog_IDs.txt

# create output log
touch "${outputlog}"
touch "${errorlog}"

echo "----------------CHECK PARTICIPANT IDS----------------" >> $outputlog
echo "----------------CHECK PARTICIPANT IDS----------------" >> $errorlog

# Identify incorrect participant IDs (should have format %s%s%s%n%n%n_)
cd $niftidir
for i in $(ls); do
	if [[ $i = $prefix ]]; then
		echo $i >> $outputlog
	else
		echo $i >> $errorlog
	fi
done

# Baed on error log, Fix participant IDs #
#####################################################################################
# Remove participant REV0_20151001* (duplicate of REV075 data - see documentation)	#
# Rename Rev022 to REV022 															#
# Rename 019 to REV019																#
# Remove phantom scan data															#
#####################################################################################

echo "----------------CORRECTED PARTICIPANT IDS----------------" >> $outputlog

old=Rev999_*
echo "starting renaming"
for file in $(ls); do
	if [[ $file = $old ]]; then
		echo $file
		mv $file ${file//Rev022/REV022} 
		echo "REV022" >> $outputlog
	fi
done

old=019_*
for file in $(ls); do
	if [[ $file = $old ]]; then
		echo $file
		mv $file ${file//019/REV019}
		echo "REV019" >> $outputlog
	fi
done

echo "removing files"
old=REV0_20151001*
for file in $(ls); do
	if [[ $file = $old ]]; then
		echo "removing $file"
		rm $file
		echo "Removed REV0_20151001 data" >> $outputlog
	fi
done

old=phantom*
for file in $(ls); do
	if [[ $file = $old ]]; then
		echo "removing $file"
		rm $file
		echo "Removed phantom data"
	fi
done


