%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cue Reactivity behavioral analysis for REV  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% calculate number of non-responses for each run of React
outputDir = '~/Desktop/REV_scripts/behavioral/React/output';
% create a vector of the trial numbers for each condition
cd('~/Desktop/REV_scripts/behavioral/React/scripts/analyses');

if ~exist(outputDir, 'dir')
  mkdir(outputDir);
end

% Define columns in the task template
indexCol=1;
eventTypeCol=2;
numRuns=4;
numSubs=144;
numTrials = 105;

% Set up blank matrix
React_NoResponse_Count = nan(numSubs,numRuns);

for runNum=1:numRuns
    
    taskfile=dir(['React' num2str(runNum) '.txt']);
    
    for k=1:length(taskfile)
        data=dlmread(taskfile(k).name,'\t');
        RatingIndices = data(:,eventTypeCol) == 3;
        RatingEvents = data(RatingIndices, indexCol);
        
%         GoIndices = data(:,eventTypeCol)==1; % Create a binary vector to indicate whether a row is a go event
%         GoEvents = data(GoIndices,indexCol); % Provide the even number corresponding to the go events
%         NoGoIndices = data(:,eventTypeCol)==2; % Create a binary vector to indicate whehter a row is a no-go event
%         NoGoEvents = data(NoGoIndices,indexCol); % Provide the even number corresponding to the no-go events
%         RiskCue = data(:,stimTypeCol)==1;
%         NeutralCue = data(:,stimTypeCol)==2;
%         InstructionIndices = data(:,eventTypeCol)==0;
%         InstructEvents = data(InstructionIndices,indexCol);
        
        % 0 = instruction/crosshair
        % 1 = PRC
        % 2 = Neutral
        % 3 = desire rating
        
    end
    
    cd('~/Desktop/REV_BxData/data/React')
    files = dir(['*' num2str(runNum) '.mat']); %loads all the .mats in that directory into matlab's workspace.
    numFiles = length(files);

    % Create empty arrays
    NoResponse = nan(numFiles,numTrials);
    
    
    for i = 1:numFiles
        inputFilename = files(i).name;
        load(inputFilename);
        responsesRaw=run_info.responses; %pull out the cell array of button presses
        subNum = str2num(inputFilename(4:6));
        
        for t=1:numTrials % go through each trial
            % assign it to CorrGo column if it's CorrGo (any button press
            % counts as a go)
            if ismember(t,RatingEvents) && isempty(responsesRaw{t})
                NoResponse(i,t) = 1;
            end
        end
        
        React_NoResponse_Count(subNum,runNum) = nansum(NoResponse(i,:));
    end
end
    
    


dlmwrite([outputDir '/React_NoResponse_Count.txt'], React_NoResponse_Count, 'delimiter','\t');
