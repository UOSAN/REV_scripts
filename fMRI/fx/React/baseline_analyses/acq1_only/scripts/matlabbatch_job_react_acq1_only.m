%-----------------------------------------------------------------------
% Job saved on 15-Sep-2018 15:34:32 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/fmriprep_backup/2018.09.06_rev_fmriprep_backup/sub-REV001/ses-wave1/func'};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-react_acq-1_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz';
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-react_acq-1_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;
matlabbatch{3}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{3}.spm.util.exp_frames.frames = Inf;
matlabbatch{4}.spm.spatial.smooth.data(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{4}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{4}.spm.spatial.smooth.dtype = 0;
matlabbatch{4}.spm.spatial.smooth.im = 0;
matlabbatch{4}.spm.spatial.smooth.prefix = 's';
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/fmriprep_backup/2018.09.06_rev_fmriprep_backup/sub-REV001/ses-wave1/func'};
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-react_acq-1_run-.*_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz';
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{6}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-react_acq-1_run-.*_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz)', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{6}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{6}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;
matlabbatch{7}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{7}.spm.util.exp_frames.frames = Inf;
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/bids_data/derivatives/motion'};
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-react_acq-1_run-.*_bold_confounds.txt';
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{9}.spm.stats.fmri_spec.dir = {'/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV001/fx/react'};
matlabbatch{9}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{9}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{9}.spm.stats.fmri_spec.timing.fmri_t = 72;
matlabbatch{9}.spm.stats.fmri_spec.timing.fmri_t0 = 36;
matlabbatch{9}.spm.stats.fmri_spec.sess.scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{9}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{9}.spm.stats.fmri_spec.sess.multi = {'/projects/sanlab/shared/REV/REV_BxData/names_onsets_durations/react/sub-REV001_task-react_acq-1_onsets.mat'};
matlabbatch{9}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{9}.spm.stats.fmri_spec.sess.multi_reg(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-react_acq-1_run-.*_bold_confounds.txt)', substruct('.','val', '{}',{8}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{9}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{9}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{9}.spm.stats.fmri_spec.bases.hrf.derivs = [1 0];
matlabbatch{9}.spm.stats.fmri_spec.volt = 1;
matlabbatch{9}.spm.stats.fmri_spec.global = 'None';
matlabbatch{9}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{9}.spm.stats.fmri_spec.mask(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{9}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{10}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{10}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{10}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{11}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{10}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{11}.spm.stats.con.consess{1}.tcon.name = '1_PRC>Neutral';
matlabbatch{11}.spm.stats.con.consess{1}.tcon.weights = [1 0 -1 0 0 0];
matlabbatch{11}.spm.stats.con.consess{1}.tcon.sessrep = 'replsc';
matlabbatch{11}.spm.stats.con.consess{2}.tcon.name = '2_Neutral>ImpBaseline';
matlabbatch{11}.spm.stats.con.consess{2}.tcon.weights = [0 0 1 0 0 0];
matlabbatch{11}.spm.stats.con.consess{2}.tcon.sessrep = 'replsc';
matlabbatch{11}.spm.stats.con.consess{3}.tcon.name = '3_PRC>ImpBaseline';
matlabbatch{11}.spm.stats.con.consess{3}.tcon.weights = [1 0 0 0 0 0];
matlabbatch{11}.spm.stats.con.consess{3}.tcon.sessrep = 'replsc';
matlabbatch{11}.spm.stats.con.consess{4}.tcon.name = '4_Rating>ImpBaseline';
matlabbatch{11}.spm.stats.con.consess{4}.tcon.weights = [0 0 0 0 1 0];
matlabbatch{11}.spm.stats.con.consess{4}.tcon.sessrep = 'replsc';
matlabbatch{11}.spm.stats.con.consess{5}.tcon.name = '5_Rating>View';
matlabbatch{11}.spm.stats.con.consess{5}.tcon.weights = [-0.5 0 -0.5 0 1 0];
matlabbatch{11}.spm.stats.con.consess{5}.tcon.sessrep = 'replsc';
matlabbatch{11}.spm.stats.con.delete = 0;
