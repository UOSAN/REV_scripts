%-----------------------------------------------------------------------
% Job saved on 10-Aug-2018 15:01:33 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files = {
                                                                       '/Users/brendancullen/Desktop/sub-REV001_React_data/sub-REV001_ses-wave1_task-react_acq-1_run-01_bold_space-MNI152NLin2009cAsym_preproc.nii.gz'
                                                                       '/Users/brendancullen/Desktop/sub-REV001_React_data/sub-REV001_ses-wave1_task-react_acq-2_run-02_bold_space-MNI152NLin2009cAsym_preproc.nii.gz'
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
matlabbatch{4}.spm.stats.fmri_spec.dir = {'/Users/brendancullen/Desktop/REV/REV_scripts/fMRI/fx/React/output'};
matlabbatch{4}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{4}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{4}.spm.stats.fmri_spec.timing.fmri_t = 72;
matlabbatch{4}.spm.stats.fmri_spec.timing.fmri_t0 = 36;
matlabbatch{4}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{4}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{4}.spm.stats.fmri_spec.sess(1).multi = {'/Users/brendancullen/Desktop/REV/REV_scripts/behavioral/React/data/vecs/REV001_run1_onsets.mat'};
matlabbatch{4}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{4}.spm.stats.fmri_spec.sess(1).multi_reg = {'/Users/brendancullen/Desktop/sub-REV001_React_data/sub-REV001_ses-wave1_task-react_acq-1_run-01_bold_confounds.txt'};
matlabbatch{4}.spm.stats.fmri_spec.sess(1).hpf = 128;
%%
matlabbatch{4}.spm.stats.fmri_spec.sess(2).scans = {
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,1'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,2'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,3'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,4'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,5'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,6'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,7'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,8'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,9'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,10'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,11'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,12'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,13'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,14'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,15'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,16'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,17'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,18'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,19'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,20'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,21'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,22'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,23'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,24'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,25'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,26'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,27'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,28'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,29'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,30'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,31'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,32'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,33'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,34'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,35'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,36'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,37'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,38'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,39'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,40'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,41'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,42'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,43'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,44'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,45'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,46'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,47'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,48'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,49'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,50'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,51'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,52'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,53'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,54'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,55'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,56'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,57'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,58'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,59'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,60'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,61'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,62'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,63'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,64'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,65'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,66'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,67'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,68'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,69'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,70'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,71'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,72'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,73'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,74'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,75'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,76'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,77'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,78'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,79'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,80'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,81'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,82'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,83'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,84'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,85'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,86'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,87'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,88'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,89'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,90'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,91'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,92'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,93'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,94'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,95'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,96'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,97'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,98'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,99'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,100'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,101'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,102'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,103'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,104'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,105'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,106'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,107'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,108'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,109'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,110'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,111'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,112'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,113'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,114'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,115'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,116'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,117'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,118'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,119'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,120'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,121'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,122'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,123'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,124'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,125'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,126'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,127'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,128'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,129'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,130'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,131'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,132'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,133'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,134'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,135'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,136'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,137'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,138'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,139'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,140'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,141'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,142'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,143'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,144'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,145'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,146'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,147'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,148'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,149'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,150'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,151'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,152'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,153'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,154'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,155'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,156'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,157'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,158'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,159'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,160'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,161'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,162'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,163'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,164'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,165'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,166'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,167'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,168'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,169'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,170'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,171'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,172'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,173'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,174'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,175'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,176'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,177'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,178'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,179'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,180'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,181'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,182'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,183'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,184'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,185'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,186'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,187'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,188'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,189'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,190'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,191'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,192'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,193'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,194'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,195'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,196'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,197'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,198'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,199'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,200'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,201'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,202'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,203'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,204'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,205'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,206'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,207'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,208'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,209'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,210'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,211'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,212'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,213'
                                                    '/Users/brendancullen/Desktop/sub-REV001_ses-wave1_task-sst_acq-1_run-01_bold_space-T1w_preproc.nii,214'
                                                    };
%%
matlabbatch{4}.spm.stats.fmri_spec.sess(2).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{4}.spm.stats.fmri_spec.sess(2).multi = {'/Users/brendancullen/Desktop/REV/REV_scripts/behavioral/React/data/vecs/REV001_run2_onsets.mat'};
matlabbatch{4}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{4}.spm.stats.fmri_spec.sess(2).multi_reg = {'/Users/brendancullen/Desktop/sub-REV001_React_data/sub-REV001_ses-wave1_task-react_acq-2_run-02_bold_confounds.txt'};
matlabbatch{4}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{4}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{4}.spm.stats.fmri_spec.bases.hrf.derivs = [1 0];
matlabbatch{4}.spm.stats.fmri_spec.volt = 1;
matlabbatch{4}.spm.stats.fmri_spec.global = 'None';
matlabbatch{4}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{4}.spm.stats.fmri_spec.mask = {'/Users/brendancullen/Desktop/sub-REV001_T1w_space-MNI152NLin2009cAsym_brainmask.nii,1'};
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
