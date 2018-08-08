# Replace wrong-sized bids_data files with correct-sized tmp files

# Get list of full file paths for tmp files and bids files

# repopath="/Users/brendancullen/Desktop/REV/REV_scripts/org/dcm2bids"
repopath="/projects/sanlab/shared/REV/REV_scripts/org/dcm2bids"
purgatory_path="/projects/sanlab/shared/REV/purgatory"
ninth_circle_path="/projects/sanlab/shared/REV/tmp_dcm2bids/ninth_circle"

# bids_paths=`cat $repopath/file_size_bids_paths.txt`
# tmp_paths=`cat $repopath/file_size_tmp_paths.txt`
# bids_files=`cat $repopath/file_size_bids_files.txt`
# tmp_files=`cat $repopath/file_size_tmp_files.txt`

declare -a tmp_paths_array
readarray -t tmp_paths_array < $repopath/file_size_tmp_paths.txt
declare -a tmp_files_array
readarray -t tmp_files_array < $repopath/file_size_tmp_files.txt
declare -a bids_paths_array
readarray -t bids_paths_array < $repopath/file_size_bids_paths.txt
declare -a bids_files_array
readarray -t bids_files_array < $repopath/file_size_bids_files.txt


#outputlog="$repopath/outputlog_fixFileSizes.txt"

# create output logs
#touch "${outputlog}"

# Idiosyncratic file renaming to correct naming errors
#echo "-------------------Renaming GNG files-------------------" > $outputlog
#cd $outputdir
#mv REV13_REV_GNG4.txt_04-May-2015_10-25.mat REV013_REV_GNG4.txt_04-May-2015_10-25.mat
#echo "REV13_REV_GNG4.txt_04-May-2015_10-25.mat REV013_REV_GNG4.txt_04-May-2015_10-25.mat" >> $outputlog


# for each file in tmp_files, move file to new directory called "purgatory" and re-name with correct bids_file names

cd $repopath

num=`grep -c $ file_size_bids_paths.txt`

for i in $(seq 0 $num); do
path=${tmp_paths_array[i]}
oldfile=${tmp_files_array[i]}
newfile=${bids_files_array[i]}
if [ -d $path ]; then
cd $path


if [ -f $oldfile ]; then #file exists in folder
mv $oldfile ${purgatory_path}/$newfile
echo $oldfile
echo 'will be renamed as'
echo ${purgatory_path}/$newfile
fi

cd $repopath
fi
done


# for each incorrect bids_file, move to new folder called "ninth circle" (the ninth circle of hell)

cd $repopath

for i in $(seq 0 $num); do
path=${bids_paths_array[i]}
wrongfile=${bids_files_array[i]}
newpath=${ninth_circle_path} # We did not move the wrong bids files to the tmp folder because some of them would 
#likely overwrite existing tmp folder. Instead they are going to the ninth circle of hell.
if [ -d $path ]; then
cd $path


if [ -f $wrongfile ]; then #file exists in folder
mv $wrongfile ${newpath}
echo $wrongfile
echo 'will be moved to'
echo ${newpath}
fi

cd $repopath
fi
done

# for each re-named purgatory file, move the file to bids_path folder

cd $repopath

for i in $(seq 0 $num); do
path=$purgatory_path
renamedfile=${bids_files_array[i]}
newpath=${bids_paths_array[i]} 
if [ -d $path ]; then
cd $path


if [ -f $renamedfile ]; then #file exists in folder
mv $renamedfile ${newpath}
echo $renamedfile
echo 'will be moved to'
echo ${newpath}
fi

cd $repopath
fi
done



## NOTE: 8-8-18: We figured out that the for loop should have indexed starting at 0 instead of 1, which is why it didn't
## run for the first line. 

## The script did not work for sub-REV003 GNG acq 1
## Below we are manually doing this process for this janky file

# for each file in tmp_files, move file to new directory called "purgatory" and re-name with correct bids_file names

cd $repopath


path="/projects/sanlab/shared/REV/tmp_dcm2bids/sub-REV003_ses-wave1/"
oldfile="sub-REV003_ses-wave1_task-gng_acq-1_run-01_bold.nii.gz"
newfile="sub-REV003_ses-wave1_task-gng_acq-2_run-02_bold.nii.gz"
if [ -d $path ]; then
cd $path


if [ -f $oldfile ]; then #file exists in folder
mv $oldfile ${purgatory_path}/$newfile
echo $oldfile
echo 'will be renamed as'
echo ${purgatory_path}/$newfile
fi

cd $repopath
fi



# for each incorrect bids_file, move to new folder called "ninth circle" (the ninth circle of hell)

cd $repopath

path="/projects/sanlab/shared/REV/bids_data/sub-REV003/ses-wave1/func/"
wrongfile="sub-REV003_ses-wave1_task-gng_acq-2_run-02_bold.nii.gz"
newpath=${ninth_circle_path} # We did not move the wrong bids files to the tmp folder because some of them would 
#likely overwrite existing tmp folder. Instead they are going to the ninth circle of hell.
if [ -d $path ]; then
cd $path


if [ -f $wrongfile ]; then #file exists in folder
mv $wrongfile ${newpath}
echo $wrongfile
echo 'will be moved to'
echo ${newpath}
fi

cd $repopath
fi


# for each re-named purgatory file, move the file to bids_path folder

cd $repopath

path=$purgatory_path
renamedfile="sub-REV003_ses-wave1_task-gng_acq-2_run-02_bold.nii.gz"
newpath="/projects/sanlab/shared/REV/bids_data/sub-REV003/ses-wave1/func/"
if [ -d $path ]; then
cd $path


if [ -f $renamedfile ]; then #file exists in folder
mv $renamedfile ${newpath}
echo $renamedfile
echo 'will be moved to'
echo ${newpath}
fi

cd $repopath
fi







# for value in file_size_bids_paths.txt; do
# echo $value
# done

# for value in $1/file_size_bids_paths.txt; do
# echo $name
# done


# for i in $( ls ); do
#             echo item: $i
#         done

# # Rename all GNG files to format ID_run
# for file in $(ls *.mat)
#     do
#         new=$(echo "$file" | sed -E 's/_REV//')
#         mv $file $new
# done

# for file in $(ls *.mat)
#     do
#         new=$(echo "$file" | sed -E 's/.{22}\.mat/.mat/')
#         mv $file $new
# done






# For each file in purgatory, 

# cd into bids_data folder 

# for each wild card name, search recursively through bids_data folder, get the bids_data file name, replace the file in purgatory folder with this file name, then move the bids_data file into `tmp_dcm2bids`




## GENERAL NOTE: MAKE SURE YOU CHECK THE NOTES IN THE FOLLOWING GOOGLE SHEET TO MAKE SURE YOU ACCOUNT FOR THE FEW CASES THAT WERE MISNAMED
# https://docs.google.com/spreadsheets/d/1AXgCxuoqd-vQo6LJVRDfbUmjEf0OQpV3eZ5AXC9pkNM/edit#gid=0