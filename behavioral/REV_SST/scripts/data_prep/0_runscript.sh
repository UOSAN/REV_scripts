#!/bin/bash


repopath="/Users/kristadestasio/Desktop" #Path to REV_scripts directory

sh ${repopath}/REV_scripts/behavioral/REV_SST/scripts/data_prep/1_copyBxData.sh

sh ${repopath}/REV_scripts/behavioral/REV_SST/scripts/data_prep/2_renameBehavioralData.sh

sh ${repopath}/REV_scripts/behavioral/REV_SST/scripts/data_prep/3_checkExistsData.sh