# Replace wrong-sized bids_data files with correct-sized tmp files

# Get list of full file paths for tmp files and bids files

sub_list_path="/projects/sanlab/shared/REV/REV_scripts/org/dcm2bids"
derivatives_path="/projects/sanlab/shared/REV/bids_data/derivatives"

declare -a bids_files_array
readarray -t bids_files_array < $sub_list_path/sub_list_wrong_sizes.txt

cd $sub_list_path
num=`grep -c $ sub_list_wrong_sizes.txt`

cd $derivatives_path

for i in $(seq 0 $num); do
	#rm -Rf *${bids_files_array[i]}*

echo ${bids_files_array[i]}
echo 'will be removed from derivatives'

cd $derivatives_path
done