studyCode = 'REV';
firstSub = 1;
lastSub = 144;
exclude = 143;
%exclude = [];%[4 5 7 8 12 14 15 25 28 30 33 40 42 45 61 63 64 66 71 72 79 81 83 85 87 92 95 96 99 101 103 105 106 112 113 120 122 123 125 128 132 133 139 143]; % If you want to exclude any numbers, put them in this vector (e.g. exclude = [5 20];)
task = 'React';
runs = [1 2 3 4];
%repodir = ['~/Desktop/REV_BxData/']; %edit this path for your local computer
repodir = ['~/Dropbox/REV_repos/REV_BxData/'];
dataFolder = [repodir 'data/' task '/data_prc_tags'];
% 
% ALCsubs=table2dataset(readtable('~/Downloads/subListAlc.txt','ReadVariableNames',false));
% DRUGsubs=table2dataset(readtable('~/Downloads/subListDrug.txt','ReadVariableNames',false));
% TOBACsubs=table2dataset(readtable('~/Downloads/subListTobac.txt','ReadVariableNames',false));
% FOODsubs=table2dataset(readtable('~/Downloads/subListFood.txt','ReadVariableNames',false));

prcListForVecs = table2dataset(readtable([repodir 'prc_mappings/prcListForVecs.txt'],'ReadVariableNames',false,'Delimiter','\t'));
%length(prcListForVecs.Var1(strcmp(prcListForVecs.Var1,'_F'))) %do for all
%possible combos of PRC to get number of pp in each group
%A: 0
%D: 0
%T: 2
%F: 49
%AD: 3
%AT: 4
%AF: 13
%DT: 2
%DF: 11
%TF: 19
%ADT: 2
%ADF: 6
%ATF: 15
%DTF: 11
%ADTF: 6

reruns=[59];
for s = reruns
%for s = firstSub:lastSub
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
            %fileName = dir(['*' subject_code '*' task num2str(r) '*.mat']);
            fileName = dir([subject_code '_', task num2str(r) '.mat']);
            if size(fileName,1)>1
                warning('More than 1 data file found for sub %d run %d',s,r)
            %elseif size(fileName,1)==0
                warning('No data file found for sub %d run %d',s,r)
            elseif exist(fileName.name,'file')
                load(fileName.name)
                
                %don't need baseline
                %split out risk into categories
                
                %get the A/D/T/F letter set for each sub
                fEnd = prcListForVecs.Var1(strcmp(prcListForVecs.Var2, [placeholder num2str(s)]));
                

%                 a=strfind(ALCsubs.Var1{:},[placeholder num2str(s)]);
%                 d=strfind(DRUGsubs.Var1{:},[placeholder num2str(s)]);
%                 t=strfind(TOBACsubs.Var1{:},[placeholder num2str(s)]);
%                 f=strfind(FOODsubs.Var1{:},[placeholder num2str(s)]);
                
                
                lst=['A' 'D' 'T' 'F'];
                %strfind(fEnd,'F');
                
                PRC={'risk_alcohol' 'risk_drug' 'risk_tobacco' 'risk_food'};
                tagStr={10 11 12 13};
                pos=3;
                
                names = {'neutral_view' 'rating'}; % baseline = instructions, blank screen, & fixation
                searchStrings = {2 3};
                    %saveFile = [fxFolder 'sub-' subject_code '_task-' task '_acq-' num2str(r) '_onsets_', upper(fileEnd), '.mat'];
                    
                for p=1:length(lst)
                    %if ~isempty(eval(lst(p)))
                    zz=strfind(fEnd,lst(p));
                    if ~isempty(zz{:})
                        names(pos)=PRC(p);
                        searchStrings(pos)=tagStr(p);
                        pos=pos+1;
                    end
                end

                onsets = cell(1,length(names));
                durations = cell(1,length(names));

                for c = 1:length(names)
                    %currentIndices = find(~cellfun(@isempty,strcmp(run_info.tag,searchStrings{c})) == 1);
                    %currentIndices = find(strcmp(num2str(run_info.tag),searchStrings{c}));
                    currentIndices = find(run_info.tag==searchStrings{c});
                    onsets{c} = run_info.onsets(currentIndices);
                    durations{c} = run_info.durations(currentIndices);
                end
                
                %empty (i.e. deselect) "baseline" vector
                %names([1])=[];
                %onsets([1])=[];
                %durations([1])=[];
                
                fxFolder = [repodir 'names_onsets_durations/' task '/PRC/'];
                if exist(fxFolder)==7 %do nothing
                else mkdir(fxFolder)
                end    
                flNm = strcat(fxFolder, 'sub-', subject_code, '_task-', task, '_acq-', num2str(r), '_onsets', fEnd, '.mat');
                save(flNm{:}, 'names', 'onsets', 'durations'); %Note that NODs files should be distinguished by acq number, NOT run number
            else
                fprintf('%s \n',fileName.name);
            end
        end
        %sprintf('%s','Yay, finished ',subject_code,'!');
        fprintf('Yay, finished %s!\n',subject_code);
    end
    
end
