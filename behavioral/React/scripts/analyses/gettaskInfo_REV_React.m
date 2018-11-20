%% Create output .txt files for each participant containing column for Stimulus Type (PRC or Neutral), Trial Number, and Desire Rating

% For rating indices, get rating if cell is not empty. if cell is empty, then put in NaN

outputDir = '~/Desktop/REV_BxData/data/React/desire_ratings';
% create a vector of the trial numbers for each condition
cd('~/Desktop/REV_BxData/data/React/');

if ~exist(outputDir, 'dir')
  mkdir(outputDir);
end

numRuns=4;
numSubs=144;
numTrials=105;

%% Loop through subjects
for s=1:numSubs
        %% Format subject numbers
        if s<10
            placeholder = '00';
        elseif s<100
            placeholder = '0';
        else placeholder = '';
        end
        
    for runNum=1:numRuns
        % Specify data file names
        data=['REV' placeholder num2str(s) '_React' num2str(runNum)];
        if exist([data '.mat'])
            load([data '.mat'])
           
           % Convert from cell to double 
           run_info.tag = str2double(run_info.tag)
           run_info.responses = str2double(run_info.responses)
           
           % Define index column
           indexCol = 1:length(run_info.tag);
           
           PRCIndices = run_info.tag() == 1;
           PRCEvents = run_info.tag(RatingIndices);
           
           NeutralIndices = run_info.tag() == 2;
           
           % Create the ratings vector 
           RatingIndices = run_info.tag() == 3;
           RatingEvents = run_info.responses(RatingIndices);
            
           % Record the trial number
           trial=1:length(RatingEvents)
            
        end
    end
end
