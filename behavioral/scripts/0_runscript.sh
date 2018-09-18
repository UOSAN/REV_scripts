#!/bin/bash

task="React"
#"GNG"


# Change this, path to data and script repos
user="kristadestasio"
path_to_scripts="/Users/${user}/Desktop/REV_scripts/behavioral/scripts" 
#"/Users/mmoss/Dropbox/AH_Grad_Stuff/SAP/REV_scripts/behavioral/React/scripts/data_prep"

echo "Copying ${task} behavioral files"
sh ${path_to_scripts}/1_copyBxData.sh

echo "Renaming ${task} behavioral files"
sh ${path_to_scripts}/2_rename_${task}_BxData.sh

echo "Checking ${task} behavioral files"
sh ${path_to_scripts}/3_checkExistsData.sh