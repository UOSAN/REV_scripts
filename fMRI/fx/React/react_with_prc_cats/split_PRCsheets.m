function split_PRCsheets(varargin)
%Split PRC image mapping sheets by participant, in order to make REV tag
%fixing easier (only need to do this once)

%set working directory
[wdpath, ~, ~] = fileparts(which(mfilename));
cd(wdpath)

studyCode = 'REV';
firstSub = 1;
lastSub = 144;
exclude = [];%[4 5 7 8 12 14 15 25 28 30 33 40 42 45 61 63 64 66 71 72 79 81 83 85 87 92 95 96 99 101 103 105 106 112 113 120 122 123 125 128 132 133 139 143]; % If you want to exclude any numbers, put them in this vector (e.g. exclude = [5 20];)
task = 'React'; %'GNG';
runs = [1 2 3 4];
%dataFolder = ['/Users/kristadestasio/Desktop/REV_scripts/behavioral/' task '/data'];
repodir = ['~/Dropbox/REV_repos/REV_BxData/'];

dataFolder = [repodir 'data/' task];

reactRunsFolder='~/Dropbox/REV_repos/REV_scripts/behavioral/tasks/REV_React/';
prcFolder=[repodir,'prc_mappings/'];

% prc_cats_folder= '/Users/Melissa/Downloads';
AllSubPRC=[prcFolder 'CopyLogListFinal.xlsx'];
MoreSubPRC=[prcFolder 'prcMappingFinal.xlsx'];


StudyInfo=struct;
StudyInfo.studyCode = studyCode;
StudyInfo.firstSub = firstSub;
StudyInfo.lastSub = lastSub;
StudyInfo.exclude = exclude;
StudyInfo.task = task;
StudyInfo.runs = runs;

cd(prcFolder)
if ~exist('sub_PRCcats','dir') %make the subfolder if it doesn't exist
    mkdir('sub_PRCcats')
end

% Need to run both 'subDoc' files to get full set of data
% NOTE TO SELF: This should be automated in a for-loop or a switch case...
subDoc = MoreSubPRC;
%subDoc = MoreSubPRC;
prcFolder = strcat(prcFolder,'sub_PRCcats/');


subDoc = table2array(readtable(subDoc));

myStruct=struct;

for i=1:length(subDoc(:,1))
    if isempty(subDoc{i,1})
        subDoc{i,1}=subDoc{(i-1),1};
    end
end

for s = StudyInfo.firstSub:StudyInfo.lastSub
    ct=1;
    
    if find(StudyInfo.exclude==s) % if they're on the exclusion list
        sprintf('sub %d excluded',s)
    else
        % Create subjectCode
        if s<10
            placeholder = '00';
        elseif s<100
            placeholder = '0';
        else placeholder = '';
        end
        
        subject_code = [StudyInfo.studyCode placeholder num2str(s)];
        subject_prc = strcat(subject_code,'_PRC');
        %if ~ismember(subject_code,alreadyDone) %only on 'MoreSubPRC' round
            
            for i=1:length(subDoc(:,1))
                if strcmp(subDoc(i,1),subject_code)
                    myStruct.(sprintf(subject_prc))(ct,:)=subDoc(i,:);
                    ct=ct+1;
                end
            end
        %end
    end
end

cd(prcFolder)
myFields=fields(myStruct);

for f=1:length(myFields)
    myStruct2=myStruct;
    
    nm=(sprintf('%s',myFields{f}));
    
    cd(prcFolder)
    filename=strcat(nm,'.txt');
    
    other_subs=myFields(~ismember(myFields,nm));
    for g=1:length(other_subs);
        myStruct2=rmfield(myStruct2,other_subs{g});
    end
    %theStructs=myStruct2;
    %dataOnly=1;
    
    WriteStructToText(filename,myStruct2.(nm),0)
end

cd(wdpath)

end

function WriteStructToText(filename,theStructs,dataOnly)
    %==========================================================================
    % WriteStructToText(filename,theStructs,dataOnly)
    %
    % theStructs can be a single structure, or an array of structures
    % dataOnly (1=true 0=false) doesn't write the header to the file
    % and appends to an existing file (if it exists).
    %
    % based on WriteStructsToText from PsychToolbox, which doesn't work for our
    % purposes (it writes the field values as columns, instead of rows).
    %==========================================================================
    
    theStructs = cell2dataset(theStructs,'VarNames',{'subID' 'PRCimg' 'PRCcat' 'PRCsubcat'});
    
    % Get the fieldnames
    theFields = fieldnames(theStructs);
    nFields = length(theFields);
    
    % Open the file. If in dataOnly mode, append to existing file and don't
    % write field names. Otherwise, open a blank file and write field names.
    if dataOnly
        fid = fopen(filename,'a');
    else
        fid = fopen(filename,'w');
        
        
        for i = 1:(nFields-1)
            fprintf(fid,'%s',theFields{i});
            if (i < (nFields-1))
                fprintf(fid,'\t');
            else
                fprintf(fid,'\n');
            end
        end
    end
    
    % Now write each struct's data as a line
    for k=1:length(theStructs.(theFields{1}))
        for i = 1:(nFields-1)
        
            if (iscell(theStructs.(theFields{i})(k)))
                fprintf(fid,'%s ',theStructs.(theFields{i}){k,:});
                
            elseif (ischar(theStructs.(theFields{i})(k)))
                fprintf(fid,'%s',theStructs.(theFields{i})(k));
                keyboard
            elseif (~isscalar(theStructs.(theFields{i})(k,:)))
                fprintf(fid,'%g ',theStructs.(theFields{i})(k,:));
                
            else
                fprintf(fid,'%g',theStructs.(theFields{i})(k));
            end
            
            if (i < (nFields-1))
                fprintf(fid,'\t');
            else
                fprintf(fid,'\n');
            end
        end
    end
    
    % Close the file.
    fclose(fid);
    
end









