The scripts in this directory should be run in order (1-3) to populate the directories required for the SST analysis scripts. 

1_moveDataToSubs.sh - This scripts copies the raw behavioral data from the data folder to the output folder
2_renameBehavioralData.sh - This script renames those behavioral files that were incorrectly named to the expected format, as well as removes duplicate or undesireable behavioral files. See the google spreadsheet for additional documentation: https://docs.google.com/spreadsheets/d/1CHxoL_pF16fs_Q7hp92dJCTT_01Yoax9R0XgyKu_83s/edit#gid=0
3_checkExistsData.sh - This script checks the renamed behavioral files in the output directory to ensure that they exist and are properly named.