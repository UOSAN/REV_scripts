%% Set up directories to be referenced later
studyCode = 'REV';
firstSub = 1;
lastSub = 144;
exclude = []%[4 5 7 8 12 14 15 25 28 30 33 40 42 45 61 63 64 66 71 72 79 81 83 85 87 92 95 96 99 101 103 105 106 112 113 120 122 123 125 128 132 133 139 143]; % If you want to exclude any numbers, put them in this vector (e.g. exclude = [5 20];)
task = 'React'; %'GNG';
runs = [1 2 3 4];
repodir = ['~/Desktop/REV/REV_BxData/']; %edit this path for your local computer
dataFolder = [repodir 'data/' task];


cd(dataFolder)

for s = firstSub:lastSub
    if find(exclude==s) % if they're on the exclusion list
        sprintf('sub %d excluded',s)
    else
        % Create subjectCode
        if s<10
            placeholder = '00';
        elseif s<100
            placeholder = '0';
        else placeholder = '';
        end
        
        subject_code = [studyCode placeholder num2str(s)];
        
        for r=runs % For runs defined previously (scanning only here)
            filename = [subject_code '_' task num2str(r) '.mat'];
            
            if size(filename,1)>1
                warning('More than 1 data file found for sub %d run %d',s,r)
            elseif size(filename,1)==0
                warning('No data file found for sub %d run %d',s,r)
            elseif exist(filename)
                load(filename)

                    % For GNG task
                if strcmp(task, 'GNG')
                    % Set what tags should be
                    if r == (1 | 3)
                        new_tags = [0 0 1 4 1 1 4 1 1 4 1 1 1 1 1 1 1 4 1 1 4 1 1 1 1 1 4 1 1 1 1 4 1 1 4 1 1 1 1 1 1 1 1 4 1 1 1 1 1 1 1 4 0 3 3 3 3 3 3 3 2 3 3 2 3 3 3 3 3 3 2 3 2 3 3 3 3 2 3 3 3 2 3 2 3 3 3 2 3 3 3 3 3 3 3 3 3 2 3 3 3 2 3 0 1 1 1 1 1 4 1 4 1 1 4 1 1 4 1 1 1 1 1 1 1 4 1 1 1 1 1 1 1 4 1 4 1 4 1 4 1 1 1 4 1 1 1 1 1 1 1 1 1 1 0 3 2 3 3 3 3 3 3 3 3 2 3 3 3 3 2 3 3 3 3 2 3 3 3 2 3 3 3 3 3 3 3 2 3 3 3 2 3 3 3 3 3 3 2 3 3 3 3 3 3 0 4 1 4 1 1 1 1 1 1 1 1 1 4 1 1 1 1 1 1 1 4 1 1 1 1 1 1 1 1 1 1 1 4 1 1 1 1 1 1 1 1 4 1 1 1 1 4 1 1 4];
                    elseif r == (2 | 4)
                        new_tags = [0 0 3 3 3 3 3 2 3 2 3 3 2 3 3 2 3 3 3 3 3 3 3 2 3 3 3 3 3 3 3 2 3 2 3 2 3 2 3 3 3 2 3 3 3 3 3 3 3 3 3 3 0 1 1 1 1 1 1 4 1 1 1 4 1 1 1 1 4 1 4 1 1 1 4 1 1 1 1 1 1 4 1 1 4 1 4 1 1 1 1 4 1 1 4 1 1 4 1 1 1 1 1 0 3 3 2 3 2 3 3 3 3 2 3 3 2 3 3 3 3 2 3 3 2 3 3 3 3 3 3 3 3 3 3 2 3 3 2 3 3 2 3 3 3 2 3 3 3 2 3 3 3 3 0 1 4 1 1 1 1 1 4 1 1 1 4 1 1 1 1 1 1 1 1 4 1 1 1 1 1 1 1 1 1 4 1 1 1 1 1 1 1 1 1 4 1 4 1 4 1 1 4 1 1 0 3 3 3 3 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 2 3 3 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 2 3 3 3 3 3 2 3 2];
                    end
                    % Assign tags
                    for t = 1:length(new_tags);
                        run_info.tag{t} = num2str(new_tags(t));
                    end
                    save(filename, 'key_presses', 'run_info')
                end

                % For React tast
                if strcmp(task, 'React')
                    % Set what tags should be
                    if r == (1 | 3)
                        new_tags = [0 2 0 3 0 1 0 3 0 1 0 3 0 2 0 3 0 1 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 2 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 1 0 3 0];
                    elseif r == (2)
                        new_tags = [0 1 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 2 0 3 0];
                    elseif r == (4)
                        new_tags = [0 1 0 3 0 1 0 3 0 1 0 3 0 1 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 2 0 3 0 1 0 3 0 2 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 2 0 3 0 2 0 3 0 1 0 3 0 1 0 3 0 2 0 3 0 1 0 3 0];
                    end
                    % Assign tags
                    for t = 1:length(new_tags);
                        run_info.tag{t} = num2str(new_tags(t));
                    end
                    save(filename, 'key_presses', 'run_info')
                end
            end
        end
    end
end


