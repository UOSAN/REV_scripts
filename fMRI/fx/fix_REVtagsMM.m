function fix_REVtags
%**********************DECLARING GLOBAL VARIABLES**************************
global subs
%**************************************************************************

%% Set up directories to be referenced!
baseDir = '/Users/Melissa/Dropbox/REV_repos'; %mmoss for laptop, Melissa for desktop
dataDir = [baseDir '/REV_BxData'];
%subDirs = [dataDir '/scanning/' sublist{1} '/base/GNG'];
tagDir = [baseDir '/REV_scripts/behavioral/tasks/REV_GNG'];

%set working directory
[wdpath, ~, ~] = fileparts(which(mfilename));
cd(wdpath)

%***************************IMPORT GNG TAGS********************************

cd(tagDir)

%% Import data from text file.
% Script for importing data from the following text file:
%
%    /Users/Melissa/Dropbox/REV_repos/REV_scripts/behavioral/tasks/REV_GNG/gng_tags.txt

% Initialize variables.
filename = '/Users/Melissa/Dropbox/REV_repos/REV_scripts/behavioral/tasks/REV_GNG/gng_tags.txt';
delimiter = '\t';
startRow = 3;

% Read columns of data as strings:
formatSpec = '%s%s%s%s%[^\n\r]';

% Open the text file.
fileID = fopen(filename,'r');

% Read columns of data according to format string.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

% Close the text file.
fclose(fileID);

% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


% Allocate imported array to column variable names
tag_gng1 = cell2mat(raw(:, 1));
tag_gng2 = cell2mat(raw(:, 2));
tag_gng3 = cell2mat(raw(:, 3));
tag_gng4 = cell2mat(raw(:, 4));

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me;

%NOTE: each column from the original text file is now represented by a
%variable in Matlab workspace, using the column name (e.g., 'tag_gng1')

%%
%***************************CHECK GNG BASE*********************************

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
    cd(dataDir);
    if exist(sublist{s,2},'dir')
        cd(sublist{s,2}) %cd into base gng folder for each subject
        
        %subdirFiles=isEmptyDirectory(pwd);
        %if subdirFiles>0
        if any(size(dir([pwd '/*.mat' ]),1))
            
            files = ls('*.mat');
            matFiles = strsplit(files(1,:));
            mfiles = matFiles(1:(length(matFiles)-1)); %list of all matfiles
            
            for m = 1:length(mfiles)
                gng1 = strfind(mfiles(m),'GNG1');
                gng2 = strfind(mfiles(m),'GNG2');
                
                if ~isempty(gng1{:})
                    %impute values from gng1
                    %fprintf('\nImputing gng1 tags for %s', sublist{s,1}); %optional line
                    checkTagsCol(mfiles(m),tag_gng1);
                elseif ~isempty(gng2{:})
                    %impute values from gng2
                    %fprintf('\nImputing gng2 tags for %s', sublist{s,1}); %optional line
                    checkTagsCol(mfiles(m),tag_gng2);
                else
                    fprintf('\nfor %s no gng1 or 2!',sublist{s,1})
                end
            end
            
        else
            fprintf('\nNo .mat files in gng base folder for %s', sublist{s,1})
        end
        
    end
    
    if exist(sublist{s,3},'dir')
        cd(sublist{s,3}) %cd into end gng folder for each subject
        
        %subdirFiles=isEmptyDirectory(pwd);
        %if subdirFiles>0
        if any(size(dir([pwd '/*.mat' ]),1))
         
            files2 = ls('*.mat');
            matFiles2 = strsplit(files2(1,:));
            mfiles2 = matFiles2(1:(length(matFiles2)-1)); %list of all matfiles
            
            for m = 1:length(mfiles2)
                gng3 = strfind(mfiles2(m),'GNG3');
                gng4 = strfind(mfiles2(m),'GNG4');
                
                if ~isempty(gng3{:})
                    %impute values from gng3
                    %fprintf('\nImputing gng3 tags for %s', sublist{s,1}); %optional line
                    checkTagsCol(mfiles2(m),tag_gng3);
                elseif ~isempty(gng4{:})
                    %impute values from gng4
                    %fprintf('\nImputing gng4 tags for %s', sublist{s,1}); %optional line
                    checkTagsCol(mfiles2(m),tag_gng4);
                else
                    fprintf('\nfor %s no gng3 or 4!',sublist{s,1})
                end
            end
            
        else
            fprintf('\nNo .mat files in gng end folder for %s', sublist{s,1})
        end
        
    end
end
end

function checkTagsCol(mfile,tagObj)
%**************************************************************************
%no global vars necessary
%**************************************************************************

subFile = load(mfile{:});

for t = 2:length(subFile.run_info.tag)
    if isempty(subFile.run_info.tag{t})
        subFile.run_info.tag{t}=tagObj(t-1);
    end
end
%fprintf('\n\nDone!\n\n'); %optional line
end


function x = isEmptyDirectory(p)
    if isdir(p)
      f = dir(p);
      x = length(f)>2; %this is the number of files in the dir
%     else 
%       error('Error: %s is not a directory');     
    end; 
end







