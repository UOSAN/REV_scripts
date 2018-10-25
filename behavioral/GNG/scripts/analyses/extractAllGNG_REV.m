%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GNG behavioral analysis for REV  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% extract # and RT of correct and incorrect Go and NoGo trials

outputDir = '~/Desktop/REV_scripts/behavioral/GNG/output';
% create a vector of the trial numbers for each condition
cd('~/Desktop/REV_scripts/behavioral/GNG/scripts/analyses');

if ~exist(outputDir, 'dir')
  mkdir(outputDir);
end

% Define columns in the task template
stimTypeCol=1;
indexCol=2;
eventTypeCol=3;
numRuns=4;
numSubs=144;
numTrials = 256;

% Set up 7 blank matrices
GNG_CorrGo_RT = nan(numSubs,numRuns);
GNG_IncorrNoGo_RT = nan(numSubs,numRuns);

GNG_CorrGo_Count = nan(numSubs,numRuns);
GNG_CorrNoGo_Count = nan(numSubs,numRuns);
GNG_IncorrNoGo_Count = nan(numSubs,numRuns);
GNG_IncorrGo_Count = nan(numSubs,numRuns);
GNG_Corr_Count = nan(numSubs,numRuns);

for runNum=1:numRuns
    
    taskfile=dir(['GNG' num2str(runNum) '.txt']);
    
    for k=1:length(taskfile);
        data=dlmread(taskfile(k).name,'\t');
        GoIndices = data(:,eventTypeCol)==1; % Create a binary vector to indicate whether a row is a go event
        GoEvents = data(GoIndices,indexCol); % Provide the even number corresponding to the go events
        NoGoIndices = data(:,eventTypeCol)==2; % Create a binary vector to indicate whehter a row is a no-go event
        NoGoEvents = data(NoGoIndices,indexCol); % Provide the even number corresponding to the no-go events
        RiskCue = data(:,stimTypeCol)==1;
        NeutralCue = data(:,stimTypeCol)==2;
    end
    
    cd('~/Desktop/REV_BxData/data/GNG')
    files = dir(['*' num2str(runNum) '.mat']); %loads all the .mats in that directory into matlab's workspace.
    numFiles = length(files);
    
    % corrGo
    % corrNoGo
    % inCorrNoGo
    % Instructions
    % Trash
    
    % Create a bunch of empty arrays
    CorrGo = nan(numFiles,numTrials);
    CorrGoRT = nan(numFiles,numTrials);
    CorrNoGo = nan(numFiles,numTrials);
    IncorrNoGo = nan(numFiles,numTrials);
    IncorrNoGoRT = nan(numFiles,numTrials);
    IncorrGo = nan(numFiles,numTrials);

    for i = 1:numFiles;
        inputFilename = files(i).name;
        load(inputFilename);
        responsesRaw=run_info.responses; %pull out the cell array of button presses
        rtsRaw=run_info.rt; %pull out the cell array of RTs
        subNum = str2num(inputFilename(4:6));
        
        for t=1:numTrials; % go through each trial
            % assign it to CorrGo column if it's CorrGo
            if ismember(t,GoEvents) && ~isempty(responsesRaw{t})
                CorrGo(i,t) = 1;
                CorrGoRT(i,t) = rtsRaw(t);
                
                % assign it to CorrNoGo column if it's CorrNoGo
            elseif ismember(t,NoGoEvents) && isempty(responsesRaw{t})
                CorrNoGo(i,t) = 1;
                
                % assign it to IncorrNoGo column if it's IncorrNoGo
            elseif ismember(t,NoGoEvents) && ~isempty(responsesRaw{t})
                IncorrNoGo(i,t) = 1;
                IncorrNoGoRT(i,t) = rtsRaw(t);
                
                % assign it to IncorrGo column if it's IncorrGo
            elseif ismember(t,GoEvents) && isempty(responsesRaw{t})
                IncorrGo(i,t) = 1;
            end
        end
        
        GNG_CorrGo_RT(subNum,runNum) = nanmean(CorrGoRT(i,:));
        GNG_CorrGo_RT_Risk(subNum,runNum) = nanmean(CorrGoRT(i,RiskCue));
        GNG_CorrGo_RT_Neutral(subNum,runNum) = nanmean(CorrGoRT(i,NeutralCue));
        GNG_IncorrNoGo_RT(subNum,runNum) = nanmean(IncorrNoGoRT(i,:));
        
        GNG_CorrGo_Count(subNum,runNum) = nansum(CorrGo(i,:));
        GNG_CorrGo_Count_Risk(subNum,runNum) = nansum(CorrGo(i,RiskCue));
        GNG_CorrGo_Count_Neutral(subNum,runNum) = nansum(CorrGo(i,NeutralCue));
        
        GNG_CorrNoGo_Count(subNum,runNum) = nansum(CorrNoGo(i,:));
        GNG_CorrNoGo_Count_Risk(subNum,runNum) = nansum(CorrNoGo(i,RiskCue));
        GNG_CorrNoGo_Count_Neutral(subNum,runNum) = nansum(CorrNoGo(i,NeutralCue));
        
        GNG_IncorrNoGo_Count(subNum,runNum) = nansum(IncorrNoGo(i,:));
        GNG_IncorrNoGo_Count_Risk(subNum,runNum) = nansum(IncorrNoGo(i,RiskCue));
        GNG_IncorrNoGo_Count_Neutral(subNum,runNum) = nansum(IncorrNoGo(i,NeutralCue));
        
        GNG_IncorrGo_Count(subNum,runNum) = nansum(IncorrGo(i,:));
        GNG_IncorrGo_Count_Risk(subNum,runNum) = nansum(IncorrGo(i,RiskCue));
        GNG_IncorrGo_Count_Neutral(subNum,runNum) = nansum(IncorrGo(i,NeutralCue));
        
        GNG_Corr_Count(subNum,runNum) = nansum(CorrGo(i,:))+nansum(CorrNoGo(i,:));
        
    end %end numFiles loop
end

% save('~/Desktop/REV/GNG/output/acc_GNG4');
save([outputDir 'rtMean_GNG']);
% dlmwrite('~/Desktop/REV/GNG/output/accuracyGNG4.txt', acc_GNG4, 'delimiter','\t');
dlmwrite([outputDir '/GNG_CorrGo_RT.txt'], GNG_CorrGo_RT, 'delimiter','\t');
dlmwrite([outputDir '/GNG_IncorrNoGo_RT.txt'], GNG_IncorrNoGo_RT, 'delimiter','\t');
dlmwrite([outputDir '/GNG_CorrGo_RT_Risk.txt'], GNG_CorrGo_RT_Risk, 'delimiter','\t');
dlmwrite([outputDir '/GNG_CorrGo_RT_Neutral.txt'], GNG_CorrGo_RT_Neutral, 'delimiter','\t');
dlmwrite([outputDir '/GNG_CorrGo_Count.txt'], GNG_CorrGo_Count, 'delimiter','\t');
dlmwrite([outputDir '/GNG_CorrGo_Count_Risk.txt'], GNG_CorrGo_Count_Risk, 'delimiter','\t');
dlmwrite([outputDir '/GNG_CorrGo_Count_Neutral.txt'], GNG_CorrGo_Count_Neutral, 'delimiter','\t');
dlmwrite([outputDir '/GNG_CorrNoGo_Count.txt'], GNG_CorrNoGo_Count, 'delimiter','\t');
dlmwrite([outputDir '/GNG_CorrNoGo_Count_Risk.txt'], GNG_CorrNoGo_Count_Risk, 'delimiter','\t');
dlmwrite([outputDir '/GNG_CorrNoGo_Count_Neutral.txt'], GNG_CorrNoGo_Count_Neutral, 'delimiter','\t');
dlmwrite([outputDir '/GNG_IncorrNoGo_Count.txt'], GNG_IncorrNoGo_Count, 'delimiter','\t');
dlmwrite([outputDir '/GNG_IncorrNoGo_Count_Risk.txt'], GNG_IncorrNoGo_Count_Risk, 'delimiter','\t');
dlmwrite([outputDir '/GNG_IncorrNoGo_Count_Neutral.txt'], GNG_IncorrNoGo_Count_Neutral, 'delimiter','\t');
dlmwrite([outputDir '/GNG_IncorrGo_Count.txt'], GNG_IncorrGo_Count, 'delimiter','\t');
dlmwrite([outputDir '/GNG_IncorrGo_Count_Risk.txt'], GNG_IncorrGo_Count_Neutral, 'delimiter','\t');
dlmwrite([outputDir '/GNG_IncorrGo_Count_Risk.txt'], GNG_IncorrGo_Count_Neutral, 'delimiter','\t');
dlmwrite([outputDir '/GNG_Corr_Count.txt'], GNG_Corr_Count, 'delimiter','\t');