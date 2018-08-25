%-----------------------------------------------------------------------
% Job saved on 15-Aug-2018 14:05:36 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------

%% select acq-1 files
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/bids_data/derivatives/fmriprep/sub-REV001/ses-wave1/func'};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-react_acq-1_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz';
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% unzip the files
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-react_acq-1_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;

%% expand the frames
matlabbatch{3}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{3}.spm.util.exp_frames.frames = Inf;

%% select acq-2 files
matlabbatch{4}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/bids_data/derivatives/fmriprep/sub-REV001/ses-wave1/func'};
matlabbatch{4}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-react_acq-2_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz';
matlabbatch{4}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% unzip the files
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-react_acq-2_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz)', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;

%% expand the frames
matlabbatch{6}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{6}.spm.util.exp_frames.frames = Inf;

%% smooth acq-1
matlabbatch{7}.spm.spatial.smooth.data(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{7}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{7}.spm.spatial.smooth.dtype = 0;
matlabbatch{7}.spm.spatial.smooth.im = 0;
matlabbatch{7}.spm.spatial.smooth.prefix = 's';

%% smooth acq-2
matlabbatch{8}.spm.spatial.smooth.data(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{8}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{8}.spm.spatial.smooth.dtype = 0;
matlabbatch{8}.spm.spatial.smooth.im = 0;
matlabbatch{8}.spm.spatial.smooth.prefix = 's';

%% select brain mask file for acq-1. 
%NOTE: Only specifying brainmask from run-01 since they should be the same for every run (i.e. it is a standard brain mask). 
%Using run-01 instead acq-1 to make more robust.
matlabbatch{9}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/bids_data/derivatives/fmriprep/sub-REV001/ses-wave1/func'};
matlabbatch{9}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-react_acq-.*_run-01_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz'; 
matlabbatch{9}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% unzip the files
matlabbatch{10}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-react_acq-1_run-.*_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz)', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{10}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{10}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;

%% expand the frames
matlabbatch{11}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{10}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{11}.spm.util.exp_frames.frames = Inf;

%% select motion confounds file for acq-1. NOTE: these confounds files are created by subset_confounds.R
matlabbatch{12}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/REV_scripts/fMRI/ppc/motion'};
matlabbatch{12}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-react_acq-1_run-.*_bold_confounds.txt';
matlabbatch{12}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{13}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/REV_scripts/fMRI/ppc/motion'};
matlabbatch{13}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-react_acq-2_run-.*_bold_confounds.txt';
matlabbatch{13}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% specify the model
matlabbatch{14}.spm.stats.fmri_spec.dir = {'/projects/sanlab/shared/REV/nonbids_data/fmri/fx/models/react/sub-REV001'};
matlabbatch{14}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{14}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{14}.spm.stats.fmri_spec.timing.fmri_t = 72;
matlabbatch{14}.spm.stats.fmri_spec.timing.fmri_t0 = 36;
matlabbatch{14}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{14}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{14}.spm.stats.fmri_spec.sess(1).multi = {'/projects/sanlab/shared/REV/REV_scripts/behavioral/React/data/vecs/REV001_acq1_onsets.mat'};
matlabbatch{14}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{14}.spm.stats.fmri_spec.sess(1).multi_reg(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-react_acq-1_run-.*_bold_confounds.txt)', substruct('.','val', '{}',{12}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{14}.spm.stats.fmri_spec.sess(1).hpf = 128;
matlabbatch{14}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{8}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{14}.spm.stats.fmri_spec.sess(2).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{14}.spm.stats.fmri_spec.sess(2).multi = {'/projects/sanlab/shared/REV/REV_scripts/behavioral/React/data/vecs/REV001_acq2_onsets.mat'};
matlabbatch{14}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{14}.spm.stats.fmri_spec.sess(2).multi_reg(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-react_acq-2_run-.*_bold_confounds.txt)', substruct('.','val', '{}',{13}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{14}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{14}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{14}.spm.stats.fmri_spec.bases.hrf.derivs = [1 0];
matlabbatch{14}.spm.stats.fmri_spec.volt = 1;
matlabbatch{14}.spm.stats.fmri_spec.global = 'None';
matlabbatch{14}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{14}.spm.stats.fmri_spec.mask(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{11}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{14}.spm.stats.fmri_spec.cvi = 'AR(1)';

%% estimate the model (i.e. solve for the betas)
matlabbatch{15}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{14}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{15}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{15}.spm.stats.fmri_est.method.Classical = 1;

%% specify the contrasts of interest
matlabbatch{16}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{15}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{16}.spm.stats.con.consess{1}.tcon.name = '1_PRC>Neutral';
matlabbatch{16}.spm.stats.con.consess{1}.tcon.weights = [1 0 -1 0 0 0];
matlabbatch{16}.spm.stats.con.consess{1}.tcon.sessrep = 'replsc';
matlabbatch{16}.spm.stats.con.consess{2}.tcon.name = '2_Neutral>ImpBaseline';
matlabbatch{16}.spm.stats.con.consess{2}.tcon.weights = [0 0 1 0 0 0];
matlabbatch{16}.spm.stats.con.consess{2}.tcon.sessrep = 'replsc';
matlabbatch{16}.spm.stats.con.consess{3}.tcon.name = '3_PRC>ImpBaseline';
matlabbatch{16}.spm.stats.con.consess{3}.tcon.weights = [1 0 0 0 0 0];
matlabbatch{16}.spm.stats.con.consess{3}.tcon.sessrep = 'replsc';
matlabbatch{16}.spm.stats.con.consess{4}.tcon.name = '4_Rating>ImpBaseline';
matlabbatch{16}.spm.stats.con.consess{4}.tcon.weights = [0 0 0 0 1 0];
matlabbatch{16}.spm.stats.con.consess{4}.tcon.sessrep = 'replsc';
matlabbatch{16}.spm.stats.con.delete = 0;

%THIS IS THE ORIGINAL SET OF CONTRATS BEFORE ADDING "RATING"
% matlabbatch{16}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{15}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
% matlabbatch{16}.spm.stats.con.consess{1}.tcon.name = '1_PRC>Neutral';
% matlabbatch{16}.spm.stats.con.consess{1}.tcon.weights = [1 0 -1 0];
% matlabbatch{16}.spm.stats.con.consess{1}.tcon.sessrep = 'replsc';
% matlabbatch{16}.spm.stats.con.consess{2}.tcon.name = '2_Neutral>ImpBaseline';
% matlabbatch{16}.spm.stats.con.consess{2}.tcon.weights = [0 0 1 0];
% matlabbatch{16}.spm.stats.con.consess{2}.tcon.sessrep = 'replsc';
% matlabbatch{16}.spm.stats.con.consess{3}.tcon.name = '3_PRC>ImpBaseline';
% matlabbatch{16}.spm.stats.con.consess{3}.tcon.weights = [1 0 0 0];
% matlabbatch{16}.spm.stats.con.consess{3}.tcon.sessrep = 'replsc';
% matlabbatch{16}.spm.stats.con.delete = 0;
