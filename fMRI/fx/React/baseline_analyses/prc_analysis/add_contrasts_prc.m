% Yes. Open it with fopen(), get lines out into strings with fgetl(), 
% modify them as needed. Open an output file with fopen(), write the modified lines out. 
% Close both files with fclose(). Delete the input file with delete(). 
% Rename the output file to the input filename with movefile().

% WILL ALREADY BE IN PRC_ANALYSIS FOLDER
mypath='~/../../projects/sanlab/shared/REV/REV_scripts/fMRI/fx/React/mvpa_analysis/'; addpath(mypath);
%cd('../../mvpa_analysis/');
cd(mypath)
load('cond_nums.mat'); % this is where idxList comes from

batch_path='~/../../projects/sanlab/shared/REV/REV_scripts/fMRI/fx/React/baseline_analyses/prc_analysis/';

both_acqs=[batch_path 'both_acqs/scripts/sid_batches/matlabbatch_job_react_both_acqs/']; addpath(both_acqs);
acq_1=[batch_path 'acq1_only/scripts/sid_batches/matlabbatch_job_react_acq1_only/']; addpath(acq_1);
acq_2=[batch_path 'acq2_only/scripts/sid_batches/matlabbatch_job_react_acq2_only/']; addpath(acq_2);


not_both=cell(length(idxList.numPRC),1);
ct=0;

for s=1:length(idxList.numPRC)
    sub=idxList.sub{s};
    
    ncats=idxList.numPRC(strcmp(idxList.sub, sub));
    weight=round(1/ncats, 4);
    
    fname=['REV', sub, '_matlabbatch_job_react_both_acqs.mat'];
    cd(both_acqs)
    
    if exist([both_acqs, fname],'file')

        con1=strcat(' [',num2str([1, zeros(1, ncats*2 + 5)]),'];');
        con2=strcat(' [0 0 0 0', repmat([sprintf(' %.04f ', weight), '0 '], 1, ncats), ' 0 0];');

        
        l1='matlabbatch{18}.spm.stats.con.spmmat(1) = cfg_dep(''Model estimation: SPM.mat File'', substruct(''.'',''val'', ''{}'',{17}, ''.'',''val'', ''{}'',{1}, ''.'',''val'', ''{}'',{1}), substruct(''.'',''spmmat''));';
        l2='matlabbatch{18}.spm.stats.con.consess{1}.tcon.name = ''1_Neutral>Baseline'';';
        l3='matlabbatch{18}.spm.stats.con.consess{1}.tcon.weights = con1;';
        l4='matlabbatch{18}.spm.stats.con.consess{2}.tcon.name = ''2_Craved>Baseline'';';
        l5='matlabbatch{18}.spm.stats.con.consess{2}.tcon.weights = con2;';
        
        fid = fopen(fname,'a');
        
        fprintf(fid,'%s ',l1);
        fprintf(fid,'\n');
        fprintf(fid,'%s ',l2);
        fprintf(fid,'\n');
        fprintf(fid,'%s ',l3);
        fprintf(fid,'\n');
        fprintf(fid,'%s ',l4);
        fprintf(fid,'\n');
        fprintf(fid,'%s ',l5);
        
        fclose(fid);

    end
    
    
    fname=['REV', sub, '_matlabbatch_job_react_acq1_only.mat'];
    cd(acq_1)
    
    if exist([acq_1, fname],'file')
        
        con1=strcat(' [',num2str([1, zeros(1, ncats*2 + 5)]),'];');
        con2=strcat(' [0 0 0 0', repmat([sprintf(' %.04f ', weight), '0 '], 1, ncats), ' 0 0];');
    
        l1='matlabbatch{12}.spm.stats.con.spmmat(1) = cfg_dep(''Model estimation: SPM.mat File'', substruct(''.'',''val'', ''{}'',{11}, ''.'',''val'', ''{}'',{1}, ''.'',''val'', ''{}'',{1}), substruct(''.'',''spmmat''));';
        l2='matlabbatch{12}.spm.stats.con.consess{1}.tcon.name = ''1_Neutral>Baseline'';';
        l3='matlabbatch{12}.spm.stats.con.consess{1}.tcon.weights = con1;';
        l4='matlabbatch{12}.spm.stats.con.consess{2}.tcon.name = ''2_Craved>Baseline'';';
        l5='matlabbatch{12}.spm.stats.con.consess{2}.tcon.weights = con2;';
        
        fid = fopen(fname,'a');
        
        fprintf(fid,'%s ',l1);
        fprintf(fid,'\n');
        fprintf(fid,'%s ',l2);
        fprintf(fid,'\n');
        fprintf(fid,'%s ',l3);
        fprintf(fid,'\n');
        fprintf(fid,'%s ',l4);
        fprintf(fid,'\n');
        fprintf(fid,'%s ',l5);
        
        fclose(fid);
        
    end
    
    fname=['REV', sub, '_matlabbatch_job_react_acq2_only.mat'];
    cd(acq_2)
    
    if exist([acq_2, fname],'file')
        
        con1=strcat(' [',num2str([1, zeros(1, ncats*2 + 5)]),'];');
        con2=strcat(' [0 0 0 0', repmat([sprintf(' %.04f ', weight), '0 '], 1, ncats), ' 0 0];');
    
        l1='matlabbatch{12}.spm.stats.con.spmmat(1) = cfg_dep(''Model estimation: SPM.mat File'', substruct(''.'',''val'', ''{}'',{11}, ''.'',''val'', ''{}'',{1}, ''.'',''val'', ''{}'',{1}), substruct(''.'',''spmmat''));';
        l2='matlabbatch{12}.spm.stats.con.consess{1}.tcon.name = ''1_Neutral>Baseline'';';
        l3='matlabbatch{12}.spm.stats.con.consess{1}.tcon.weights = con1;';
        l4='matlabbatch{12}.spm.stats.con.consess{2}.tcon.name = ''2_Craved>Baseline'';';
        l5='matlabbatch{12}.spm.stats.con.consess{2}.tcon.weights = con2;';
        
        fid = fopen(fname,'a');
        
        fprintf(fid,'%s ',l1);
        fprintf(fid,'\n');
        fprintf(fid,'%s ',l2);
        fprintf(fid,'\n');
        fprintf(fid,'%s ',l3);
        fprintf(fid,'\n');
        fprintf(fid,'%s ',l4);
        fprintf(fid,'\n');
        fprintf(fid,'%s ',l5);
        
        fclose(fid);
        
    end
    
    if ~exist(fname,'file')
        display(sub);
        ct=ct+1;
        not_both{ct}=sub;
    end
    
end


%rsync -auxv --progress mmoss2@Talapas-ln1.uoregon.edu:/gpfs/projects/sanlab/shared/REV/REV_scripts/fMRI/fx/React/baseline_analyses/prc_analysis/both_acqs/scripts/sid_batches/matlabbatch_job_react_both_acqs/REV001_matlabbatch_job_react_both_acqs.mat /Users/melmo/Desktop/REV001_matlabbatch_job_react_both_acqs.mat