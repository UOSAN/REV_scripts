#!/bin/bash

# Set paths and tasks
fx_outputdir='/projects/sanlab/shared/REV/bids_data/derivatives/prepost_analysis'
logdir="${fx_outputdir}/logs"
tasks=(gng sst)

# Create directory for log files and the files themselves
if [ ! -d "${logdir}" ]; then
    mkdir -v "${logdir}"
fi

sst_outputlog="${logdir}/extant_fx_files_sst.txt"
sst_errorlog="${logdir}/missing_fx_files_sst.txt"
gng_outputlog="${logdir}/extant_fx_files_gng.txt"
gng_errorlog="${logdir}/missing_fx_files_gng.txt"

touch "${sst_outputlog}" "${sst_errorlog}" "${gng_outputlog}" "${gng_errorlog}"

echo "-------------------Participants WITH beta maps-------------------" > $sst_outputlog 
echo "-------------------Participants WITH beta maps-------------------" > $gng_outputlog
echo "-------------------Participants MISSING beta maps-------------------" > $sst_errorlog 
echo "-------------------Participants MISSING beta maps-------------------" > $gng_errorlog




# now check the size of the array

    echo "no such files"
else
    echo "at least one:"
    printf "aaaaaaaaa %s\n" "${files[@]}"
fi


# Check whether each folder has beta maps
cd $fx_outputdir
for subdir in $(ls -d ${fx_outputdir} sub*); do 
    echo "checking" $subdir
    for task in ${tasks[@]}; do
        errorlog="${logdir}/missing_fx_files_${task}.txt"
        outputlog="${logdir}/extant_fx_files_${task}.txt"
        if [ -d ${fx_outputdir}/${subdir}/fx/${task} ]; then
            echo $subdir > $outputlog_${task}
            cd ${fx_outputdir}/${subdir}/fx/${task}
            shopt -s nullglob
            files=(beta*.nii)
            #if [[ -e beta*.nii ]]; then
            if (( ${#files[@]} == 0 )); then
                echo ${subdir} >> $errorlog
            else
                echo ${subdir} >> $outputlog
            fi 
        fi
    done
done