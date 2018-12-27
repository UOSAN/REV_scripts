%{
This script runs on the REV study names/onsets/durations files.
It fills empty onsets cell with the value zero so the column is
recognized by SPM during modeling.
%}

%% Set up directories to be referenced later
studyCode = 'REV';
firstSub = 1;
lastSub = 144;
task = 'gng';
runs = [1 2 3 4];
repodir = '~/Desktop/REV_BxData/'; %edit this path for your local computer

dataFolder = [repodir 'names_onsets_durations/' task '/prepost_analysis'];


cd(dataFolder)

for s = firstSub:lastSub
    if s<10
        placeholder = '00';
    elseif s<100
        placeholder = '0';
    else placeholder = '';
    end
    
    subject_code = [studyCode placeholder num2str(s)];
    
    for r=runs % For runs defined previously (scanning only here)
        filename = ['sub-' subject_code '_task-' task '_acq-' num2str(r) '_onsets.mat'];
        if size(filename,1)>1
            warning('More than 1 data file found for sub %d run %d',s,r)
        elseif size(filename,1)==0
            warning('No data file found for sub %d run %d',s,r)
        elseif exist(filename)
            load(filename)
            i = cellfun('isempty',onsets); % true for empty cells
            onsets(i) = {0};
            i = cellfun('isempty',durations); % true for empty cells
            durations(i) = {0};
            save(filename, 'onsets', 'durations', 'names')
        end
    end
end