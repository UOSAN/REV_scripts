%% Create output .txt files for each participant containing column for Stimulus Type (PRC or Neutral), Trial Number, and Desire Rating

% For rating indices, get rating if cell is not empty. if cell is empty, then put in NaN

outputDir = '~/Desktop/REV_BxData/data/React/desire_ratings/';
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
        if exist([data '.mat']);
            load([data '.mat']);
           
           % Convert from cell to double 
           run_info.tag = str2double(run_info.tag);
           run_info.responses = str2double(run_info.responses);
           
           % Create the condition vector
           conditionIndices = run_info.tag() == 1 | run_info.tag() == 2; % PRC = 1, Neutral = 2
           conditionEvents = num2cell(run_info.tag(conditionIndices));
           
           % Create the ratings vector 
           ratingIndices = run_info.tag() == 3;
           ratingEvents = num2cell(run_info.responses(ratingIndices))';
            
           % Create the trial number vector
           trial=num2cell((1:length(ratingEvents)))';
           
            %% Make everything into tables to convert to .csv
            tableC=cell2table(conditionEvents, 'VariableNames',{'condition'});
            tableT=cell2table(trial, 'VariableNames',{'trial'});
            tableR=cell2table(ratingEvents, 'VariableNames',{'rating'});
            
            % recode raw responses to 1-5 scale of Desire Ratings 
            for i=1:height(tableR)
                if tableR{i,:} == 5
                    tableR{i,:} = 1;
                elseif tableR{i,:} == 6
                    tableR{i,:} = 2;
                elseif tableR{i,:} == 7
                    tableR{i,:} = 3;
                elseif tableR{i,:} == 8
                    tableR{i,:} = 4;
                elseif tableR{i,:} == 9
                    tableR{i,:} = 5;
                end
            end
            
            % Combine variables on interest into single table     
            finaltable=horzcat(tableC,tableT,tableR);
           
            %% Save a .csv file for each participant
            % NOTE: Col 1 = Condition (PRC=1, Neutral=2); Col 2 =
            % Trial number, Col 3 = Desire Rating (1-5)
            
            outputName = ['REV' placeholder num2str(s) '_taskData' '_React' num2str(runNum), '.csv'];
            writetable(finaltable,strcat(outputDir,outputName),'WriteVariableNames',false);
            
        end
    end
end
