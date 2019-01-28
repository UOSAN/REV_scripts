#!/bin/bash

SCRIPTS=("rx_rev_con_01.m" "rx_rev_con_02.m" "rx_rev_con_03.m" "rx_rev_con_04.m" "rx_rev_con_05.m" "rx_rev_con_06.m" "rx_rev_con_07.m" "rx_rev_con_08.m" "rx_rev_con_09.m" "rx_rev_con_10.m" "rx_rev_con_11.m" "rx_rev_con_12.m" "rx_rev_con_13.m" "rx_rev_con_14.m" "rx_rev_con_15.m" "rx_rev_con_16.m" "rx_rev_con_17.m" "rx_rev_con_18.m" "rx_rev_con_19.m" "rx_rev_con_20.m" "rx_rev_con_21.m" "rx_rev_con_07_ssrtCovariate.m" "rx_rev_con_21v09.m")

SPM_PATH=/projects/sanlab/shared/spm12
RESULTS_INFIX=sst

MAXJOBS=8
cpuspertask=1
mempercpu=2G

for SCRIPT in ${SCRIPTS[@]}; do
    if [[ $SCRIPT == *"Covariate"* ]]; then 
        SUBSTR=$(echo $SCRIPT | cut -c8-27)
    elif [[ $SCRIPT == *"con_21v09"* ]]; then
        SUBSTR=$(echo $SCRIPT | cut -c8-16)
    else 
        SUBSTR=$(echo $SCRIPT | cut -c8-13) 
    fi
    OUTPUTDIR=/projects/sanlab/shared/REV/REV_scripts/fMRI/rx/prepost_analysis/sst/${SUBSTR}
        if [ ! -d "${OUTPUTDIR}" ]; then
            mkdir -v "${OUTPUTDIR}"
        fi
    echo "Submitting " $SUBSTR
    module load matlab
    sbatch --export=ALL,SCRIPT=$SCRIPT,SPM_PATH=$SPM_PATH \
         --job-name=${RESULTS_INFIX} \
         -o "${OUTPUTDIR}"/rx-rev_${RESULTS_INFIX}.log \
         --cpus-per-task=${cpuspertask} \
         --mem-per-cpu=${mempercpu} \
         spm_job_rx.sh
     sleep .25
done
