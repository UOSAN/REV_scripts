%-----------------------------------------------------------------------
% Job saved on 06-Dec-2018 14:28:50 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------

%% select acq-1 files
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/bids_data/derivatives/fmriprep/sub-REV001/ses-wave1/func'};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-gng_acq-1_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz';
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% unzip the files
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-gng_acq-1_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;

%% expand the frames
matlabbatch{3}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{3}.spm.util.exp_frames.frames = Inf;

%% select acq-3 files
matlabbatch{4}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/bids_data/derivatives/fmriprep/sub-REV001/ses-wave2/func'};
matlabbatch{4}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave2_task-gng_acq-3_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz';
matlabbatch{4}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% unzip the files
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave2_task-gng_acq-3_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz)', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;

%% expand the frames
matlabbatch{6}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{6}.spm.util.exp_frames.frames = Inf;

%% select acq-4 files
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/bids_data/derivatives/fmriprep/sub-REV001/ses-wave2/func'};
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave2_task-gng_acq-4_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz';
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% unzip the files
matlabbatch{8}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave2_task-gng_acq-4_run-.*_bold_space-MNI152NLin2009cAsym_preproc.nii.gz)', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{8}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{8}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;

%% expand the frames
matlabbatch{9}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{8}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{9}.spm.util.exp_frames.frames = Inf;

%% Smoothing
matlabbatch{10}.spm.spatial.smooth.data(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{10}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{10}.spm.spatial.smooth.dtype = 0;
matlabbatch{10}.spm.spatial.smooth.im = 0;
matlabbatch{10}.spm.spatial.smooth.prefix = 's';

matlabbatch{11}.spm.spatial.smooth.data(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{11}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{11}.spm.spatial.smooth.dtype = 0;
matlabbatch{11}.spm.spatial.smooth.im = 0;
matlabbatch{11}.spm.spatial.smooth.prefix = 's';

matlabbatch{12}.spm.spatial.smooth.data(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{12}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{12}.spm.spatial.smooth.dtype = 0;
matlabbatch{12}.spm.spatial.smooth.im = 0;
matlabbatch{12}.spm.spatial.smooth.prefix = 's';

%% %% select brain mask file
matlabbatch{13}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/fmriprep/sub-REV001/ses-wave1/func'};
matlabbatch{13}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'sub-REV001_ses-wave1_task-gng_acq-.*_run-01_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz';
matlabbatch{13}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% unzip the files
matlabbatch{14}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (sub-REV001_ses-wave1_task-gng_acq-.*_run-01_bold_space-MNI152NLin2009cAsym_brainmask.nii.gz)', substruct('.','val', '{}',{13}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{14}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{14}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;

%% expand the frames
matlabbatch{15}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{14}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{15}.spm.util.exp_frames.frames = Inf;

%% select auto_motion output
matlabbatch{16}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/fmriprep_backup/2018.09.06_auto_motion_output_backup/rp_txt'};
matlabbatch{16}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'rp_REV001_1_gng_1.txt';
matlabbatch{16}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

matlabbatch{17}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/fmriprep_backup/2018.09.06_auto_motion_output_backup/rp_txt'};
matlabbatch{17}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'rp_REV001_2_gng_3.txt';
matlabbatch{17}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

matlabbatch{18}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/REV/fmriprep_backup/2018.09.06_auto_motion_output_backup/rp_txt'};
matlabbatch{18}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'rp_REV001_2_gng_4.txt';
matlabbatch{18}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';

%% specify the model
matlabbatch{19}.spm.stats.fmri_spec.dir = {'/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV001/fx/gng'};
matlabbatch{19}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{19}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{19}.spm.stats.fmri_spec.timing.fmri_t = 72;
matlabbatch{19}.spm.stats.fmri_spec.timing.fmri_t0 = 36;

matlabbatch{19}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{10}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{19}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(1).multi = {'/projects/sanlab/shared/REV/REV_BxData/names_onsets_durations/gng/prepost_analysis/sub-REV001_task-gng_acq-1_onsets.mat'};
matlabbatch{19}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(1).multi_reg(1) = cfg_dep('File Selector (Batch Mode): Selected Files (rp_REV001_1_gng_1.txt)', substruct('.','val', '{}',{16}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{19}.spm.stats.fmri_spec.sess(1).hpf = 128;

matlabbatch{19}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{11}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{19}.spm.stats.fmri_spec.sess(2).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(2).multi = {'/projects/sanlab/shared/REV/REV_BxData/names_onsets_durations/gng/prepost_analysis/sub-REV001_task-gng_acq-3_onsets.mat'};
matlabbatch{19}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(2).multi_reg = cfg_dep('File Selector (Batch Mode): Selected Files (rp_REV001_1_gng_3.txt)', substruct('.','val', '{}',{17}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{19}.spm.stats.fmri_spec.sess(2).hpf = 128;

matlabbatch{19}.spm.stats.fmri_spec.sess(3).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{12}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{19}.spm.stats.fmri_spec.sess(3).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(3).multi = {'/projects/sanlab/shared/REV/REV_BxData/names_onsets_durations/gng/prepost_analysis/sub-REV001_task-gng_acq-4_onsets.mat'};
matlabbatch{19}.spm.stats.fmri_spec.sess(3).regress = struct('name', {}, 'val', {});
matlabbatch{19}.spm.stats.fmri_spec.sess(3).multi_reg = cfg_dep('File Selector (Batch Mode): Selected Files (rp_REV001_1_gng_4.txt)', substruct('.','val', '{}',{18}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{19}.spm.stats.fmri_spec.sess(3).hpf = 128;

matlabbatch{19}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{19}.spm.stats.fmri_spec.bases.hrf.derivs = [1 0];
matlabbatch{19}.spm.stats.fmri_spec.volt = 1;
matlabbatch{19}.spm.stats.fmri_spec.global = 'None';
matlabbatch{19}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{19}.spm.stats.fmri_spec.mask(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{15}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{19}.spm.stats.fmri_spec.cvi = 'AR(1)';

%% estimate the model (i.e. solve for the betas)
matlabbatch{20}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{19}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{20}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{20}.spm.stats.fmri_est.method.Classical = 1;

%% specify the contrasts of interest
matlabbatch{21}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{20}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{21}.spm.stats.con.consess{1}.tcon.name = '1_NoGo>Go';
matlabbatch{21}.spm.stats.con.consess{1}.tcon.weights = [0.0000	0.0000	-0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	0.1250	0.0000	0.0000	0.0000	-0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	0.0000	0.0000	-0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000];
matlabbatch{21}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

matlabbatch{21}.spm.stats.con.consess{2}.tcon.name = '2_CorrectNoGo>CorrectGo';
matlabbatch{21}.spm.stats.con.consess{2}.tcon.weights = [0.0000	0.0000	-0.2500	0.0000	0.2500	0.0000	-0.2500	0.0000	0.2500	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	-0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	-0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000];
matlabbatch{21}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

matlabbatch{21}.spm.stats.con.consess{3}.tcon.name = '3_IncorrectNoGo>CorrectGo';
matlabbatch{21}.spm.stats.con.consess{3}.tcon.weights = [0.0000	0.0000	-0.2500	0.0000	0.0000	0.0000	0.2500	0.0000	0.0000	0.0000	0.0000	0.0000	0.2500	0.0000	0.0000	0.0000	-0.2500	0.0000	0.0000	0.0000	-0.1250	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	-0.1250	0.0000	0.0000	0.0000	-0.1250	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	-0.1250	0.0000];
matlabbatch{21}.spm.stats.con.consess{3}.tcon.sessrep = 'none';

matlabbatch{21}.spm.stats.con.consess{4}.tcon.name = '4_Risk>Neutral';
matlabbatch{21}.spm.stats.con.consess{4}.tcon.weights = [0.0000	0.0000	0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	-0.1250	0.0000	0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	-0.1250	0.0000	0.0000	0.0000	0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	-0.0625	0.0000	0.0000	0.0000	0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	-0.0625	0.0000];
matlabbatch{21}.spm.stats.con.consess{4}.tcon.sessrep = 'none';

matlabbatch{21}.spm.stats.con.consess{5}.tcon.name = '5_CorrectNoGo>IncorrectNogo';
matlabbatch{21}.spm.stats.con.consess{5}.tcon.weights = [0.0000	0.0000	0.0000	0.0000	0.2500	0.0000	0.2500	0.0000	0.0000	0.0000	0.0000	0.0000	-0.2500	0.0000	0.0000	0.0000	-0.2500	0.0000	0.0000	0.0000	0.0000	0.0000	0.1250	0.0000	0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	-0.1250	0.0000	0.0000	0.0000	-0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	0.1250	0.0000	0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	-0.1250	0.0000	0.0000	0.0000	-0.1250	0.0000];
matlabbatch{21}.spm.stats.con.consess{5}.tcon.sessrep = 'none';

matlabbatch{21}.spm.stats.con.consess{6}.tcon.name = '6_NoButtonPress>Baseline';
matlabbatch{21}.spm.stats.con.consess{6}.tcon.weights = [0.0000	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	0.1250	0.0000	0.1250	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0625	0.0000	0.0000	0.0000	0.0625	0.0000	0.0625	0.0000	0.0000	0.0000	0.0625	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0625	0.0000	0.0000	0.0000	0.0625	0.0000	0.0625	0.0000	0.0000	0.0000	0.0625	0.0000	0.0000	0.0000];
matlabbatch{21}.spm.stats.con.consess{6}.tcon.sessrep = 'none';

matlabbatch{21}.spm.stats.con.consess{7}.tcon.name = '7_ButtonPress>Baseline';
matlabbatch{21}.spm.stats.con.consess{7}.tcon.weights = [0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	0.0625	0.0000	0.0000	0.0000	0.0625	0.0000	0.0000	0.0000	0.0000	0.0000	0.0625	0.0000	0.0000	0.0000	0.0625	0.0000	0.0000	0.0000	0.0625	0.0000	0.0000	0.0000	0.0625	0.0000	0.0000	0.0000	0.0000	0.0000	0.0625	0.0000	0.0000	0.0000	0.0625	0.0000];
matlabbatch{21}.spm.stats.con.consess{7}.tcon.sessrep = 'none';

matlabbatch{21}.spm.stats.con.consess{8}.tcon.name = '8_T2(NoGo>Go)>T1(NoGo>Go)';
matlabbatch{21}.spm.stats.con.consess{8}.tcon.weights = [0.0000	0.0000	-0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	0.1250	0.0000	0.0000	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0000	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000];
matlabbatch{21}.spm.stats.con.consess{8}.tcon.sessrep = 'none';

matlabbatch{21}.spm.stats.con.consess{9}.tcon.name = '9_T2(CorrectNoGo>CorrectGo)>T1(CorrectNoGo>CorrectGo)';
matlabbatch{21}.spm.stats.con.consess{9}.tcon.weights = [0.0000	0.0000	-0.2500	0.0000	0.2500	0.0000	-0.2500	0.0000	0.2500	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.1250	0.0000	-0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.1250	0.0000	-0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000	0.0000];
matlabbatch{21}.spm.stats.con.consess{9}.tcon.sessrep = 'none';

matlabbatch{21}.spm.stats.con.consess{10}.tcon.name = '10_T2(IncorrectNoGo>CorrectGo)>T1(IncorrectNoGo>CorrectGo)';
matlabbatch{21}.spm.stats.con.consess{10}.tcon.weights = [0.0000	0.0000	-0.2500	0.0000	0.0000	0.0000	0.2500	0.0000	0.0000	0.0000	0.0000	0.0000	0.2500	0.0000	0.0000	0.0000	-0.2500	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	-0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	-0.1250	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	-0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	-0.1250	0.0000	0.0000	0.0000	0.1250	0.0000];
matlabbatch{21}.spm.stats.con.consess{10}.tcon.sessrep = 'none';

matlabbatch{21}.spm.stats.con.consess{11}.tcon.name = '11_T2(Risk>Neutral)>T1(Risk>Neutral)';
matlabbatch{21}.spm.stats.con.consess{11}.tcon.weights = [0.0000	0.0000	0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	-0.1250	0.0000	0.1250	0.0000	0.1250	0.0000	-0.1250	0.0000	-0.1250	0.0000	0.0000	0.0000	-0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	0.0625	0.0000	0.0000	0.0000	-0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	0.0625	0.0000	-0.0625	0.0000	-0.0625	0.0000	0.0625	0.0000	0.0625	0.0000];
matlabbatch{21}.spm.stats.con.consess{11}.tcon.sessrep = 'none';

matlabbatch{21}.spm.stats.con.consess{12}.tcon.name = '12_T2(CorrectNoGo>IncorrectNogo)>T1(CorrectNoGo>IncorrectNogo)';
matlabbatch{21}.spm.stats.con.consess{12}.tcon.weights = [0.0000	0.0000	0.0000	0.0000	0.2500	0.0000	0.2500	0.0000	0.0000	0.0000	0.0000	0.0000	-0.2500	0.0000	0.0000	0.0000	-0.2500	0.0000	0.0000	0.0000	0.0000	0.0000	-0.1250	0.0000	-0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	-0.1250	0.0000	-0.1250	0.0000	0.0000	0.0000	0.0000	0.0000	0.1250	0.0000	0.0000	0.0000	0.1250	0.0000];
matlabbatch{21}.spm.stats.con.consess{12}.tcon.sessrep = 'none';
matlabbatch{21}.spm.stats.con.delete = 0;

