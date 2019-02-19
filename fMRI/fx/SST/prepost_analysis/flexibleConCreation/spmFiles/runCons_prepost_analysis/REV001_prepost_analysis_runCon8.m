%-----------------------------------------------------------------------
% Job saved on 18-Jan-2019 10:03:08 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.var_ops.load_vars.matname = {'/projects/sanlab/shared/REV/REV_scripts/fMRI/fx/SST/prepost_analysis/flexibleConCreation/customCons/sst/prepost_analysis/customContrasts_sub-REV001_sst_prepost_analysis.mat'};
matlabbatch{1}.cfg_basicio.var_ops.load_vars.loadvars.varname = {
                                                                 'contrastNames'
                                                                 'contrastCellArray'
                                                                 }';
matlabbatch{2}.cfg_basicio.var_ops.subsrefvar.input(1) = cfg_dep('Load Variables from .mat File: Loaded Variable ''contrastCellArray''', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('{}',{2}));
matlabbatch{2}.cfg_basicio.var_ops.subsrefvar.subsreference{1}.subsindc = {8};
matlabbatch{2}.cfg_basicio.var_ops.subsrefvar.tgt_spec.r{1}.name = 'strtype';
matlabbatch{2}.cfg_basicio.var_ops.subsrefvar.tgt_spec.r{1}.value = 'r';
matlabbatch{3}.cfg_basicio.var_ops.subsrefvar.input(1) = cfg_dep('Load Variables from .mat File: Loaded Variable ''contrastNames''', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('{}',{1}));
matlabbatch{3}.cfg_basicio.var_ops.subsrefvar.subsreference{1}.subsindc = {8};
matlabbatch{3}.cfg_basicio.var_ops.subsrefvar.tgt_spec.s{1}.name = 'strtype';
matlabbatch{3}.cfg_basicio.var_ops.subsrefvar.tgt_spec.s{1}.value = 's';
matlabbatch{4}.spm.stats.con.spmmat = {'/projects/sanlab/shared/REV/bids_data/derivatives/prepost_analysis/sub-REV001/fx/sst/SPM.mat'};
matlabbatch{4}.spm.stats.con.consess{1}.tcon.name(1) = cfg_dep('Access part of MATLAB variable: val{8}', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','output'));
matlabbatch{4}.spm.stats.con.consess{1}.tcon.weights(1) = cfg_dep('Access part of MATLAB variable: val{8}', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','output'));
matlabbatch{4}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{4}.spm.stats.con.delete = 0;
