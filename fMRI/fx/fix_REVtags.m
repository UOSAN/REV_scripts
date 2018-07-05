function fix_REVtags

%% Set up directories to be referenced later

studyCode = 'REV';
firstSub = 1;
lastSub = 144;
exclude = [4 5 7 8 12 14 15 25 28 30 33 40 42 45 61 63 64 66 71 72 79 81 83 85 87 92 95 96 99 101 103 105 106 112 113 120 122 123 125 128 132 133 139 143]; % If you want to exclude any numbers, put them in this vector (e.g. exclude = [5 20];)
task = 'React';
dataFolder = ['~/Desktop/REV_scripts/behavioral/' task '/data'];

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
            warning('Data folder not found')
        end
        
        for s = subject_code 
            
        for r = runs % For runs defined previously (scanning only here)
            fileName = dir([studyCode subject_code '_' task num2str(r) '*.mat']);
            
            if size(fileName,1)>1
                warning('More than 1 data file found for sub %d run %d',s,r)
            elseif size(fileName,1)==0
                warning('No data file found for sub %d run %d',s,r)
            else
                load(fileName.name)
                
            if r == 1 | 3
                new_tags = [ 'put tags here' ]
            elseif r == 2 | 4
                new_tags = [ 'put tags here' ]
            end
            
            run_info.tag = new_tags
            
            
                





