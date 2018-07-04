#!/bin/bash


# Change this, path to data and script repos
# repopath="/Users/kristadestasio/Desktop" 
repopath="/Users/brendancullen/Desktop/REV" 

sh ${repopath}/REV_scripts/behavioral/REV_SST/scripts/data_prep/1_copyBxData.sh

sh ${repopath}/REV_scripts/behavioral/REV_SST/scripts/data_prep/2_renameBxData.sh

sh ${repopath}/REV_scripts/behavioral/REV_SST/scripts/data_prep/3_checkExistsData.sh