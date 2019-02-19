% This script will eventually be saved in '/projects/sanlab/shared/REV/REV_scripts/fMRI/fx/React/mvpa_analysis'

% Set Study
STUDY = '/projects/sanlab/shared/REV';

[wdpath, ~, ~] = fileparts(which(mfilename));
cd(wdpath)

% Get subject list

%% Import data from text file.
% Script for importing data from the following text file:
%
%    /Users/Melissa/Dropbox/1prc_fx_stuff/prc_fx/sublist.txt

% Initialize variables.
filename = '/projects/sanlab/shared/REV/REV_scripts/fMRI/fx/React/mvpa_analysis/sublist.txt';
delimiter = '';

% Format string for each line of text:
%   column1: text (%s)
formatSpec = '%s%[^\n\r]';

% Open the text file.
fileID = fopen(filename,'r');

% Read columns of data according to format string.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

% Close the text file.
fclose(fileID);

% Create output variable
sublist = table(dataArray{1:end-1}, 'VariableNames', {'VarName1'});

% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;


sublist = table2array(sublist);

%%
fid = fopen('sub_conds_list.txt', 'a');

for sub = 1:length(sublist)
    
    % Set nifti directory
    nii_dir=[STUDY '/bids_data/derivatives/baseline_analyses/' sublist{sub} '/fx/react/prc'];
    if exist(nii_dir,'dir')
        cd(nii_dir)

        load('SPM.mat')
        
        %idxN = strfind(SPM.xX.name, 'neutral');
        %idx = find(not(cellfun('isempty',idxN)));
        
        idxR = strfind(SPM.xX.name, 'risk');
        idx = find(not(cellfun('isempty',idxR)));
        %idx = horzcat(idx, find(not(cellfun('isempty',idxR))));
        
        odd = mod(idx,2);
        condIdx = idx(find(odd));
        
        % ======================================================================
        % Condition names (in same order as beta maps)
        condnames={};
        for i = 1:length(condIdx)
            names = strsplit(SPM.xX.name{condIdx(i)},{'*',') '});
            condnames = [condnames; names{2}];
        end
        
        cd(wdpath)
        
        for i = 1:length(condnames)
            fprintf(fid,'%s',sublist{sub});
            fprintf(fid,'\t');
            fprintf(fid,'%s',condnames{i});
            fprintf(fid,'\n');
        end
        
    end
end
