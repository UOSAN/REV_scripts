#!/bin/bash


# Change this, path to data and script repos
repopath="/Users/kristadestasio/Desktop/REV_scripts/behavioral/React/scripts/data_prep" 
#"/Users/mmoss/Dropbox/AH_Grad_Stuff/SAP/REV_scripts/behavioral/React/scripts/data_prep" 

echo "Copying React behavioral files"
sh ${repopath}/1_copyBxData.sh

echo "Renaming React behavioral files"
sh ${repopath}/2_renameBxData.sh

echo "Checking React behavioral files"
sh ${repopath}/3_checkExistsData.sh