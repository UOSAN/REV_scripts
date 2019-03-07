function get_bmap_names_baseline
%%
% RUN 'getConds.m' SCRIPT FIRST!


%% Import data from text file.
% Script for importing data from the following text file:
%
%    /Users/Melissa/Dropbox/REV_repos/REV_BxData/prc_mappings/prcListForVecs.txt

%% Initialize variables.
filename = '/projects/sanlab/shared/REV/REV_BxData/prc_mappings/prcListForVecs.txt';
%filename = '/Users/Melissa/Dropbox/REV_repos/REV_BxData/prc_mappings/prcListForVecs.txt';
delimiter = '\t';

%% Format string for each line of text:
%   column1: text (%q)
%	column2: text (%q)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%q%q%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
prcListForVecs = [dataArray{1:end-1}];
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;
%%
% This script should be saved in '/projects/sanlab/shared/REV/REV_scripts/fMRI/fx/React/mvpa_analysis'
[wdpath, ~, ~] = fileparts(which(mfilename));
cd(wdpath)

% idxList=struct;
% idxList.sub=cell(length(prcListForVecs),1);
% idxList.numPRC=zeros(length(prcListForVecs),1);
% 
% for i=1:length(prcListForVecs)
%     idxList.sub(i)=prcListForVecs(i,2);
%     idxList.numPRC(i)=length(prcListForVecs{i,1})-1;
% end

filename = '/projects/sanlab/shared/REV/REV_scripts/fMRI/fx/React/mvpa_analysis/sub_conds_list.txt';
% filename = '/Users/Melissa/Dropbox/REV_repos/REV_scripts/fMRI/fx/React/mvpa_analysis/sub_conds_list.txt';
delimiter = '\t';
formatSpec = '%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
subsList = table(dataArray{1:end-1}, 'VariableNames', {'SUB','PRC_RUN'});
clearvars filename delimiter formatSpec fileID dataArray ans;

% subsList=readtable('sub_conds_list.txt');
% subsList=table2array(subsList);
% subsList=subsList(:,1);
% for i=1:length(subsList)
%     subsList{i}=strtok(subsList{i});
% end

subsList=subsList.SUB;
subsList=unique(subsList);
subsList2=cell(length(subsList),1);
for i=1:length(subsList)
    subsNums=strsplit(subsList{i},'V');
    subsList2{i}=subsNums{2};
    
end

subIdx=zeros(length(subsList2),1);
for i=1:length(subsList)
    for v=1:length(prcListForVecs)
        if strcmpi(prcListForVecs{v,2},subsList2{i})
            subIdx(i)=v;
        end
    end
end

idxList=struct;
idxList.sub=cell(length(subIdx),1);
idxList.numPRC=zeros(length(subIdx),1);

for i=1:length(subIdx)
    idxList.sub(i)=prcListForVecs(subIdx(i),2);
    idxList.numPRC(i)=length(prcListForVecs{subIdx(i),1})-1;
end

    
exclude={'004' '007' '008' '009' '025' '026' '027' '028' '034' '058' '061' '066' '071' '081' '083' '087' '092' '096' '099' '103' '106' '117' '123' '133' '139' '143'};
subs1acq={'014' '019' '116' '122' '124' '064'};
fid=fopen('list_of_bmaps_baseline.txt', 'a');

for i=1:length(idxList.numPRC)
    %s=strfind(subs1acq,idxList.sub(i));
    %e=strfind(exclude,idxList.sub(i));
    if any(strncmp(exclude, idxList.sub(i), 3))
        disp(idxList.sub(i));
    else %  not on 'exclude' list
        bmap0_1=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0001.nii'); %neutral will always be first 2
        bmap0_2=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0002.nii');
            
        fprintf(fid,'%s ',bmap0_1);
        fprintf(fid,'%s ',bmap0_2);
            
        if any(strncmp(subs1acq, idxList.sub(i), 3)) % one acquisition only
            
            if idxList.numPRC(i)==1
                bmap1=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0005.nii');
                
                fprintf(fid,'%s ',bmap1);
                
            elseif idxList.numPRC(i)==2
                bmap1=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0005.nii');
                bmap2=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0007.nii');
                
                fprintf(fid,'%s ',bmap1);
                fprintf(fid,'%s ',bmap2);
                
            elseif idxList.numPRC(i)==3
                bmap1=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0005.nii');
                bmap2=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0007.nii');
                bmap3=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0009.nii');
                
                fprintf(fid,'%s ',bmap1);
                fprintf(fid,'%s ',bmap2);
                fprintf(fid,'%s ',bmap3);
                
            elseif idxList.numPRC(i)==4
                bmap1=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0005.nii');
                bmap2=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0007.nii');
                bmap3=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0009.nii');
                bmap4=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0011.nii');
                
                fprintf(fid,'%s ',bmap1);
                fprintf(fid,'%s ',bmap2);
                fprintf(fid,'%s ',bmap3);
                fprintf(fid,'%s ',bmap4);
                
            else
                disp('something weird here...')
            end
            
        else % both acquisitions

            if idxList.numPRC(i)==1
                
                bmap0_3=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0012.nii');
                bmap0_4=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0013.nii');
            
                fprintf(fid,'%s ',bmap0_3);
                fprintf(fid,'%s ',bmap0_4);
            
                bmap1=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0005.nii');
                bmap2=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0016.nii');
                
                fprintf(fid,'%s ',bmap1);
                fprintf(fid,'%s ',bmap2);
                
            elseif idxList.numPRC(i)==2
                
                bmap0_3=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0014.nii');
                bmap0_4=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0015.nii');
            
                fprintf(fid,'%s ',bmap0_3);
                fprintf(fid,'%s ',bmap0_4);
                
                bmap1=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0005.nii');
                bmap2=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0007.nii');
                bmap3=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0018.nii');
                bmap4=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0020.nii');
                
                fprintf(fid,'%s ',bmap1);
                fprintf(fid,'%s ',bmap2);
                fprintf(fid,'%s ',bmap3);
                fprintf(fid,'%s ',bmap4);
                
            elseif idxList.numPRC(i)==3
                
                bmap0_3=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0016.nii');
                bmap0_4=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0017.nii');
            
                fprintf(fid,'%s ',bmap0_3);
                fprintf(fid,'%s ',bmap0_4);
                
                bmap1=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0005.nii');
                bmap2=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0007.nii');
                bmap3=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0009.nii');
                bmap4=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0020.nii');
                bmap5=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0022.nii');
                bmap6=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0024.nii');
                
                fprintf(fid,'%s ',bmap1);
                fprintf(fid,'%s ',bmap2);
                fprintf(fid,'%s ',bmap3);
                fprintf(fid,'%s ',bmap4);
                fprintf(fid,'%s ',bmap5);
                fprintf(fid,'%s ',bmap6);
                
            elseif idxList.numPRC(i)==4
                
                bmap0_3=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0018.nii');
                bmap0_4=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0019.nii');
            
                fprintf(fid,'%s ',bmap0_3);
                fprintf(fid,'%s ',bmap0_4);
                
                bmap1=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0005.nii');
                bmap2=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0007.nii');
                bmap3=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0009.nii');
                bmap4=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0011.nii');
                bmap5=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0022.nii');
                bmap6=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0024.nii');
                bmap7=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0026.nii');
                bmap8=strcat('/projects/sanlab/shared/REV/bids_data/derivatives/baseline_analyses/sub-REV', idxList.sub{i} ,'/fx/react/prc/beta_0028.nii');
                
                fprintf(fid,'%s ',bmap1);
                fprintf(fid,'%s ',bmap2);
                fprintf(fid,'%s ',bmap3);
                fprintf(fid,'%s ',bmap4);
                fprintf(fid,'%s ',bmap5);
                fprintf(fid,'%s ',bmap6);
                fprintf(fid,'%s ',bmap7);
                fprintf(fid,'%s ',bmap8);
                
            else
                disp('something weird here...')
            end
        end
        
    end

end

% Close the file.
fclose(fid);

disp('Done!')




















