function fix_REVtags

% %% Set up directories to be referenced!
% baseDir = '/Users/mmoss/Dropbox/REV_repos'; %mmoss for laptop, Melissa for desktop
% %dataDir = [baseDir '/REV_BxData'];
% dataDir = [baseDir '/REV_scripts/behavioral/GNG'];
% tagDir = [baseDir '/REV_scripts/behavioral/tasks/REV_GNG'];

%% Set up directories to be referenced later

studyCode = 'REV';
firstSub = 1;
lastSub = 144;
exclude = [4 5 7 8 12 14 15 25 28 30 33 40 42 45 61 63 64 66 71 72 79 81 83 85 87 92 95 96 99 101 103 105 106 112 113 120 122 123 125 128 132 133 139 143]; % If you want to exclude any numbers, put them in this vector (e.g. exclude = [5 20];)
task = 'GNG'; %'React';
runs = [1 2 3 4];
dataFolder = ['/Users/kristadestasio/Desktop/REV_scripts/behavioral/' task '/data'];


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
            
            if size(filename)>1
                warning('More than 1 data file found for sub %d run %d',s,r)
            elseif size(filename)==0
                warning('No data file found for sub %d run %d',s,r)
            elseif exist(filename)
                load(filename)
                
                % For GNG task
                if strcmp(run_info.stimulus_input_file, 'GNG*')
                    if r == (1 | 3)
                        new_tags = [ '' 3 1 2 1 1 2 1 1 2 1 1 1 1 1 1 1 2 1 1 2 1 1 1 1 1 2 1 1 1 1 2 1 1 2 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 2 3 2 2 2 2 2 2 2 1 2 2 1 2 2 2 2 2 2 1 2 1 2 2 2 2 1 2 2 2 1 2 1 2 2 2 1 2 2 2 2 2 2 2 2 2 1 2 2 2 1 2 3 1 1 1 1 1 2 1 2 1 1 2 1 1 2 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 2 1 2 1 2 1 2 1 1 1 2 1 1 1 1 1 1 1 1 1 1 3 2 1 2 2 2 2 2 2 2 2 1 2 2 2 2 1 2 2 2 2 1 2 2 2 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 2 2 2 2 1 2 2 2 2 2 2 3 2 1 2 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 2 1 1 1 1 2 1 1 2 ];
                    elseif r == (2 | 4)
                        new_tags = [ '' 3 2 2 2 2 2 1 2 1 2 2 1 2 2 1 2 2 2 2 2 2 2 1 2 2 2 2 2 2 2 1 2 1 2 1 2 1 2 2 2 1 2 2 2 2 2 2 2 2 2 2 3 1 1 1 1 1 1 2 1 1 1 2 1 1 1 1 2 1 2 1 1 1 2 1 1 1 1 1 1 2 1 1 2 1 2 1 1 1 1 2 1 1 2 1 1 2 1 1 1 1 1 3 2 2 1 2 1 2 2 2 2 1 2 2 1 2 2 2 2 1 2 2 1 2 2 2 2 2 2 2 2 2 2 1 2 2 1 2 2 1 2 2 2 1 2 2 2 1 2 2 2 2 3 1 2 1 1 1 1 1 2 1 1 1 2 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 2 1 2 1 2 1 1 2 1 1 3 2 2 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 2 2 2 2 2 1 2 1 ];
                    end
                    save(filename, 'key_presses', 'run_info')
                end
                % For React tast
                if strcmp(run_info.stimulus_input_file, '*React*')
                    % Set what tags should be
                    if r == (1 | 3)
                        new_tags = [ 3 2 0 0 0 1 0 0 0 1 0 0 0 2 0 0 0 1 0 0 0 1 0 0 0 2 0 0 0 2 0 0 0 1 0 0 0 2 0 0 0 1 0 0 0 2 0 0 0 2 0 0 0 1 0 0 0 2 0 0 0 2 0 0 0 1 0 0 0 1 0 0 0 2 0 0 0 2 0 0 0 1 0 0 0 1 0 0 0 2 0 0 0 2 0 0 0 1 0 0 0 1 0 0 0 ];
                    elseif r == (2 | 4)
                        new_tags = [ 3 1 0 0 0 1 0 0 0 2 0 0 0 2 0 0 0 1 0 0 0 1 0 0 0 2 0 0 0 2 0 0 0 1 0 0 0 1 0 0 0 2 0 0 0 2 0 0 0 1 0 0 0 1 0 0 0 2 0 0 0 2 0 0 0 1 0 0 0 1 0 0 0 2 0 0 0 2 0 0 0 1 0 0 0 1 0 0 0 2 0 0 0 2 0 0 0 1 0 0 0 2 0 0 0 ];
                    end
                    % Assign tags
                    for t = 1:length(new_tags);
                        run_info.tag{t} = new_tags(t);
                    end
                    save(filename, 'key_presses', 'run_info')
                end
            end
        end
    end
end


