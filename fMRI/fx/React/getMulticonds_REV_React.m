studyCode = 'REV';
firstSub = 1;
lastSub = 144;
exclude = []; %[4 5 7 8 12 14 15 25 28 30 33 40 42 45 61 63 64 66 71 72 79 81 83 85 87 92 95 96 99 101 103 105 106 112 113 120 122 123 125 128 132 133 139 143]; % If you want to exclude any numbers, put them in this vector (e.g. exclude = [5 20];)
task = 'react';
runs = [1 2 3 4];
repodir = ['~/Desktop/REV_BxData/']; %edit this path for your local computer
dataFolder = [repodir 'data/' task];
outputDir = [repodir 'names_onsets_durations/' task '/' 'multiconds/'];

if exist(outputDir)==7 %do nothing
    else mkdir(fxFolder)
end    

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
               
                % Convert to double
                run_info.tag = str2double(run_info.tag);
                
                % Get indices corresponding to PRC and Neutral Images
                ImageIndices =  run_info.tag() == 1 | run_info.tag() == 2;
                ImageOnsets = run_info.onsets(ImageIndices);
                ImageDurations = run_info.durations(ImageIndices);
                
                % Create the ratings vector 
                ratingIndices = run_info.tag() == 3;
                ratingOnsets = run_info.onsets(ratingIndices);
                ratingDurations = run_info.durations(ratingIndices);
                
                % Onsets
                for a = 1:length(ImageOnsets)
                    onsets{a} = ImageOnsets(a);
                end
                
                % Names
                for b= 1:length(onsets)
                    names{b} = strcat('trial',num2str(b));
                end
                
                % Durations
                for c = 1:length(names)    
                    durations{c} = ImageDurations(c);
                end
                
               
                onsets{1,length(onsets)+1} = [ratingOnsets]; % Add cell with rating onsets
                names{1,length(names)+1} = ['rating']; % Add cell with rating name
                durations{1,length(durations)+1} = [ratingDurations]; % Add cell with rating durations
                
                save([outputDir 'sub-' subject_code '_task-' task '_acq-' num2str(r) '_multiconds.mat'], 'names', 'onsets', 'durations') %Note that NODs files should be distinguished by acq number, NOT run number
                clear names onsets durations a b c;
            end
        end
    end
end
