## BIDS conversion
Convert DICOMS to [BIDS](http://bids.neuroimaging.io/). More information about BIDS specifications can be found [here](http://bids.neuroimaging.io/bids_spec1.0.2.pdf).

### Key scripts
**`dcm2nii_batch.py`**
This script creates a conversion job for each subject in `subject_list.txt` and submits the job using sbatch. Dicoms are converted using the dcm2niix converter, which also creates JSON metadata files.

**`nii2dcm_batch.py`**
This script will create the BIDS files structure, and move and rename converted files to BIDS specification. It will also check the number of files and print errors to the error log.