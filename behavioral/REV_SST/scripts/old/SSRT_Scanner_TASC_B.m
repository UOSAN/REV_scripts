%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Stopfmri %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Adam Aron 12-01-2005
%%% Adapted for OSX Psychtoolbox by Jessica Cohen 12/2005
%%% Modified for use with new BMC trigger-same device as button box by JC 1/07
%%% Sound updated and modified for Jess' dissertation by JC 10/08

cd('~/Desktop/TASC/SSTpeerCue/output')
clear all;
% output version
script_name='Stopfmri: optimized SSD tracker for fMRI';
script_version='1';
revision_date='10-19-08';

notes={'Design developed by Aron, Newman and Poldrack, based on Aron et al. 2003'};
standardImHeight = 200;
oval2imRatio=2;

% read in subject initials
fprintf('%s %s (revised %s)\n',script_name,script_version, revision_date);
subject_code=input('Enter subject number (integer only): ');
sub_session=input('Is this the subject''s first or second scan? (Enter 1 or 2): ');
%scannum_temp=input('Enter scan number: ');
%scannum_temp=sub_session;
%scannum=scannum_temp;
MRI=input('Are you scanning? 1 if yes, 0 if no: ');
% stListFile=input('What is the stim list filename?');
% stListFile=input('What is the jitter list filename?');
stListFile='stimFile_B.txt';
jitterListFile='jitter.txt';


%read in tab delimited file set up like MacStim (textread will read in as
%col vectors)
% [type,num,pre,maxTime,totTime,rep,stpEvt,bg,st,bgFile,stFile,hshift,vshift,tag]= textread(tdfile, '%c %d %f %f %f %d %s %c %c %s %s %d %d %s','delimiter', '\t', 'whitespace', '', 'commentstyle', 'matlab' );
[stFile] = textread(stListFile, '%s','delimiter', '\t', 'whitespace', '', 'commentstyle', 'matlab' );
[postjitter] = textread(jitterListFile, '%n','delimiter', '\t', 'whitespace', '', 'commentstyle', 'matlab' );
indices = [1:length(stFile)];
rng('default')
rng('shuffle')
addEightySeven = randi(41,[87,1]);
indices = indices' %indices is a horizontal matrix but it needs to be vertical for vertcat to work -KG 8/30/14
indices = vertcat(addEightySeven,indices);
rng('shuffle')
shuffInd = Shuffle(indices)

dlmwrite(['stimOrderLog_sub' num2str(subject_code) '_run' num2str(sub_session) '.txt'],shuffInd,'delimiter','\t');
dlmwrite(['addEightySevenLog_sub' num2str(subject_code) '_run' num2str(sub_session) '.txt'],addEightySeven,'delimiter','\t');

stFile=stFile(shuffInd);

if sub_session==1,
    LADDER1IN=250 %input('Ladder1 start val (e.g. 250): ');
    LADDER2IN=350 %input('Ladder2 start val (e.g. 350): ');
    %Ladder Starts (in ms):
    Ladder1=LADDER1IN;
    Ladder(1,1)=LADDER1IN;
    Ladder2=LADDER2IN;
    Ladder(2,1)=LADDER2IN;
elseif sub_session==2, %% this code looks up the last value in each staircase
    trackfile=input('Enter name of subject''s previous ''mat'' file to open: ','s');
    load(trackfile);
    clear Seeker; %gets rid of this so it won't interfere with current Seeker
    sub_session=2;
    scannum=sub_session;
    startval=length(Ladder1);
    Ladder(1,1)=Ladder1(startval);
    Ladder(2,1)=Ladder2(startval);
    % elseif scannum>1, %% this code looks up the last value in each staircase
    %     trackfile=input('Enter name of prior #stop_fmri1 to open: ','s');
    %     load(trackfile);
    %     clear Seeker; %gets rid of this so it won't interfere with current Seeker
    %     scannum=scannum_temp; %because first file has scannum saved as 1, overwrite that for inputted scan number
    %     startval=length(Ladder1);
    % 	Ladder(1,1)=Ladder1(startval);
    % 	Ladder(2,1)=Ladder2(startval);
end;


%load relevant input file for scan (there MUST be st1b1.mat & st1b2.mat)
inputfile=sprintf('st%db%d.mat',subject_code,sub_session);
load(inputfile); %variable is trialcode

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
    
    %% set up input devices
    numDevices=PsychHID('NumDevices');
    devices=PsychHID('Devices');
    if MRI==1,
        for n=1:numDevices,
            if (findstr(devices(n).transport,'USB') & findstr(devices(n).usageName,'Keyboard') & (devices(n).productID==612 | devices(n).vendorID==1523 | devices(n).totalElements==244)),
                inputDevice=n;
                %else,
                %    inputDevice=6; % my keyboard
            end;
            if (findstr(devices(n).transport,'USB') & findstr(devices(n).usageName,'Keyboard') & (devices(n).productID==566 | devices(n).vendorID==1452)),
                controlDevice=n;
            end
        end;
        fprintf('Using Device #%d (%s)\n',inputDevice,devices(inputDevice).product);
    else,
        for n=1:numDevices,
            if (findstr(devices(n).transport,'USB') & findstr(devices(n).usageName,'Keyboard')),
                inputDevice=[n n];
                break,
            elseif (findstr(devices(n).transport,'Bluetooth') & findstr(devices(n).usageName,'Keyboard')),
                inputDevice=[n n];
                break,
            elseif findstr(devices(n).transport,'ADB') & findstr(devices(n).usageName,'Keyboard'),
                inputDevice=[n n];
            end;
        end;
        fprintf('Using Device #%d (%s)\n',inputDevice,devices(n).product);
    end;
    
    % set up screens
    Screen('Preference','SkipSyncTests',1);
    fprintf('setting up screen\n');
    screens=Screen('Screens');
    screenNumber=max(screens);
    w=Screen('OpenWindow', screenNumber,0,[],32,2);
    [wWidth, wHeight]=Screen('WindowSize', w);
    grayLevel=120;
    Screen('FillRect', w, grayLevel);
    Screen('Flip', w);
    
    black=BlackIndex(w); % Should equal 0.
    white=WhiteIndex(w); % Should equal 255.
    
    xcenter=wWidth/2;
    ycenter=wHeight/2;
    
    theFont='Arial';
    Screen('TextSize',w,36);
    Screen('TextFont',w,theFont);
    Screen('TextColor',w,white);
    
    CircleSize=150;
    %     CirclePosX=xcenter-92;
    %     CirclePosY=ycenter-250;
    ArrowSize=150;
    ArrowPosX=xcenter-48;
    ArrowPosY=ycenter-86;
    CirclePosX=xcenter-CircleSize/2;
    CirclePosY=ycenter-CircleSize/2;
    
    
    HideCursor;
    
    %Preload stim
    imagetex = zeros(1,length(stFile)); %initialize imagetex for pics
    for i=1:128 %tc=256 and is all events, not just trials
        stFile{i}
        img = imread(stFile{i});
        itex = Screen('MakeTexture', w, img);
        imagetex(i) = itex;
    end
    
    
    %Adaptable Constants
    % "chunks", will always be size 64:
    NUMCHUNKS=4;  %gngscan has 4 blocks of 64 (2 scans with 2 blocks of 64 each--but says 128 b/c of interspersed null events)
    %StepSize = 50 ms;
    Step=50;
    %Interstimulus interval (trial time-.OCI) = 2.5s
    ISI=1.5; %set at 1.5
    %BlankScreen Interval is 1.0s
    BSI=1 ;  %NB, see figure in GNG4manual (set at 1 for scan)
    %Only Circle Interval is 0.5s
    %     OCI=0.5 + postjitter(trialnum);
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
    %%%% Psychportaudio
    load soundfile.mat %%% NEED SOMETHING PERSONALIZED TO ME????? I.E. IF WANT THE SOUND HIGHER??
    %wave=y;
    wave=sin(1:0.25:1000);
    %freq=Fy*1.5; % change this to change freq of tone
    freq=22254;
    nrchannels = size(wave,1);
    % Default to auto-selected default output device:
    deviceid = -1;
    % Request latency mode 2, which used to be the best one in our measurement:
    reqlatencyclass = 2; % class 2 empirically the best, 3 & 4 == 2
    % Initialize driver, request low-latency preinit:
    InitializePsychSound(1);
    % Open audio device for low-latency output:
    pahandle = PsychPortAudio('Open', deviceid, [], reqlatencyclass, freq, nrchannels);
    %Play the sound
    PsychPortAudio('FillBuffer', pahandle, wave);
    PsychPortAudio('Start', pahandle, 1, 0, 0);
    WaitSecs(1);
    PsychPortAudio('Stop', pahandle);
    %%%% Old way
    %     Snd('Open');
    %     samp = 22254.545454;
    %     aud_stim = sin(1:0.25:1000);
    %     Snd('Play',aud_stim,samp);
    
    
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
    
    for  tc=1:256,                         %go/nogo        arrow dir       staircase    initial staircase value                    duration       timecourse
        if trialcode(tc,5)>0,
            Seeker(tc,:) = [tc sub_session  trialcode(tc,1) trialcode(tc,4) trialcode(tc,5) Ladder(trialcode(tc,5)) 0 0 0 0 0 0 0 0 trialcode(tc,2) trialcode(tc,3)];
        else,
            Seeker(tc,:) = [tc sub_session trialcode(tc,1) trialcode(tc,4) trialcode(tc,5) 0 0 0 0 0 0 0 0 0 trialcode(tc,2) trialcode(tc,3)];
        end;
    end;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%% TRIAL PRESENTATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    startstring = sprintf('Get ready for scan number %d!',sub_session);
    Screen('DrawText',w,startstring,100,100);
    if MRI==1,
        Screen('DrawText',w,'Waiting for trigger...',xcenter-150,ycenter);
        Screen('Flip',w);
    else,
        Screen('DrawText',w,'Press the left button if you see <',100,175);
        Screen('DrawText',w,'Press the right button if you see >',100,225);
        Screen('DrawText',w,'Press the button as FAST as you can',100,300);
        Screen('DrawText',w,'when you see the arrow.',100,350);
        Screen('DrawText',w,'But if you hear a beep, try very hard',100,425);
        Screen('DrawText',w,'to STOP yourself from pressing the button.',100,475);
        Screen('DrawText',w,'Stopping and Going are equally important.',100,550);
        Screen('DrawText',w,'Press any key to go on.',100,625);
        Screen('Flip',w);
    end;
    
    Screen('DrawText',w,'Press the left button (LEFT index finger) if you see <',100,100); %from Lauren's practice task
    Screen('DrawText',w,'Press the right button (RIGHT index finger) if you see >',100,130); %from Lauren'spractice task
    Screen('DrawText',w,'Press the button as QUICKLY and as ACCURATELY',100,180); %all from Lauren's practice task
    Screen('DrawText',w,'as you can when you see the arrow.',100,210);
    Screen('DrawText',w,'But if you hear a beep, try very hard to STOP',100,240);
    Screen('DrawText',w,'yourself from pressing the button on that arrow only.',100,270);
    Screen('DrawText',w,'GOING and STOPPING are equally important.',100,300);
    Screen('DrawText',w,'So DO NOT slow down your response to wait for the beep,',100,330);
    Screen('DrawText',w,'because then you are no longer going when you are supposed to.',100,360);
    Screen('DrawText',w,'You won''t always be able to stop when you hear a beep,',100,390);
    Screen('DrawText',w,'but as long as you go quickly all of the time',100,420);
    Screen('DrawText',w,'(while pushing the correct button for arrow direction),',100,450);
    Screen('DrawText',w,'and can stop some of the time, you are doing the task correctly.',100,480);
    Screen('DrawText',w,'Ask the experimenter if you have any questions.',100,530);
    Screen('DrawText',w,'Press any key to go on.',100,560);
    Screen('Flip',w);
    
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
    
    anchor=GetSecs;
    Pos=1;
    
    for block=1:2, %2	  %because of way it's designed, there are two blocks for every scan
        
        for a=1:8, %8     %  now we have 8 chunks of 8 trials (but we use 16 because of the null interspersed trials)
            %for a=1:1,  % short for troubleshooting
            for b=1:16,   %  (but we use 16 because of the null interspersed trials)
                tc=(block-1)*8*16+(a-1)*16+b;
                trialnum=floor((tc+1)/2);
                OCI=0.5 + postjitter(trialnum);
                if Seeker(Pos,3)~=2, %% ie this is not a NULL event
                    % This was for the CIRCLE CUE.
                    %                     Screen('TextSize',w,CircleSize);
                    %                     Screen('TextFont',w,'Courier');
                    %                     Screen('DrawText',w,'o', CirclePosX, CirclePosY);
                    %                     Screen('TextSize',w,ArrowSize);
                    %                     Screen('TextFont',w,'Arial');
                    %                     PICTURE CUE INSTEAD!
                    
                    %                     imrect = CenterRect(Screen('Rect', imagetex(trialnum)),Screen('Rect',w))
%                     imrect = CenterRect(Screen('Rect', imagetex(trialnum))/2,Screen('Rect',w))
                    imDims = Screen('Rect', imagetex(trialnum));
                    imHeight=imDims(4)-imDims(2);
                    imDims = imDims/imHeight*standardImHeight;
                    imrect = CenterRect(imDims,Screen('Rect',w));
                    Screen('DrawTexture',w,imagetex(trialnum),[],imrect);
                    Screen('FrameOval',w,[120 120 120],CenterRect(imDims*oval2imRatio,Screen('Rect',w)),100);
                    
                    while GetSecs - anchor < Seeker(Pos,16),
                    end; %waits to synch beginning of trial with 'true' start
                    
                    Screen('Flip',w);
                    trial_start_time = GetSecs;
                    Seeker(Pos,12)=trial_start_time-anchor; %absolute time since beginning of task
                    WaitSecs(OCI);
                end;
                
                if Seeker(Pos,3)~=2, %% ie this is not a NULL event
                    Screen('DrawTexture',w,imagetex(trialnum),[],imrect);
                    Screen('FrameOval',w,[120 120 120],CenterRect(imDims*oval2imRatio,Screen('Rect',w)),100);
%                     Screen('FillOval',w,120,[CirclePosX CirclePosY CirclePosX+CircleSize CirclePosY+CircleSize])
                    Screen('TextSize',w,ArrowSize);
                    Screen('TextFont',w,'Arial');
                    if (Seeker(Pos,4)==0),
                        Screen('DrawText',w,'<', ArrowPosX, ArrowPosY);
                    else,
                        Screen('DrawText',w,'>', ArrowPosX+10, ArrowPosY);
                    end;
                    noresp=1;
                    notone=1;
                    Screen('Flip',w);
                    arrow_start_time = GetSecs;
                    
                    
                    while (GetSecs-arrow_start_time < arrow_duration & noresp),
                        [keyIsDown,secs,keyCode] = KbCheck(inputDevice);
                        if MRI==1,
                            if keyIsDown & noresp,
                                tmp=KbName(keyCode);
                                Seeker(Pos,7)=KbName(tmp(1));
                                Seeker(Pos,9)=GetSecs-arrow_start_time;
                                noresp=0;
                            end;
                        else,
                            if keyIsDown & noresp,
                                try,
                                    tmp=KbName(keyCode);
                                    if length(tmp) > 1 & (tmp(1)==',' | tmp(1)=='.'),
                                        Seeker(Pos,7)=KbName(tmp(2));
                                    else,
                                        Seeker(Pos,7)=KbName(tmp(1));
                                    end;
                                catch,
                                    Seeker(Pos,7)=9999;
                                end;
                                if b==1 & GetSecs-arrow_start_time<0,
                                    Seeker(Pos,9)=0;
                                    Seeker(Pos,13)=0;
                                else,
                                    Seeker(Pos,9)=GetSecs-arrow_start_time; % RT
                                end;
                                noresp=0;
                            end;
                        end;
                        WaitSecs(0.001);
                        if Seeker(Pos,3)==1 & GetSecs - arrow_start_time >=Seeker(Pos,6)/1000 & notone,
                            %% Psychportaudio
                            PsychPortAudio('FillBuffer', pahandle, wave);
                            PsychPortAudio('Start', pahandle, 1, 0, 0);
                            Seeker(Pos,14)=GetSecs-arrow_start_time;
                            notone=0;
                            %WaitSecs(1); % So sound plays for set amount of time; if .05, plays twice, otherwise doen't really make it last longer
                            %PsychPortAudio('Stop', pahandle);
                            % Try loop to end sound after 1 sec, while
                            % still looking for responses-DOESN"T WORK!!!!!
                            while GetSecs<Seeker(Pos,14)+1,
                                %%% check for escape key %%%
                                [keyIsDown,secs,keyCode] = KbCheck(inputDevice);
                                escapekey = KbName('escape');
                                if keyIsDown & noresp,
                                    try,
                                        tmp=KbName(keyCode);
                                        if length(tmp) > 1 & (tmp(1)==',' | tmp(1)=='.'),
                                            Seeker(Pos,7)=KbName(tmp(2));
                                        else,
                                            Seeker(Pos,7)=KbName(tmp(1));
                                        end;
                                    catch,
                                        Seeker(Pos,7)=9999;
                                    end;
                                    if b==1 & GetSecs-arrow_start_time<0,
                                        Seeker(Pos,9)=0;
                                        Seeker(Pos,13)=0;
                                    else,
                                        Seeker(Pos,9)=GetSecs-arrow_start_time; % RT
                                    end;
                                    noresp=0;
                                end;
                            end;
                            %PsychPortAudio('Stop', pahandle);
                            %% Old way to play sound
                            %Snd('Play',aud_stim,samp);
                            %Seeker(Pos,14)=GetSecs-arrow_start_time;
                            %notone=0;
                        end;
                        % To try to get stopping sound outside of sound
                        % loop so can collect responses as well; if do
                        % this, it doesn't play
                        %                         if GetSecs-Seeker(Pos,14)>=1,
                        %                             % Stop playback:
                        %                             PsychPortAudio('Stop', pahandle);
                        %                         end;
                    end; %end while
                    PsychPortAudio('Stop', pahandle); % If do this,
                    % response doesn't end loop
                end; %end non null
                
                Screen('Flip',w);
                
                while(GetSecs - anchor < Seeker(Pos,16) + Seeker(Pos,15)),
                end;
                
                
                % print trial info to log file
                tmpTime=GetSecs;
                try,
                    fprintf(fid,'%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%0.3f\t%0.3f\t%0.3f\t%0.3f\t%0.3f\t%0.3f\t%0.3f\t%0.3f\n',...
                        Seeker(Pos,1:16));
                catch,   % if sub responds weirdly, trying to print the resp crashes the log file...instead print "ERR"
                    fprintf(fid,'ERROR SAVING THIS TRIAL\n');
                end;
                
                
                Pos=Pos+1;
                
            end; % end of trial loop
            
            % after each 8 trials, this code does the updating of staircases
            %These three loops update each of the ladders
            for c=(Pos-16):Pos-1,
                %This runs from one to two, one for each of the ladders
                for d=1:2,
                    if (Seeker(c,7)~=0&Seeker(c,5)==d),	%col 7 is sub response
                        if Ladder(d,1)>=Step,
                            Ladder(d,1)=Ladder(d,1)-Step;
                            Ladder(d,2)=-1;
                        elseif Ladder(d,1)>0 & Ladder(d,1)<Step,
                            Ladder(d,1)=0;
                            Ladder(d,2)=-1;
                        else,
                            Ladder(d,1)=Ladder(d,1);
                            Ladder(d,2)=0;
                        end;
                        if (d==1),
                            [x y]=size(Ladder1);
                            Ladder1(x+1,1)=Ladder(d,1);
                        else if (d==2),
                                [x y]=size(Ladder2);
                                Ladder2(x+1,1)=Ladder(d,1);
                            end;end;
                    else if (Seeker(c,5)==d & Seeker(c,7)==0),
                            Ladder(d,1)=Ladder(d,1)+Step;
                            Ladder(d,2)=1;
                            if (d==1),
                                [x y]=size(Ladder1);
                                Ladder1(x+1,1)=Ladder(d,1);
                            else if (d==2),
                                    [x y]=size(Ladder2);
                                    Ladder2(x+1,1)=Ladder(d,1);
                                end;end;
                        end;end;
                end;
            end;
            %Updates the time in each of the subsequent stop trials
            for c=Pos:256,
                if (Seeker(c,5)~=0), %i.e. staircase trial
                    Seeker(c,6)=Ladder(Seeker(c,5),1);
                end;
            end;
            %Updates each of the old trials with a +1 or a -1
            for c=(Pos-16):Pos-1,
                if (Seeker(c,5)~=0),
                    Seeker(c,8)=Ladder(Seeker(c,5),2);
                end;
            end;
            
        end; %end of miniblock
        
    end; %end block loop
    
    
    % Close the audio device:
    PsychPortAudio('Close', pahandle);
    
    
    %try,   %dummy try if need to troubleshoot
    
catch,    % (goes with try, line 61)
    rethrow(lasterror);
    
    Screen('CloseAll');
    ShowCursor;
    
end;


%%%%%%%%%%%%%%% FEEDBACK %%%%%%%%%%%%%%%%
for t=1:256
    % go trial   &  left arrow                 respond right   OR  right arrow       respond left
    if (Seeker(t,3)==0 & ((Seeker(t,4)==0 & sum(Seeker(t,7)==RIGHT)==1)|(Seeker(t,4)==1 & sum(Seeker(t,7)==LEFT)==1))),
        error(sub_session)=error(sub_session)+1;  % for incorrect responses
    end;
    % go trial   &   RT (so respond)  & left arrow            respond left    OR  right arrow       respond right
    if (Seeker(t,3)==0 & Seeker(t,9)>0 & ((Seeker(t,4)==0 & sum(Seeker(t,7)==LEFT)==1)|(Seeker(t,4)==1 & sum(Seeker(t,7)==RIGHT)==1))),
        rt(sub_session)=rt(sub_session)+Seeker(t,9);   % cumulative RT
        count_rt(sub_session)=count_rt(sub_session)+1; %number trials
    end;
end;

Screen('TextSize',w,36);
Screen('TextFont',w,'Ariel');

if sub_session==1;
    Screen('DrawText',w,sprintf('Scanning Block %d',1),100,100);
    Screen('DrawText',w,sprintf('Mistakes with arrow direction on Go trials: %d', error(1)),100,140);
    Screen('DrawText',w,sprintf('Correct average RT on Go trials: %.1f (ms)', rt(1)/count_rt(1)*1000),100,180);
    %     if MRI~=1,
    %         Screen('DrawText',w,'Press any button to continue',100,220);
    %     end;
    Screen('Flip',w);
end;


if sub_session==2,
    Screen('DrawText',w,sprintf('Scanning Block %d',1),100,100);
    Screen('DrawText',w,sprintf('Mistakes with arrow direction on Go trials: %d', error(1)),100,140);
    Screen('DrawText',w,sprintf('Correct average RT on Go trials: %.1f (ms)', rt(1)/count_rt(1)*1000),100,180);
    
    Screen('DrawText',w,sprintf('Scanning Block %d',2),100,240);
    Screen('DrawText',w,sprintf('Mistakes with arrow direction on Go trials: %d', error(2)),100,280);
    Screen('DrawText',w,sprintf('Correct average RT on Go trials: %.1f (ms)', rt(2)/count_rt(2)*1000),100,320);
    
    %     if MRI~=1,
    %         Screen('DrawText',w,'Press any button to continue',100,360);
    %     end;
    Screen('Flip',w);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAVE DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d=clock;
outfile=sprintf('%dstop_fmri%d_%s_%02.0f-%02.0f.mat',subject_code,sub_session,date,d(4),d(5));
Snd('Close');

params = cell (7,2);
params{1,1}='NUMCHUNKS';
params{1,2}=NUMCHUNKS;
params{2,1}='Ladder1 start';
params{2,2}=Ladder1(1,1);
params{3,1}='Ladder2 start';
params{3,2}=Ladder2(1,1);
params{4,1}='Step';
params{4,2}=Step;
params{5,1}='ISI';
params{5,2}=ISI;
params{6,1}='BSI';
params{6,2}=BSI;
params{7,1}='OCI';
params{7,2}=OCI;

%%% It's better to access these variables via parameters, rather than
%%% saving them...
try,
    save(outfile, 'Seeker', 'params', 'Ladder1', 'Ladder2', 'error', 'rt', 'count_rt', 'subject_code', 'sub_session');
catch,
    fprintf('couldn''t save %s\n saving to stopsig_fmri.mat\n',outfile);
    save stopsig_fmri;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% if MRI==1,
%     WaitSecs(5);
% else,
%     noresp=1;
%     while noresp,
%         [keyIsDown,secs,keyCode] = KbCheck(inputDevice);
%         if keyIsDown & noresp,
%             noresp=0;
%         end;
%         WaitSecs(0.001);
%     end;
%     WaitSecs(0.5);
% end;

WaitSecs(5);

Screen('TextSize',w,36);
Screen('TextFont',w,'Ariel');
Screen('DrawText',w,'Great Job. Thank you!',xcenter-200,ycenter);
Screen('Flip',w);

% if MRI==1,
%     WaitSecs(1);
% else,
%     noresp=1;
%     while noresp,
%         [keyIsDown,secs,keyCode] = KbCheck(inputDevice);
%         if keyIsDown & noresp,
%             noresp=0;
%         end;
%         WaitSecs(0.001);
%     end;
%     WaitSecs(0.5);
% end;

WaitSecs(1);
Screen('Flip',w);
Screen('CloseAll');
ShowCursor;

