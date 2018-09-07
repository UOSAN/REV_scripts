numSubs = 144;
runs = [1 2 13 14];
datadir = '~/Desktop/REV_BxData/names_onsets_durations/SST/'; %edit this path for your local computer
studyPrefix='REV';
cd datadir

for s=1:numSubs
    
    % Create subjectCode
    if s<10
        placeholder = '00';
    elseif s<100
        placeholder = '0';
    else placeholder = '';
    end
    
    subjectCode = [studyPrefix placeholder num2str(s)]
    
    for r=runs % For runs defined previously (scanning only here)
            filename = ['sub-' subjectCode '_task-sst_acq-' num2str(r) '_onsets.mat'];
            if exist(filename)
                load(filename)
    
end