numSubs = 144;
runs = [1 2 3 4];
datadir = '~/Desktop/REV_BxData/names_onsets_durations/gng/prepost_analysis/';
outputDir = '~/Desktop/REV_scripts/fMRI/fx/gng/prepost_analysis/';
%'~/Desktop/REV_BxData/names_onsets_durations/SST/'; %edit this path for your local computer
taskname = 'gng';
studyPrefix='REV';
cd(datadir)

if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Set up a blank matrix
onsets_column_check = nan(numSubs,36);

for s=1:numSubs
    
    % Create subjectCode
    if s<10
        placeholder = '00';
    elseif s<100
        placeholder = '0';
    else placeholder = '';
    end
    
    subjectCode = [studyPrefix placeholder num2str(s)];
    
    for r=runs % For runs defined previously (scanning only here)
        filename = ['sub-' subjectCode '_task-' taskname '_acq-' num2str(r) '_onsets.mat'];
        if r==1
            c=1;
        elseif r==2
            c=10;
        elseif r==3
            c=19;
        elseif r==4
            c=28;
            
            if exist(filename)
                load(filename)
                if length(names) < 9
                    if ~any(strcmp(names,'baseline'))
                        onsets_column_check(s,c) = ['baseline run' r];
                    else
                        sprintf(['sub-' subjectCode ' has baseline.'])
                    end
                    if ~any(strcmp(names,'correct_risk_go'))
                        onsets_column_check(s,c+1) = ['correct_risk_go run' r];
                    else
                        sprintf(['sub-' subjectCode ' has correct_risk_go.'])
                    end
                    if ~any(strcmp(names,'correct_risk_nogo'))
                        onsets_column_check(s,c+2) = ['correct_risk_nogo run' r];
                    else
                        sprintf(['sub-' subjectCode ' has correct_risk_nogo.'])
                    end
                    if ~any(strcmp(names,'correct_neutral_go'))
                        onsets_column_check(s,c+3) = ['correct_neutral_go run' r];
                    else
                        sprintf(['sub-' subjectCode ' has correct_neutral_go.'])
                    end
                    if ~any(strcmp(names,'correct_neutral_nogo'))
                        onsets_column_check(s,c+4) = ['correct_neutral_nogo run' r];
                    else
                        sprintf(['sub-' subjectCode ' has correct_neutral_nogo.'])
                    end
                    if ~any(strcmp(names,'incorrect_risk_go'))
                        onsets_column_check(s,c+5) = ['incorrect_risk_go run' r];
                    else
                        sprintf(['sub-' subjectCode ' has incorrect_risk_go.'])
                    end
                    if ~any(strcmp(names,'incorrect_risk_nogo'))
                        onsets_column_check(s,c+6) = ['incorrect_risk_nogo run' r];
                    else
                        sprintf(['sub-' subjectCode ' has incorrect_risk_nogo.'])
                    end
                    if ~any(strcmp(names,'incorrect_risk_nogo'))
                        onsets_column_check(s,c+7) = ['incorrect_risk_nogo run' r];
                    else
                        sprintf(['sub-' subjectCode ' has incorrect_risk_nogo.'])
                    end
                    if ~any(strcmp(names,'incorrect_neutral_go'))
                        onsets_column_check(s,c+8) = ['incorrect_neutral_go run' r];
                    else
                        sprintf(['sub-' subjectCode ' has incorrect_neutral_go.'])
                    end
                    if ~any(strcmp(names,'incorrect_neutral_nogo'))
                        onsets_column_check(s,c+8) = ['incorrect_neutral_nogo run' r];
                    else
                        sprintf(['sub-' subjectCode ' has incorrect_neutral_nogo.'])
                    end
                elseif length(names)==9
                    sprintf(['sub-' subjectCode ' has 9 columns.'])
                end
                
            end
        end
    end
end


dlmwrite([outputDir '/onsets_column_check.txt'], onsets_column_check, 'delimiter','\t');
