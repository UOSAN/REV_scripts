
#!/bin/bash

###########################################################
# Script to convert all dicoms in a directory to niftis #
###########################################################

# define directories and files
study="REV"
sourcedir=/projects/sanlab/shared/DICOMS/$study
outputdir=/projects/sanlab/shared/REV/niftis

cd $sourcedir
for subdir in $(ls); do
	if [ -d $subdir ]; then
	/projects/sanlab/shared/dcm2niix/build/bin/dcm2niix -o $outputdir $sourcedir/$subdir 
	fi
done

