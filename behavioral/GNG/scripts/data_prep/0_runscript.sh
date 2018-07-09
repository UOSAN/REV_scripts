#!/bin/bash


# Change this, path to data and script repos
#repopath="/Users/kristadestasio/Desktop" 
repopath="/Users/mmoss/Dropbox/REV_repos"

echo "Copying GNG behavioral files"
sh ${repopath}/REV_scripts/behavioral/GNG/scripts/data_prep/1_copyBxData.sh

echo "Renaming GNG behavioral files"
sh ${repopath}/REV_scripts/behavioral/GNG/scripts/data_prep/2_renameBxData.sh

echo "Checking GNG behavioral files"
sh ${repopath}/REV_scripts/behavioral/GNG/scripts/data_prep/3_checkExistsData.sh