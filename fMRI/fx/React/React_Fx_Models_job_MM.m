%-----------------------------------------------------------------------
% Job saved on 10-Aug-2018 15:01:33 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
dataDir='/Users/brendancullen/Desktop/';

matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files = {
                                                                       [dataDir 'sub-REV001_React_data/sub-REV001_ses-wave1_task-react_acq-1_run-01_bold_space-MNI152NLin2009cAsym_preproc.nii.gz']
                                                                       [dataDir 'sub-REV001_React_data/sub-REV001_ses-wave1_task-react_acq-2_run-02_bold_space-MNI152NLin2009cAsym_preproc.nii.gz']
                                                                       };
matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;
matlabbatch{2}.spm.util.split.vol(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{2}.spm.util.split.outdir = {''};
matlabbatch{3}.spm.spatial.smooth.data(1) = cfg_dep('4D to 3D File Conversion: Series of 3D Volumes', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','splitfiles'));
matlabbatch{3}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{3}.spm.spatial.smooth.dtype = 0;
matlabbatch{3}.spm.spatial.smooth.im = 0;
matlabbatch{3}.spm.spatial.smooth.prefix = 's';
matlabbatch{4}.spm.stats.fmri_spec.dir = {[dataDir 'REV/REV_scripts/fMRI/fx/React/output']};
matlabbatch{4}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{4}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{4}.spm.stats.fmri_spec.timing.fmri_t = 72;
matlabbatch{4}.spm.stats.fmri_spec.timing.fmri_t0 = 36;
matlabbatch{4}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{4}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{4}.spm.stats.fmri_spec.sess(1).multi = {[dataDir 'REV/REV_scripts/behavioral/React/data/vecs/REV001_run1_onsets.mat']};
matlabbatch{4}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{4}.spm.stats.fmri_spec.sess(1).multi_reg = {[dataDir 'sub-REV001_React_data/sub-REV001_ses-wave1_task-react_acq-1_run-01_bold_confounds.txt']};
matlabbatch{4}.spm.stats.fmri_spec.sess(1).hpf = 128;
%%
matlabbatch{4}.spm.stats.fmri_spec.sess(2).scans = {
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,1']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,2']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,3']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,4']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,5']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,6']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,7']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,8']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,9']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,10']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,11']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,12']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,13']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,14']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,15']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,16']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,17']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,18']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,19']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,20']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,21']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,22']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,23']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,24']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,25']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,26']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,27']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,28']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,29']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,30']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,31']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,32']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,33']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,34']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,35']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,36']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,37']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,38']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,39']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,40']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,41']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,42']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,43']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,44']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,45']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,46']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,47']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,48']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,49']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,50']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,51']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,52']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,53']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,54']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,55']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,56']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,57']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,58']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,59']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,60']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,61']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,62']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,63']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,64']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,65']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,66']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,67']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,68']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,69']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,70']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,71']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,72']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,73']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,74']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,75']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,76']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,77']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,78']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,79']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,80']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,81']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,82']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,83']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,84']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,85']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,86']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,87']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,88']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,89']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,90']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,91']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,92']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,93']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,94']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,95']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,96']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,97']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,98']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,99']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,100']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,101']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,102']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,103']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,104']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,105']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,106']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,107']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,108']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,109']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,110']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,111']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,112']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,113']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,114']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,115']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,116']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,117']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,118']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,119']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,120']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,121']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,122']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,123']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,124']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,125']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,126']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,127']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,128']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,129']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,130']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,131']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,132']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,133']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,134']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,135']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,136']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,137']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,138']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,139']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,140']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,141']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,142']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,143']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,144']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,145']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,146']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,147']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,148']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,149']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,150']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,151']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,152']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,153']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,154']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,155']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,156']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,157']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,158']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,159']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,160']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,161']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,162']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,163']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,164']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,165']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,166']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,167']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,168']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,169']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,170']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,171']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,172']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,173']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,174']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,175']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,176']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,177']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,178']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,179']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,180']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,181']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,182']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,183']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,184']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,185']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,186']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,187']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,188']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,189']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,190']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,191']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,192']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,193']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,194']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,195']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,196']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,197']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,198']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,199']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,200']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,201']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,202']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,203']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,204']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,205']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,206']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,207']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,208']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,209']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,210']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,211']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,212']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,213']
                                                    [dataDir 'sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,214']
                                                    };
%%
matlabbatch{4}.spm.stats.fmri_spec.sess(2).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{4}.spm.stats.fmri_spec.sess(2).multi = {[dataDir 'REV/REV_scripts/behavioral/React/data/vecs/REV001_run2_onsets.mat']};
matlabbatch{4}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{4}.spm.stats.fmri_spec.sess(2).multi_reg = {[dataDir 'sub-REV001_React_data/sub-REV001_ses-wave1_task-react_acq-2_run-02_bold_confounds.txt']};
matlabbatch{4}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{4}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{4}.spm.stats.fmri_spec.bases.hrf.derivs = [1 0];
matlabbatch{4}.spm.stats.fmri_spec.volt = 1;
matlabbatch{4}.spm.stats.fmri_spec.global = 'None';
matlabbatch{4}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{4}.spm.stats.fmri_spec.mask = {[dataDir 'sub-REV001_T1w_space-MNI152NLin2009cAsym_brainmask.nii,1']};
matlabbatch{4}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{5}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{5}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{5}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{6}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{6}.spm.stats.con.consess{1}.tcon.name = '1_PRC>Neutral';
matlabbatch{6}.spm.stats.con.consess{1}.tcon.weights = [1 -1];
matlabbatch{6}.spm.stats.con.consess{1}.tcon.sessrep = 'replsc';
matlabbatch{6}.spm.stats.con.consess{2}.tcon.name = '2_Neutral>ImpBaseline';
matlabbatch{6}.spm.stats.con.consess{2}.tcon.weights = [0 1];
matlabbatch{6}.spm.stats.con.consess{2}.tcon.sessrep = 'replsc';
matlabbatch{6}.spm.stats.con.consess{3}.tcon.name = '3_PRC>ImpBaseline';
matlabbatch{6}.spm.stats.con.consess{3}.tcon.weights = [1 0];
matlabbatch{6}.spm.stats.con.consess{3}.tcon.sessrep = 'replsc';
matlabbatch{6}.spm.stats.con.delete = 0;
