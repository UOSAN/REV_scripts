#!/bin/bash


# Change this, path to data and script repos
repopath="/Users/mmoss/Dropbox/AH_Grad_Stuff/SAP" 

echo "Copying React behavioral files"
sh ${repopath}/REV_scripts/behavioral/React/scripts/data_prep/1_copyBxData.sh

echo "Renaming React behavioral files"
sh ${repopath}/REV_scripts/behavioral/React/scripts/data_prep/2_renameBxData.sh

echo "Checking React behavioral files"
sh ${repopath}/REV_scripts/behavioral/React/scripts/data_prep/3_checkExistsData.sh