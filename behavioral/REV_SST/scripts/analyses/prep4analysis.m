%%% Original script by LEK %%%

% This script will copy the SST .mat files to the
% analyisReady folder and rename them

% INITIAL SETUP (may need to change these parameters)
%cd('~/Desktop/REV_scripts/behavioral/REV_SST/output/')
cd('~/Desktop/REV_scripts/behavioral/REV_SST/output/')
prefix = 'REV';
Subs=[1:144]
    %1:3 6 9 10:11 13 16:24 26:27 29 31 32 34:39 41 43 44 46:60 62 65 67:70 73:78 80 82 84 86 88:91 93 94 97 98 100 102 104 107:111 114:119 121 124 126:127 129:131 134:138 140:142 144];
%startSub = 1;
%endSub = 144;
startRun = 1;
endRun = 14;

% COPY AND RENAME FILES
for s=Subs   %for s=startSub:endSub
 
    if exist('pre', 'dir')
        cd pre
        try
            copyfile(['sub' num2str(s) '*.mat'],'../analysisReady')
        catch
            warning('pre data for %d does not exist',s)
        end
        cd ..
    else 
        warning('pre dir does not exist')
    end
    
    if exist('post', 'dir')
        cd post
        try
            copyfile(['sub' num2str(s) '*.mat'],'../analysisReady')
        catch
            warning('post data for %d does not exist',s)
        end
        cd ..
    else 
        warning('post dir does not exist')
    end    
    
    if exist('train', 'dir')
        cd train
        try
            copyfile(['sub' num2str(s) '*.mat'],'../analysisReady')
        catch
            warning('training data for %d does not exist',s)
        end
        cd ..
    else 
        warning('training dir does not exist')
    end 
    
    cd analysisReady
    
    for r=startRun:endRun
        try 
            filename = ls(['sub' num2str(s) '_run' num2str(r) '_*.mat']);
            filename = strtrim(filename);
            if exist(filename,'file') % check that it's a single file
                movefile(filename,[prefix '_sub' num2str(s) '_run' num2str(r) '.mat'])
            else
                fprintf('Multiple files for subject %d run %d\n',s,r)
            end
        catch
            fprintf('No file for subject %d run %d\n',s,r)
        end
    end
    cd ..
end



