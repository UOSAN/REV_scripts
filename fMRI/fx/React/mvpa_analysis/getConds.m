% This script will eventually be saved in '/projects/sanlab/shared/REV/REV_scripts/fMRI/fx/React/mvpa_analysis'

% Set Study
STUDY = '/projects/sanlab/shared/REV';

[wdpath, ~, ~] = fileparts(which(mfilename));
cd(wdpath)

% Get subject list

%% Read in sublist data from text file.
filename = '/projects/sanlab/shared/REV/REV_scripts/fMRI/fx/React/mvpa_analysis/sublist.txt';
delimiter = '';
formatSpec = '%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
sublist = table(dataArray{1:end-1}, 'VariableNames', {'VarName1'});
clearvars filename delimiter formatSpec fileID dataArray ans;

sublist = table2array(sublist);

%% Record which subjects/conditions/runs have the appropriate nifti files.
fid = fopen('sub_conds_list.txt', 'a');

for sub = 1:length(sublist)
    
    % Set nifti directory
    nii_dir=[STUDY '/bids_data/derivatives/baseline_analyses/' sublist{sub} '/fx/react/prc'];
    if exist(nii_dir,'dir')
        cd(nii_dir)
        
        if exist('SPM.mat','file')
            
            load('SPM.mat')
            
            idxN = strfind(SPM.xX.name, 'neutral');
            idx1 = find(not(cellfun('isempty',idxN)));
            
            idxR = strfind(SPM.xX.name, 'risk');
            idx = find(not(cellfun('isempty',idxR)));
            %idx = horzcat(idx, find(not(cellfun('isempty',idxR))));
            
            odd1 = mod(idx1,2);
            condIdx1 = idx1(find(odd1));
            
            odd = mod(idx,2);
            condIdx = idx(find(odd));
            
            condIdx = horzcat(condIdx1, condIdx);
            
            % ======================================================================
            % Condition names (in same order as beta maps)
            condnames={};
            for i = 1:length(condIdx)
                names = strsplit(SPM.xX.name{condIdx(i)},{'*',') '});
                %condnames = [condnames; names{2}];
                condnames = [condnames; strcat(names{2}, '_', names{3}(4))];
            end
            
            cd(wdpath)
            
            for i = 1:length(condnames)
                fprintf(fid,'%s',sublist{sub});
                fprintf(fid,'\t');
                fprintf(fid,'%s',condnames{i});
                fprintf(fid,'\n');
            end
        else
            disp(sublist{sub});
        end
    else
        disp(sublist{sub});
    end
end


%% Create second sub conditions text file with 3 columns:
%   1. subject number (as numeric, not character string)
%   2. PRC condition (1=alcohol, 2=drugs, 3=tobacco, 4=food)
%   3. run number (1 or 2)

%Import data from text file.
filename = '/projects/sanlab/shared/REV/REV_scripts/fMRI/fx/React/mvpa_analysis/sub_conds_list.txt';
%filename = '/Users/Melissa/Dropbox/REV_repos/REV_scripts/fMRI/fx/React/mvpa_analysis/sub_conds_list.txt';
delimiter = '\t';
formatSpec = '%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
subcondslist = table(dataArray{1:end-1}, 'VariableNames', {'SUB','PRC_RUN'});
clearvars filename delimiter formatSpec fileID dataArray ans;

%%
subcondslist.subs=zeros(height(subcondslist),1);
subcondslist.prc=zeros(height(subcondslist),1);
subcondslist.run=zeros(height(subcondslist),1);


for r=1:height(subcondslist)
    subcondslist.subs(r)=str2num(subcondslist.SUB{r}(8:end));
    
    x=subcondslist.PRC_RUN{r};
    %run_num=x(end);
    subcondslist.run(r)=x(end);  
end

subcondslist.run=subcondslist.run-48; %don't know why I have to do this...

PRC={'neutral_view','risk_alcohol' 'risk_drug' 'risk_tobacco' 'risk_food'};
tagStr={0 1 2 3 4};
                
for r=1:length(PRC)
    subcondslist.prc(strncmp(subcondslist.PRC_RUN, PRC(r), 8))=tagStr{r};
    
end
        
subcondslist2=subcondslist(:,3:end);               

cd(wdpath)
writetable(subcondslist2,'sub_conds_final.txt','Delimiter','\t');   



