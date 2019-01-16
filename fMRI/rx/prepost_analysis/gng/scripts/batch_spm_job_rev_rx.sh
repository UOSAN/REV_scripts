#!/bin/bash

SCRIPTS=("rx_rev_con_01.m" "rx_rev_con_02.m" "rx_rev_con_03.m" "rx_rev_con_04.m" "rx_rev_con_05.m" "rx_rev_con_06.m" "rx_rev_con_07.m" "rx_rev_con_08.m" "rx_rev_con_09.m" "rx_rev_con_10.m" "rx_rev_con_11.m" "rx_rev_con_12.m")
SPM_PATH=/projects/sanlab/shared/spm12
RESULTS_INFIX=con-01
OUTPUTDIR=/projects/sanlab/shared/REV/REV_scripts/fMRI/rx/prepost_analysis/gng/con-01

if [ ! -d "${OUTPUTDIR}" ]; then
    mkdir -v "${OUTPUTDIR}"
fi

MAXJOBS=8
cpuspertask=1
mempercpu=2G

for SCRIPT in {SCRIPTS[@]}; do
    echo $SCRIPT
    module load matlab
    sbatch --export=ALL \
         --job-name=${RESULTS_INFIX} \
         -o "${OUTPUTDIR}"/rx-rev_${RESULTS_INFIX}.log \
         --cpus-per-task=${cpuspertask} \
         --mem-per-cpu=${mempercpu} \
         $script
     sleep .25
done