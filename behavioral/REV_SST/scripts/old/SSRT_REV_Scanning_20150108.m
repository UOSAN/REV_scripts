%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Stopfmri %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Adam Aron 12-01-2005
%%% Adapted for OSX Psychtoolbox by Jessica Cohen 12/2005
%%% Modified for use with new BMC trigger-same device as button box by JC 1/07
%%% Sound updated and modified for Jess' dissertation by JC 10/08
%%% LEK 2014/12/23
% updated 1-8-15 to standardize area instead of height

cd('~/Desktop/REV_SST/output')
clear all;
% output version
script_name='Stopfmri: optimized SSD tracker for fMRI';
script_version='1';
revision_date='1-3-15';

notes={'Design developed by Aron, Newman and Poldrack, based on Aron et al. 2003'};
standardImHeight = 200;
standardImArea=standardImHeight*standardImHeight;
oval2imRatio=2;
trialsPerStimType=128;
stListFile='stimFile_scanning.txt';
jitterListFile='jitter.txt';
FLAG_FASTER = 0;
colorFlags=1;

% read in subject initials
fprintf('%s %s (revised %s)\n',script_name,script_version, revision_date);
subject_code=input('Enter subject number (integer only): ');
sub_session=input('Is this the subject''s first or second scan today? (Enter 1 or 2): ');
preOrPost=input('Is this the pre or post scan? (Enter 1 for pre or 2 for post): ');
MRI=input('Are you scanning? 1 if yes, 0 if no: ');

if preOrPost == 1
    preOrPostStr='pre';
elseif preOrPost == 2
    preOrPostStr='post';
end

cd(preOrPostStr)

%read in tab delimited file set up like MacStim (textread will read in as
%col vectors)
% [type,num,pre,maxTime,totTime,rep,stpEvt,bg,st,bgFile,stFile,hshift,vshift,tag]= textread(tdfile, '%c %d %f %f %f %d %s %c %c %s %s %d %d %s','delimiter', '\t', 'whitespace', '', 'commentstyle', 'matlab' );
[riskStim] = textread(stListFile, '%s','delimiter', '\t', 'whitespace', '', 'commentstyle', 'matlab' );
[postjitter] = textread(jitterListFile, '%n','delimiter', '\t', 'whitespace', '', 'commentstyle', 'matlab' );
indices = [1:length(riskStim)];
rng('default')
rng('shuffle')
riskStim = Shuffle(riskStim);

if sub_session==1,
    LADDER1IN=250 %input('Ladder1 start val (e.g. 250): ');
    LADDER2IN=350 %input('Ladder2 start val (e.g. 350): ');
    %Ladder Starts (in ms):
    Ladder1=LADDER1IN;
    Ladder(1,1)=LADDER1IN;
    Ladder2=LADDER2IN;
    Ladder(2,1)=LADDER2IN;
elseif sub_session==2, %% this code looks up the last value in each staircase
    sub_session_temp = sub_session;
    trackfile=input('Enter name of subject''s previous ''mat'' file to open: ','s');
    load(trackfile);
    clear Seeker; %gets rid of this so it won't interfere with current Seeker
    
    startval=length(Ladder1);
    Ladder(1,1)=Ladder1(startval);
    Ladder(2,1)=Ladder2(startval);
    sub_session = sub_session_temp
end;

if preOrPost == 1
    sub_session = sub_session;
elseif preOrPost ==2
    sub_session = sub_session+2;
end

cumulativeSessNum = sub_session;
cumulativeSessNum = sub_session + 10;

%load relevant input file for scan (there MUST be st1b1.mat & st1b2.mat)
inputfile=sprintf('st%db%d.mat',subject_code,sub_session);
load(inputfile); % variable is trialcode

% write trial-by-trial data to a text logfile
d=clock;
logfile=sprintf('sub%d_scan%d_stopsig.log',subject_code,sub_session);
fprintf('A log of this session will be saved to %s\n',logfile);
fid=fopen(logfile,'a');
if fid<1,
    error('could not open logfile!');
end;

fprintf(fid,'Started: %s %2.0f:%02.0f\n',date,d(4),d(5));
WaitSecs(1);

%Seed random number generator
rand('state',subject_code);

try,  % goes with catch at end of script
    
    %% set up INPUT DEVICES
    [inputDevice] = setUpDevices(MRI); % FUNCTION CREATED BY LEK 12/20/14
    
    % set up SCREENS
    [w ArrowSize ArrowPosX ArrowPosY xcenter ycenter] = setUpScreens()
    
    %Preload stim
    imagetex = zeros(1,length(riskStim)); %initialize imagetex for pics
    for i=1:trialsPerStimType
        img = imread(riskStim{i});
        itex = Screen('MakeTexture', w, img);
        imagetex(i) = itex;
    end
    
    %Adaptable Constants
    % "chunks", will always be size 64:
    NUMCHUNKS=4;  %gngscan has 4 blocks of 64 (2 scans with 2 blocks of 64 each--but says 128 b/c of interspersed null events)
    Step=50;
    ISI=1.5; %set at 1.5
    BSI=1 ;  %NB, see figure in GNG4manual (set at 1 for scan)
    arrow_duration=1; %because stim duration is 1.5 secs in opt_stop
    
    %%% FEEDBACK VARIABLES
    if MRI==1,
        %trigger = KbName('t');
        trigger = [52];
        blue = KbName('b');
        yellow = KbName('y');
        green = KbName('g');
        red = KbName('r');
        %LEFT=[98 5 10];   %blue (5) green (10)
        LEFT = [91];
        RIGHT=[94];
        %RIGHT=[121 28 21]; %yellow (28) red (21)
    else,
        LEFT=[197];  %<
        RIGHT=[198]; %>
    end;
    
    if sub_session==1;
        error=zeros(1, NUMCHUNKS/2);
        rt = zeros(1, NUMCHUNKS/2);
        count_rt = zeros(1, NUMCHUNKS/2);
    end;
    
    %%%% Setting up the sound stuff
    [wave pahandle] = configSound();
    
    %%%%%%%%%%%%%% Stimuli and Response on same matrix, pre-determined
    % The first column is trial number;
    % The second column is numchunks number (1-NUMCHUNKS);
    % The third column is 0 = Go, 1 = NoGo; 2 is null, 3 is notrial (kluge, see opt_stop.m)
    % The fourth column is 0=left, 1=right arrow; 2 is null
    % The fifth column is ladder number (1-2);
    % The sixth column is the value currently in "LadderX", corresponding to SSD
    % The seventh column is subject response (no response is 0);
    % The eighth column is ladder movement (-1 for down, +1 for up, 0 for N/A)
    % The ninth column is their reaction time (sec)
    % The tenth column is their actual SSD (for error-check)
    % The 11th column is their actual SSD plus time taken to run the command
    % The 12th column is absolute time since beginning of task that trial begins
    % The 13th column is the time elapsed since the beginning of the block at moment when arrows are shown
    % The 14th column is the actual SSD for error check (time from arrow displayed to beep played)
    % The 15th column is the duration of the trial from trialcode
    % The 16th column is the time_course from trialcode
    
    
    %this puts trialcode into Seeker
    % trialcode was generated in opt_stop and is balanced for 4 staircase types every 16 trials, and arrow direction
    %  see opt_stop.m in /gng/optmize/stopping/
    % because of interdigitated null and true trial, there will thus be four staircases per 32 trials in trialcode
    
    trialcode(trialcode(:,1)<2,2) = trialcode(trialcode(:,1)<2,2)+postjitter;
    
    for  tc=1:256,                         %go/nogo        arrow dir       staircase    initial staircase value                    duration       timecourse
        trialcode(tc,3)=sum(trialcode(1:tc-1,2));
        if trialcode(tc,5)>0,
            Seeker(tc,:) = [tc sub_session  trialcode(tc,1) trialcode(tc,4) trialcode(tc,5) Ladder(trialcode(tc,5)) 0 0 0 0 0 0 0 0 trialcode(tc,2) trialcode(tc,3)];
        else,
            Seeker(tc,:) = [tc sub_session trialcode(tc,1) trialcode(tc,4) trialcode(tc,5) 0 0 0 0 0 0 0 0 0 trialcode(tc,2) trialcode(tc,3)];
        end;
    end;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%% TRIAL PREP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % FUNCTION CREATED BY LEK 12/20/14
    displayPrepScreens(sub_session,w,MRI,xcenter,ycenter);
    
    if MRI==1,
        secs=KbTriggerWait(trigger,inputDevice);
        %secs = KbTriggerWait(KbName('t'),controlDevice);
    else, % If using the keyboard, allow any key as input
        noresp=1;
        while noresp,
            [keyIsDown,secs,keyCode] = KbCheck(inputDevice);
            if keyIsDown & noresp,
                noresp=0;
            end;
        end;
        WaitSecs(0.001);
    end;
    % WaitSecs(0.5);  % prevent key spillover--ONLY FOR BEHAV VERSION
    
    if MRI==1
        DisableKeysForKbCheck(trigger); % So trigger is no longer detected
    end
    
    %%%%%%%%%%%%%%%%%%%%%% TRIAL PRESENTATION %%%%%%%%%%%%%%%%%%%%%%
    
    anchor=GetSecs;
    Pos=1;
    
    for block=1:2, %2	  %because of way it's designed, there are two blocks for every scan
        for a=1:8, %8     %  now we have 8 chunks of 8 trials (but we use 16 because of the null interspersed trials)
            for b=1:16,   %  (but we use 16 because of the null interspersed trials)
                %%%%%%%% FUNCTION CREATED BY LEK 12/23/14 %%%%%%%%
                [Pos Seeker FLAG_FASTER] = presentTrial_Scanning(Pos,Seeker,FLAG_FASTER,colorFlags,MRI,block,a,b,postjitter,imagetex,w,standardImHeight,standardImArea,oval2imRatio,ArrowSize,ArrowPosX,ArrowPosY,arrow_duration,anchor,inputDevice,pahandle,wave,fid);
            end; % end of trial loop
            
            % after each 8 trials, this code does the updating of staircases
            % These three loops update each of the ladders
            %%%%%%%% FUNCTION CREATED BY LEK 12/23/14 %%%%%%%%
            [Seeker,Ladder,Ladder1,Ladder2] = ladderAdjustment(Pos,Seeker,Ladder,Ladder1,Ladder2,Step);
            
        end; %end of miniblock
    end; %end block loop
    
    % Close the audio device:
    PsychPortAudio('Close', pahandle);
    
catch,    % (goes with try, line 61)
    rethrow(lasterror);
    Screen('CloseAll');
    ShowCursor;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAVE DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d=clock;
outfile=sprintf('sub%d_run%d_scan%d_%s_%02.0f-%02.0f.mat',subject_code,cumulativeSessNum,sub_session,date,d(4),d(5));
Snd('Close');

try,
    save(outfile, 'Seeker', 'Ladder1', 'Ladder2', 'subject_code', 'sub_session');
catch,
    fprintf('couldn''t save %s\n saving to stopsig_fmri.mat\n',outfile);
    save stopsig_fmri;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
WaitSecs(3);
Screen('TextSize',w,36);
Screen('TextFont',w,'Ariel');
Screen('DrawText',w,'Great Job. Thank you!',xcenter-200,ycenter);
Screen('Flip',w);
WaitSecs(1);
Screen('Flip',w);
Screen('CloseAll');
ShowCursor;