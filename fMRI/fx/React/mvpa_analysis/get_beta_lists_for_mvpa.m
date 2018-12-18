function get_beta_lists_for_mvpa

% This script will eventually be saved in '/projects/sanlab/shared/REV/REV_scripts/fMRI/fx/React/mvpa_analysis'
[wdpath, ~, ~] = fileparts(which(mfilename));
cd(wdpath)

% Set Study
STUDY='/projects/sanlab/shared/REV';


% Set subject list
SUBLIST=readtable('sublist.txt','ReadVariableNames',false);


for sub=1:height(SUBLIST)
    
    % Set nifti directory
    nii_dir=strcat(STUDY, '/bids_data/derivatives/baseline_analyses/', SUBLIST{sub,:}, '/fx/react/prc');
    
    cd(nii_dir{:})

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
        condnames = [condnames, names{2}];
    end
    
    subBetas=struct;
    subBetas.condIdx=condIdx;
    subBetas.condnames=condnames;

    filename = strcat(SUBLIST{sub,:}, '.txt');

    cd(wdpath)
    
    DumpStructToText(filename, subBetas, 0)
    
end


end


function DumpStructToText(filename,theStructs,dataOnly)
% DumpStructToText(filename,theStructs,dataOnly)
% theStructs can be a single structure, or an array of structures
% dataOnly (1=true 0=false) doesn't write the header to the file, and appends to an existing
% file (if it exists). 

%based on WriteStructsToText from PsychToolbox, which doesn't work for our
%purposes (it writes the field values as columns, instead of rows).

% Get the fieldnames
theFields = fieldnames(theStructs(1));
nFields = length(theFields);

% Open the file. If in dataOnly mode, append to existing file and don't
% write field names. Otherwise, open a blank file and write field names.  
if dataOnly
    fid = fopen(filename,'a');
else
    fid = fopen(filename,'w');
    
    
    for i = 1:nFields
        fprintf(fid,'%s',theFields{i});
        if (i < nFields)
            fprintf(fid,'\t');
        else
            fprintf(fid,'\n');
        end
    end
end

% Now write each struct's data as a line
nStructs = length(theStructs);
for j = 1:nStructs
    for k=1:length(theStructs(j).(theFields{1}))
        for i = 1:nFields
            
            if (iscell(theStructs(j).(theFields{i})(k)))
                fprintf(fid,'%s ',theStructs(j).(theFields{i}){k,:});
           
            elseif (ischar(theStructs(j).(theFields{i})(k)))
                fprintf(fid,'%s',theStructs(j).(theFields{i})(k));
                
            elseif (~isscalar(theStructs(j).(theFields{i})(k,:)))
                fprintf(fid,'%g ',theStructs(j).(theFields{i})(k,:));
                
            else
                fprintf(fid,'%g',theStructs(j).(theFields{i})(k));
            end
            
            if (i < nFields)
                fprintf(fid,'\t');
            else
                fprintf(fid,'\n');
            end
        end
    end
end

% Close the file.
fclose(fid);

end
%%
% ======================================================================










