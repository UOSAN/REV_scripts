function fix_REVtags
%n == number of last subject (here, it's 144)

baseDir = '/Users/mmoss/Dropbox/REV_repos';
dataDir = [baseDir '/REV_BxData'];
subDirs = [dataDir '/scanning/' sublist{1} '/base/GNG'];
tagDir = [baseDir '/REV_scripts/behavioral/tasks/REV_GNG'];

cd(dataDir);

subs = readtable('REVsubsList.txt');
listLength = size(subs);
nSubs = listLength(1);


sublist = cell(nSubs,3);

for x = 1:nSubs
    sublist{x,1} = subs.SUBJECTS{x}; %column of subject folder names ('REV###')
    sublist{x,2} = [dataDir '/scanning/' sublist{x,1} '/base/GNG']; %column of base scan directories for each sub
    sublist{x,3} = [dataDir '/scanning/' sublist{x,1} '/end/GNG']; %column of end scan directories for each sub
end


for s = 1:nSubs
    cd(sublist{s,2}) %cd into base gng folder for each subject
    
    files = ls('*.mat');
    matFiles = strsplit(files(1,:),'\n');
    mfiles = matFiles(1:(length(matFiles)-1)); %list of all matfiles
    
    
    for f = 1:length(mfiles)
        if ~isempty(regexp(mfiles{1},'GNG1','match'))
            %read that shit in!
            filename = strcat(tagDir,'GNG1.txt');
            delimiter = '\n';
            startRow = 2;
            formatSpec = '%f%f%f%f%f%f%f%f%s%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
            fileID = fopen(filename,'r');

% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

% Close the text file.
fclose(fileID);



        end
    end
    
        
        subFile = load(mfiles{f});

        
        for t = 1:length(subFile.run_info.tag{t})
            if isempty(subFile.run_info.tag{t})
                fprintf('~~~~~Did not merge EEG and behavioral data yet!!~~~~~\n.');
    end
GNG2
fprintf('\n\n\n**** %s: Adding channel location info ****\n\n\n', SUBnum);
    %do the thing...
    %load in .mat file
    %for each item in the tag field, if isempty(run_info.tag{1}), input
    %that line from the text file
end
suberp=v2struct(load([pwd,'/',sublist{s}, mfile]));
        erpDS=suberp.EEGAVE_i; %dimensions: electrode(s) x timepoints x bins
        erpDS2=suberp.BEHdata;
        %if LRP==1, dimensions: timepoints x bins
        
        AllErps{s}=erpDS;
        AllBEH{s}=erpDS2;
        
        fprintf('\n**** %s Down! ****\n', num2str(s));

for s = 1:length(sublist)
        cd('~/Dropbox/P.ConflictFlanker/DataAnalysis/Mel Scripts');
        %    cd(strcat('~/Dropbox/P.ConflictFlanker/DataAnalysis/Matlab/EEG/',sublist{s}))
        MelPrepsEEGdata(sublist{s}, PREP)
end
    



end











