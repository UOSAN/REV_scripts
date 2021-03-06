studyCode = 'REV';
firstSub = 1;
lastSub = 144;
exclude = []%[4 5 7 8 12 14 15 25 28 30 33 40 42 45 61 63 64 66 71 72 79 81 83 85 87 92 95 96 99 101 103 105 106 112 113 120 122 123 125 128 132 133 139 143]; % If you want to exclude any numbers, put them in this vector (e.g. exclude = [5 20];)
task = 'react';
runs = [1 2 3 4];
repodir = ['~/Desktop/REV_BxData/']; %edit this path for your local computer
dataFolder = [repodir 'data/' task];

%for s = firstSub
for s = firstSub:lastSub
    if find(exclude==s) % if they're on the exclusion list
        sprintf('sub %d excluded',s)
    else
        if s<10
            placeholder = '00';
        elseif s<100
            placeholder = '0';
        else
            placeholder = '';
        end
        
        subject_code = [studyCode placeholder num2str(s)];
        
        
        if exist(dataFolder)==7
            cd(dataFolder)
        else
            warning('subject data folder not found for subject %d',s)
        end
        
        for r = runs % For runs defined previously (scanning only here)
            fileName = dir(['*' subject_code '*' task num2str(r) '*.mat']);
            
            if size(fileName,1)>1
                warning('More than 1 data file found for sub %d run %d',s,r)
            elseif size(fileName,1)==0
                warning('No data file found for sub %d run %d',s,r)
            else
                load(fileName.name)
                
                %don't need baseline
                %split out risk into categories
                
                %names = {'risk_view' 'neutral_view'};
                %names = {'baseline' 'risk_view' 'neutral_view' 'rating'}; % baseline = instructions, blank screen, & fixation
                names = {'risk_view' 'neutral_view' 'rating'}; % baseline = instructions, blank screen, & fixation
                onsets = cell(1,length(names));
                durations = cell(1,length(names));
                %searchStrings = {'1' '2'};
                %searchStrings = {'0' '1' '2' '3'};
                searchStrings = {'1' '2' '3'};
                
                for c = 1:length(names)
                    currentIndices = find(~cellfun(@isempty,regexp(run_info.tag,searchStrings{c})) == 1);
                    onsets{c} = run_info.onsets(currentIndices);
                    durations{c} = run_info.durations(currentIndices);
                end
                
                %empty (i.e. deselect) "baseline" vector
                %names([1])=[];
                %onsets([1])=[];
                %durations([1])=[];
                
                fxFolder = [repodir 'names_onsets_durations/' task '/'];
                if exist(fxFolder)==7 %do nothing
                else mkdir(fxFolder)
                end    
                save([fxFolder 'sub-' subject_code '_task-' task '_acq-' num2str(r) '_onsets.mat'], 'names', 'onsets', 'durations') %Note that NODs files should be distinguished by acq number, NOT run number
            end
        end
    end
end
