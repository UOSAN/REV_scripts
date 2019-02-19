function fix_REVtagsPRC
%
% This function must be used ~after~ 'fix_REVtags'
% It is only necessary if you need to include PRC categories in the trial
% tags (i.e., 'food_view' instead of just 'risk_view')
%
% If you need to switch the tags back, just re-run 'fix_REVtags'

%% Set up directories to be referenced later

studyCode = 'REV';
firstSub = 1;
lastSub = 144;
exclude = [];%[4 5 7 8 12 14 15 25 28 30 33 40 42 45 61 63 64 66 71 72 79 81 83 85 87 92 95 96 99 101 103 105 106 112 113 120 122 123 125 128 132 133 139 143]; % If you want to exclude any numbers, put them in this vector (e.g. exclude = [5 20];)
task = 'React'; %'GNG';
runs = [1 2 3 4];
%dataFolder = ['/Users/kristadestasio/Desktop/REV_scripts/behavioral/' task '/data'];
repodir = ['~/Dropbox/REV_repos/REV_BxData/'];

dataFolder = [repodir 'data/' task '/data_prc_tags'];

reactRunsFolder='~/Dropbox/REV_repos/REV_scripts/behavioral/tasks/REV_React/';
prcFolder=[repodir,'prc_mappings/'];

cd(dataFolder)

%for s = firstSub:lastSub
for s = 59
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
        
        %prcList=table2array(readtable(['/Users/Melissa/Dropbox/aaaa_PRC_STUFF/',subject_code,'_PRC.txt']));
        prcImgs = [prcFolder,'sub_PRCcats/',subject_code,'_PRC.txt'];
        
        if size(prcImgs,1)>1
            warning('More than 1 data file found for sub %d run %d',s)
        elseif size(prcImgs,1)==0
            warning('No data file found for sub %d run %d',s)
        elseif exist(prcImgs)
            prcList=table2array(readtable([prcFolder,'sub_PRCcats/',subject_code,'_PRC.txt'],'Delimiter','\t','ReadVariableNames',true,'ReadRowNames',false));
            %prcList=readtable([prcFolder,'sub_PRCcats/',subject_code,'_PRC.txt'],'Delimiter','\t');
            
            for r=runs % For runs defined previously (scanning only here)
                runFile = [reactRunsFolder task num2str(r) '.txt'];
                reactRun = table2array(readtable(runFile));
                reactRun=reactRun([1:21,23:42,44:63,65:84,86:length(reactRun)],:); %get rid of blank rows
                
                filename = [subject_code '_' task num2str(r) '.mat'];
                
                if size(filename,1)>1
                    warning('More than 1 data file found for sub %d run %d',s,r)
                elseif size(filename,1)==0
                    warning('No data file found for sub %d run %d',s,r)
                elseif exist(filename)
                    load(filename)
                    
                    if length(reactRun)==length(run_info.tag)
                        for i=1:length(reactRun)
                            %img=strsplit(reactRun{i,:},{'\t'});
                            %img_name=strsplit(img{10},'.jpg');
                            %img_name=img_name{1};
                            img=reactRun;
                            img_name=strsplit(img{i,10},'.jpg');
                            img_name=img_name{1};
                            
                            start=strfind(img_name,'justlook');
                            blnk=strfind(img_name,'blank');
                            neutr=strfind(img_name,'Neutral');
                            rate=strfind(img_name,'desire');
                            
                            if ~isempty(neutr)
                                run_info.tag(i)=2;
                            elseif ~isempty(rate)
                                run_info.tag(i)=3;
                            elseif ~isempty(start) || ~isempty(blnk)
                                run_info.tag(i)=0;
                            end
                            for v=1:length(prcList)
                                %if strfind(reactRun{i,:},prcList(v,2))
                                z=strfind(img_name,num2str(prcList{v,2}));
                                %if ~isempty(z{:})
                                if ~isempty(z)
                                    aa=strfind(prcList{v,3},'alcohol');
                                    dd=strfind(prcList{v,3},'drug');
                                    tt=strfind(prcList{v,3},'tobacco');
                                    ff=strfind(prcList{v,3},'food');
                                    if ~isempty(aa)
                                        run_info.tag(i)=10;
                                    elseif ~isempty(dd)
                                        run_info.tag(i)=11;
                                    elseif ~isempty(tt)
                                        run_info.tag(i)=12;
                                    else %food
                                        run_info.tag(i)=13;
                                    end
                                    
                                end
                            end
                        end
                        
                        save(filename, 'key_presses', 'run_info')
                        
                    else
                        sprintf('size DOES matter for %s',subject_code);
                    end
                end
            end
        end
    end
end

end

