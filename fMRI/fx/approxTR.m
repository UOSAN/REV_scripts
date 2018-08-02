function approxTR(varargin)
%task should either be SST, REACT, or GNG
%this script should get approximate number of TRs per subject per run (based on NODS mat file data)

%if you want to run from the command line and give the ID as an argument
if ~isempty(varargin)
    task=varargin{1};
else %pop up dialog box for task
    task=input('Please enter task as GNG, REACT, or SST: ','s');
end


%savePath=['~/Dropbox/REV_repos/REV_BxData/names_onsets_durations/'];
savePath=['~/Desktop/REV/REV_BxData/names_onsets_durations/'];
homePath=[savePath,task,filesep];
cd(savePath);

filename=strcat(task,'durations.txt');
    fid = fopen(filename,'w');
    
    fprintf(fid,'%s','subFile');
    fprintf(fid,'\t');
    fprintf(fid,'%s','finalOnset');
    fprintf(fid,'\t');
    fprintf(fid,'%s','approxTR');
    fprintf(fid,'\n');
    fclose(fid);

if task~="SST"
    taskPath=[homePath, 'vecs'];
    
    %filename=strcat(task,'durations.txt');
%     fid = fopen(filename,'w');
%     
%     fprintf(fid,'%s','subFile');
%     fprintf(fid,'\t');
%     fprintf(fid,'%s','finalOnset');
%     fprintf(fid,'\t');
%     fprintf(fid,'%s','approxTR');
%     fprintf(fid,'\n');
%     fclose(fid);
    
    cd(taskPath);
    fileNms=strsplit(ls);
    
    for i=1:length(fileNms)
        if ~strcmp(fileNms{i},filename) && ~isempty(fileNms{i})
            NODS=load(fileNms{i});
            for c=1:length(NODS.onsets)
                if c==1
                    maxO=max(NODS.onsets{c});
                else
                    if max(NODS.onsets{c})>maxO
                        maxO=max(NODS.onsets{c});
                    end
                end
            end
            
            cd(savePath)
            fid = fopen(filename,'a');
            fprintf(fid,'%s',fileNms{i});
            fprintf(fid,'\t');
            
            fprintf(fid,'%s',num2str(maxO));
            fprintf(fid,'\t');
            fprintf(fid,'%s',num2str(maxO*.505));
            
            fprintf(fid,'\n');
            fclose(fid);
            
            cd(taskPath)
        end
    end
    
else
    
    
    cd(homePath)
    fileNms=strsplit(ls);
    
    for i=1:length(fileNms)
        if ~strcmp(fileNms{i},filename) && ~isempty(fileNms{i})
            taskPath=[homePath, fileNms{i}, '/fx/vecs/'];
            cd(taskPath)
            
            subFiles=strsplit(ls);
            for f=1:length(subFiles)
                if ~isempty(subFiles{f})
                    NODS=load(subFiles{f});
                    for c=1:length(NODS.onsets)
                        if c==1
                            maxO=max(NODS.onsets{c});
                        else
                            if max(NODS.onsets{c})>maxO
                                maxO=max(NODS.onsets{c});
                            end
                        end
                    end
                    
                    cd(savePath);
                    
                    fid = fopen(filename,'a');
                    fprintf(fid,'%s',subFiles{f});
                    fprintf(fid,'\t');
                    
                    fprintf(fid,'%s',num2str(maxO));
                    fprintf(fid,'\t');
                    fprintf(fid,'%s',num2str(maxO*.505));
                    
                    fprintf(fid,'\n');
                    fclose(fid);
                    
                    cd(taskPath)
                end
            end
        end

    end
    
end

end
