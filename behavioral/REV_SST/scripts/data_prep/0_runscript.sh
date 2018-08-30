#!/bin/bash

# Change this, path to data and script repos
repopath="/Users/kristadestasio/Desktop/REV_scripts" 

sh ${repopath}/behavioral/REV_SST/scripts/data_prep/1_copyBxData.sh

sh ${repopath}/behavioral/REV_SST/scripts/data_prep/2_renameBxData.sh

sh ${repopath}/behavioral/REV_SST/scripts/data_prep/3_checkExistsData.sh