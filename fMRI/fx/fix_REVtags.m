function fix_REVtags

%% Set up directories to be referenced later!

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
    if exist(sublist{s,2},'dir')
    cd(sublist{s,2}) %cd into base gng folder for each subject
    
    files = ls('*.mat');
    matFiles = strsplit(files(1,:),'\n');
    mfiles = matFiles(1:(length(matFiles)-1)); %list of all matfiles
    
    end
        
        subFile = load(mfiles{f});
        
        for t = 1:length(subFile.run_info.tag{t})
            if isempty(subFile.run_info.tag{t})
                fprintf('~~~~Oy vey!!~~~~~\n.');
            end
    end

end

end











