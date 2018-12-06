%-----------------------------------------------------------------------
% Job saved on 15-Aug-2018 14:05:36 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------

%% select acq-1 files
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/Users/kristadestasio/Desktop/bids_data/derivatives/fmriprep/sub-REV001/ses-wave1/func'};
    %{'/projects/sanlab/shared/REV/bids_data/derivatives/fmriprep/sub-REV001/ses-wave1/func'};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-gng_acq-1_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz';
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% unzip the files
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-gng_acq-1_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;

%% expand the frames
matlabbatch{3}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{3}.spm.util.exp_frames.frames = Inf;

%% select acq-2 files
matlabbatch{4}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/Users/kristadestasio/Desktop/bids_data/derivatives/fmriprep/sub-REV001/ses-wave1/func'};
%{'/projects/sanlab/shared/REV/bids_data/derivatives/fmriprep/sub-REV001/ses-wave1/func'};
matlabbatch{4}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-gng_acq-2_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz';
matlabbatch{4}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% unzip the files
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-gng_acq-2_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz)', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;

%% expand the frames
matlabbatch{6}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{6}.spm.util.exp_frames.frames = Inf;

%% select acq-3 files
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/Users/kristadestasio/Desktop/bids_data/derivatives/fmriprep/sub-REV001/ses-wave2/func'};
%{'/projects/sanlab/shared/REV/bids_data/derivatives/fmriprep/sub-REV001/ses-wave1/func'};
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave2_task-gng_acq-3_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz';
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% unzip the files
matlabbatch{8}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave2_task-gng_acq-3_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz)', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{8}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{8}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;

%% expand the frames
matlabbatch{9}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{8}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{9}.spm.util.exp_frames.frames = Inf;

%% select acq-4 files
matlabbatch{10}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/Users/kristadestasio/Desktop/bids_data/derivatives/fmriprep/sub-REV001/ses-wave2/func'};
%{'/projects/sanlab/shared/REV/bids_data/derivatives/fmriprep/sub-REV001/ses-wave1/func'};
matlabbatch{10}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave2_task-gng_acq-4_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz';
matlabbatch{10}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% unzip the files
matlabbatch{11}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave2_task-gng_acq-4_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz)', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{11}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{11}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;

%% expand the frames
matlabbatch{12}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{11}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{12}.spm.util.exp_frames.frames = Inf;

%% smooth acq-1
matlabbatch{13}.spm.spatial.smooth.data(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{13}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{13}.spm.spatial.smooth.dtype = 0;
matlabbatch{13}.spm.spatial.smooth.im = 0;
matlabbatch{13}.spm.spatial.smooth.prefix = 's';

%% smooth acq-2
matlabbatch{14}.spm.spatial.smooth.data(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{14}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{14}.spm.spatial.smooth.dtype = 0;
matlabbatch{14}.spm.spatial.smooth.im = 0;
matlabbatch{14}.spm.spatial.smooth.prefix = 's';

%% smooth acq-3
matlabbatch{15}.spm.spatial.smooth.data(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{15}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{15}.spm.spatial.smooth.dtype = 0;
matlabbatch{15}.spm.spatial.smooth.im = 0;
matlabbatch{15}.spm.spatial.smooth.prefix = 's';

%% smooth acq-4
matlabbatch{16}.spm.spatial.smooth.data(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{12}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{16}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{16}.spm.spatial.smooth.dtype = 0;
matlabbatch{16}.spm.spatial.smooth.im = 0;
matlabbatch{16}.spm.spatial.smooth.prefix = 's';

%% select brain mask file for acq-1
%NOTE: Only specifying brainmask from run-01 since they should be the same for every run (i.e. it is a standard brain mask). 
matlabbatch{17}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/Users/kristadestasio/Desktop/bids_data/derivatives/fmriprep/sub-REV001/ses-wave1/func'};
%{'/projects/sanlab/shared/REV/bids_data/derivatives/fmriprep/sub-REV001/ses-wave1/func'};
matlabbatch{17}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-gng_acq-.*_run-01_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz'; 
matlabbatch{17}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% unzip the files
matlabbatch{18}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-gng_acq-.*_run-01_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz)', substruct('.','val', '{}',{17}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{18}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{18}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;

%% expand the frames
matlabbatch{19}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{18}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{19}.spm.util.exp_frames.frames = Inf;

%% select motion confounds file for acq-1. NOTE: these confounds files are created by subset_confounds.R
matlabbatch{20}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/Users/kristadestasio/Desktop/bids_data/derivatives/motion/rp_txt'};
%{'/projects/sanlab/shared/REV/bids_data/derivatives/motion'};
matlabbatch{20}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'rp_REV001_1_gng_1.txt';
matlabbatch{20}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

matlabbatch{21}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/Users/kristadestasio/Desktop/bids_data/derivatives/motion/rp_txt'};
%{'/projects/sanlab/shared/REV/bids_data/derivatives/motion'};
matlabbatch{21}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'rp_REV001_1_gng_2.txt';
matlabbatch{21}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

matlabbatch{22}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/Users/kristadestasio/Desktop/bids_data/derivatives/motion/rp_txt'};
%{'/projects/sanlab/shared/REV/bids_data/derivatives/motion'};
matlabbatch{22}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'rp_REV001_2_gng_3.txt';
matlabbatch{22}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

matlabbatch{23}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/Users/kristadestasio/Desktop/bids_data/derivatives/motion/rp_txt'};
%{'/projects/sanlab/shared/REV/bids_data/derivatives/motion'};
matlabbatch{23}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'rp_REV001_2_gng_4.txt';
matlabbatch{23}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% specify the model
matlabbatch{24}.spm.stats.fmri_spec.dir = {'/Users/kristadestasio/Desktop/bids_data/derivatives/prepost_analysis/sub-REV001/fx/gng'};
%{'/projects/sanlab/shared/REV/bids_data/derivatives/prepost_analysis/sub-REV001/fx/gng'};
matlabbatch{24}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{24}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{24}.spm.stats.fmri_spec.timing.fmri_t = 72;
matlabbatch{24}.spm.stats.fmri_spec.timing.fmri_t0 = 36;

matlabbatch{24}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{13}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{24}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{24}.spm.stats.fmri_spec.sess(1).multi = {'/Users/kristadestasio/Desktop/REV_BxData/names_onsets_durations/gng/prepost_analysis/sub-REV001_task-gng_acq-1_onsets.mat'};
%{'/projects/sanlab/shared/REV/REV_BxData/names_onsets_durations/gng/sub-REV001_task-gng_acq-1_onsets.mat'};
matlabbatch{24}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{24}.spm.stats.fmri_spec.sess(1).multi_reg(1) = cfg_dep('File Selector (Batch Mode): Selected Files (rp_REV001_1_gng_1.txt)', substruct('.','val', '{}',{20}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{24}.spm.stats.fmri_spec.sess(1).hpf = 128;

matlabbatch{24}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{14}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{24}.spm.stats.fmri_spec.sess(2).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{24}.spm.stats.fmri_spec.sess(2).multi = {'/Users/kristadestasio/Desktop/REV_BxData/names_onsets_durations/gng/prepost_analysis/sub-REV001_task-gng_acq-2_onsets.mat'};
%{'/projects/sanlab/shared/REV/REV_BxData/names_onsets_durations/gng/sub-REV001_task-gng_acq-2_onsets.mat'};
matlabbatch{24}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{24}.spm.stats.fmri_spec.sess(2).multi_reg(1) = cfg_dep('File Selector (Batch Mode): Selected Files (rp_REV001_1_gng_2.txt)', substruct('.','val', '{}',{21}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{24}.spm.stats.fmri_spec.sess(2).hpf = 128;
% 
% matlabbatch{24}.spm.stats.fmri_spec.sess(3).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{15}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
% matlabbatch{24}.spm.stats.fmri_spec.sess(3).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
% matlabbatch{24}.spm.stats.fmri_spec.sess(3).multi = {'/Users/kristadestasio/Desktop/REV_BxData/names_onsets_durations/gng/prepost_analysis/sub-REV001_task-gng_acq-3_onsets.mat'};
% %{'/projects/sanlab/shared/REV/REV_BxData/names_onsets_durations/gng/sub-REV001_task-gng_acq-2_onsets.mat'};
% matlabbatch{24}.spm.stats.fmri_spec.sess(3).regress = struct('name', {}, 'val', {});
% matlabbatch{24}.spm.stats.fmri_spec.sess(3).multi_reg(1) = cfg_dep('File Selector (Batch Mode): Selected Files (rp_REV001_2_gng_3.txt)', substruct('.','val', '{}',{22}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
% matlabbatch{24}.spm.stats.fmri_spec.sess(3).hpf = 128;
% 
% matlabbatch{24}.spm.stats.fmri_spec.sess(4).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{16}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
% matlabbatch{24}.spm.stats.fmri_spec.sess(4).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
% matlabbatch{24}.spm.stats.fmri_spec.sess(4).multi = {'/Users/kristadestasio/Desktop/REV_BxData/names_onsets_durations/gng/prepost_analysis/sub-REV001_task-gng_acq-4_onsets.mat'};
% %{'/projects/sanlab/shared/REV/REV_BxData/names_onsets_durations/gng/sub-REV001_task-gng_acq-2_onsets.mat'};
% matlabbatch{24}.spm.stats.fmri_spec.sess(4).regress = struct('name', {}, 'val', {});
% matlabbatch{24}.spm.stats.fmri_spec.sess(4).multi_reg(1) = cfg_dep('File Selector (Batch Mode): Selected Files (rp_REV001_2_gng_4.txt)', substruct('.','val', '{}',{23}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
% matlabbatch{24}.spm.stats.fmri_spec.sess(4).hpf = 128;

matlabbatch{24}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{24}.spm.stats.fmri_spec.bases.hrf.derivs = [1 0];
matlabbatch{24}.spm.stats.fmri_spec.volt = 1;
matlabbatch{24}.spm.stats.fmri_spec.global = 'None';
matlabbatch{24}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{24}.spm.stats.fmri_spec.mask(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{19}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{24}.spm.stats.fmri_spec.cvi = 'AR(1)';

%% estimate the model (i.e. solve for the betas)
matlabbatch{25}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{24}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{25}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{25}.spm.stats.fmri_est.method.Classical = 1;

%% specify the contrasts of interest
matlabbatch{26}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{25}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{26}.spm.stats.con.consess{1}.tcon.name = '1_NoGo>Go';
matlabbatch{26}.spm.stats.con.consess{1}.tcon.weights = [0 0 -0.25 0 0.25 0 -0.25 0 0.25 0 -0.25 0 0.25 0 -0.25 0 0.25 0];
matlabbatch{26}.spm.stats.con.consess{1}.tcon.sessrep = 'replsc';
matlabbatch{26}.spm.stats.con.consess{2}.tcon.name = '2_CorrectNoGo>CorrectGo';
matlabbatch{26}.spm.stats.con.consess{2}.tcon.weights = [0 0 -0.5 0 0.5 0 -0.5 0 0.5 0 0 0 0 0 0 0 0 0];
matlabbatch{26}.spm.stats.con.consess{2}.tcon.sessrep = 'replsc';
matlabbatch{26}.spm.stats.con.consess{3}.tcon.name = '3_IncorrectNoGo>CorrectGo';
matlabbatch{26}.spm.stats.con.consess{3}.tcon.weights = [0 0 -0.5 0 0 0 -0.5 0 0 0 0 0 0.5 0 0 0 0.5 0];
matlabbatch{26}.spm.stats.con.consess{3}.tcon.sessrep = 'replsc';
matlabbatch{26}.spm.stats.con.consess{4}.tcon.name = '4_Risk>Neutral';
matlabbatch{26}.spm.stats.con.consess{4}.tcon.weights = [0 0 0.25 0 0.25 0 -0.25 0 -0.25 0 0.25 0 0.25 0 -0.25 0 -0.25 0];
matlabbatch{26}.spm.stats.con.consess{4}.tcon.sessrep = 'replsc';
matlabbatch{26}.spm.stats.con.consess{5}.tcon.name = '5_CorrectNoGo>IncorrectNogo';
matlabbatch{26}.spm.stats.con.consess{5}.tcon.weights = [0 0 0 0 0.5 0 0.5 0 0 0 0 0 -0.5 0 0 0 -0.5 0];
matlabbatch{26}.spm.stats.con.consess{5}.tcon.sessrep = 'replsc';
matlabbatch{26}.spm.stats.con.consess{6}.tcon.name = '6_NoButtonPress>Baseline';
matlabbatch{26}.spm.stats.con.consess{6}.tcon.weights = [0 0 0 0 0.25 0 0 0 0.25 0 0.25 0 0 0 0.25 0 0 0];
matlabbatch{26}.spm.stats.con.consess{6}.tcon.sessrep = 'replsc';
matlabbatch{26}.spm.stats.con.consess{7}.tcon.name = '7_ButtonPress>Baseline';
matlabbatch{26}.spm.stats.con.consess{7}.tcon.weights = [0 0 0.25 0 0 0 0.25 0 0 0 0 0 0.25 0 0 0 0.25 0];
matlabbatch{26}.spm.stats.con.consess{7}.tcon.sessrep = 'replsc';
matlabbatch{26}.spm.stats.con.delete = 0;

%[POST (stop>go)] > [PRE(stop>go)]

% Stick a conditional in here that addresses 'if' missing (e.g.
% incorrect_go) then do a thing

% List order of conditions here...

% r1_c1 = [0 0 -0.25 0 0.25 0 -0.25 0 0.25 0 -0.25 0 0.25 0 -0.25 0 0.25 0];
% if length of names < x
% then r2_c1 = this -> [0 0 -0.25 0 0.25 0 -0.25 0 0.25 0 -0.25 0 0.25 0 -0.25 0 0.25 0] minus a pair or whatever;
% else r2_c1 = r1_c1

% Do that ^ for all the contrasts

% Build models/contrasts separately for people missing a run at a given timepoint <-
% worry about the models 1st