%%%This version of BART takes one 't' as the trigger from the scanner to%%%start.  Also, you can leave the trigger on because after the task has%%%started, the task will only be sensitive to 'b' and 'y'.  This version%%%of the task uses Roger Woods' KbQueue functions.  %%% Modified by Veena Narayan%% setting up stuff (standard to all programs)clear all;Screen('Preference', 'SkipSyncTests', 1);Screen('Preference', 'VisualDebugLevel', 0);script_name='BART';script_version='7';revision_date='011-07-07';% SET TO ZERO TO TAKE KEYPRESSES!timetest=0;% seed randomnessrand('state',sum(100*clock));fprintf('%s %s (revised %s)\n',script_name,script_version, ...        revision_date);subject_initials=input('Enter subject code: ','s');run_number=input('Enter run number: ');cumulative_ctr=input('Enter starting total (0 for first run): ');MRI=input('Are you scanning? 1 if yes, 0 if no: ');pixelSize =32;[w, screenRect] = Screen('OpenWindow',0,[],[],pixelSize);grayLevel=120;Screen('FillRect', w, grayLevel);Screen('Flip', w);HideCursor;black=BlackIndex(w); % Should equal 0.white=WhiteIndex(w); % Should equal 255.% set up screen positions for stimulixcenter=screenRect(3)/2; ycenter=screenRect(4)/2;textsize=50;Screen('TextSize',w,textsize);stim_images=cell(1,3);% load the balloonfor x=1:3,	balloon_img{x}=imread(sprintf('balloon%d.jpg',x),'jpeg');end;% load the balloonfor x=1:3,	exploded_img{x}=imread(sprintf('balloon%d_exploded.jpg',x),'jpeg');end;% setup values for reward/punishment%starting_value=0.00;max_scan_length=510;% set up windows for balloonnsizes=16;  % 10 possible balloon sizesbase_window_size=[150 150];scale_factor=0.15; %changed from 0.10 - seeems to be ok and makes for a bigger balloonfor x=1:nsizes,	tmp=base_window_size + base_window_size*(x-1)*scale_factor;	imgwindow{x}=round([[xcenter ycenter] - tmp/2 [xcenter ycenter] + tmp/2 ]);end;%%% start defining your trialFlushEvents('keyDown');%cumulative_ctr=0;% set up the designnconds=3;  % changed for this version - 1 color ballon + 1 controlcontrol_cond=3;explode_trial_dist=[12 12 12];  % max # of trials before explosion (twice mean exploding time)payoff_level=[5 5 0];explode_trial_num=[16 16 16];  % includes control trials for behavioral pilotingntrials=sum(explode_trial_num);rt=zeros(ntrials,nsizes,3);resp=cell(ntrials,nsizes);total_pres_time=zeros(1,ntrials);ctr=1;for c=1:nconds,	for t=1:explode_trial_num(c),		trial_info(ctr).explode_trial=ceil(rand*explode_trial_dist(c));		trial_info(ctr).payoff_level=payoff_level(c);		trial_info(ctr).balloon=c;		trial_info(ctr).rt=[];		trial_info(ctr).resp={};		trial_info(ctr).explode_time=[];		trial_info(ctr).finish_time=[];		trial_info(ctr).exploded=0;		trial_info(ctr).trial_total=[];		trial_info(ctr).cumulative_total=[];		trial_info(ctr).finished=0;		ctr=ctr+1;	end;end;% randomize listrandidx=randperm(ntrials);trial_info=trial_info(randidx);if MRI==1    accept_resp=KbName('3#'); %blue    reject_resp=KbName('6^'); %yellowelse    accept_resp=KbName('b'); %blue    reject_resp=KbName('y'); %yellow end;ISI=3;ITI=2;min_iti=1;max_iti=12;mean_iti=4;isi_window=2;accept_wait=2;%break_trials=[30 60 90];balloon_num=ones(1,ntrials);FlushEvents('keyDown');	 % clear any keypresses out of the buffer% how screen() works:% first argument: which screen to use (in this case, w, which is the main screen)% second argument: what to do (in this case, 'DrawText')% subsequent arguments depend upon what you've chosen to doScreen('Preference', 'SkipSyncTests', 1);exp_screen=max(Screen('Screens')); %get screen numbers of which max is used for the initial OpenWindow command.   w = Screen('OpenWindow',exp_screen); %opens the screen- I used only a single buffer cause I don't know why two buffers helps    Screen('TextSize', w, 30); %Set textsize    Screen('TextFont',w, 'Arial'); %Set text font    Screen('TextColor',w,0); %Set text color    Screen('FillRect',w,120); %sets background color to black    Screen('DrawText', w, 'Press the  button under your LEFT index finger to inflate the balloon.', 50, 50);    Screen('DrawText', w, 'Press the button under your RIGHT index finger to stop inflating', 50, 100);     Screen('DrawText', w, 'and move onto the next balloon.', 50, 150);    Screen('DrawText', w, 'If the balloon explodes, you will get no points.', 50, 200);    Screen('DrawText', w, 'Green balloons give points, but white do not.', 50, 250);    Screen('DrawText', w, 'When you see a white balloon, inflate it until it goes away to move on.', 50, 300);    Screen('DrawText', w, 'Try to get as many points as you can!', 50, 400);    Screen ('Flip', w);%Setting up devices% If in scanner, FORP is one of the devices, otherwise FORP_ID is set to% -1, so we can run the task with just the keboard    %inputDevice=-1;	%vendorIDs = [1240 6171]; original vendor IDs - don't work at LCNI    vendorIDs = [1523]; %correct vendor ID for Xkey at LCNI    %vendorIDs = [1452]; %for troubleshooting on Kate's macbookpro or training macbook pro	devices = PsychHID('Devices');    numDevices=PsychHID('NumDevices');	%Loop through all KEYBOARD devices with the vendorID of FORP's vendor if in the scanner:	if MRI==1,        for n=1:numDevices,            if (findstr(devices(n).transport,'USB') & findstr(devices(n).usageName,'Keyboard') & (devices(n).productID==612 | devices(n).vendorID==1523 | devices(n).totalElements==244)),                inputDevice=n;            end;            if (findstr(devices(n).transport,'USB') & findstr(devices(n).usageName,'Keyboard') & (devices(n).productID==566 | devices(n).vendorID==1452)),                controlDevice=n;            end        end;        fprintf('Using Device #%d (%s)\n',inputDevice,devices(inputDevice).product);    else,        for n=1:numDevices,            if (findstr(devices(n).transport,'USB') & findstr(devices(n).usageName,'Keyboard')),                inputDevice=[n n];                break,            elseif (findstr(devices(n).transport,'Bluetooth') & findstr(devices(n).usageName,'Keyboard')),                inputDevice=[n n];                break,            elseif findstr(devices(n).transport,'ADB') & findstr(devices(n).usageName,'Keyboard'),                inputDevice=[n n];            end;        end;        fprintf('Using Device #%d (%s)\n',inputDevice,devices(n).product);    end;    %original input device search code        %if MRI==1,    % for i=1:size(Devices,2)%		if strcmp(Devices(i).usageName,'Keyboard') && ismember(Devices(i).vendorID,vendorIDs);%			inputDevice=i;%            break;%        end;%     end;%	%        if inputDevice==-1;%		error('No FORP-Device detected on your system');%        end;%    end;        % write trial-by-trial data to a text logfiled=clock;logfile=sprintf('sub%s_scan%s_bart.log',subject_initials,run_number);fprintf('A log of this session will be saved to %s\n',logfile);fid=fopen(logfile,'a');if fid<1,    error('could not open logfile!');end;fprintf(fid,'Started: %s %2.0f:%02.0f\n',date,d(4),d(5));% WaitSecs(12);   % if MRI==1,   %     trigger=([52]);   %     experiment_start_time=KbTriggerWait(trigger,inputDevice);   %     DisableKeysForKbCheck(trigger); % So trigger is no longer detected   % else,   %     KbWait(homeDevice);  % wait for keypress   %     experiment_start_time=GetSecs;   %     noresp=1;    %while noresp,    %    [keyIsDown,secs,keyCode] = KbCheck(inputDevice);    %        if keyIsDown & noresp,    %            noresp=0;    %        end;    %    end;   % WaitSecs(0.001);   % end;%WaitSecs(0.5);  % prevent key spillover%anchor=GetSecs;    %%%%%%%%%%%%%%%%%%%%%%    if MRI==1        KbTriggerWait(52,inputDevice);        olddisabledkeys=DisableKeysForKbCheck(KbName(52));%        % keysOfInterest=zeros(1,256);%        %keysOfInterest(KbName('t'))=1; %trigger%        % keysOfInterest([52])=1; %trigger%        % KbQueueCreate(inputDevice, keysOfInterest);	% First queue%         %KbQueueCreate(-1, keysOfInterest);%         % Perform other initializations%         KbQueueStart;%         KbQueueWait; % Wait until the 't' key signal is sent%         %WaitSecs(4);%         KbQueueRelease;        keysOfInterest=zeros(1,256);        keysOfInterest(KbName('3#'))=1;        keysOfInterest(KbName('6^'))=1;        KbQueueCreate(inputDevice, keysOfInterest);              KbQueueStart(inputDevice);        Screen ('Flip', w);            anchor=GetSecs;            else        keysOfInterest=zeros(1,256);        keysOfInterest(KbName({'b','y'}))=1;        KbQueueCreate(inputDevice, keysOfInterest);	% New queue        KbQueueStart(inputDevice);        Screen ('Flip', w);        anchor=GetSecs;    end% present trialsfor trial=1:ntrials,    trial    trial_start_time=GetSecs;	if trial_start_time - anchor > max_scan_length,		break;	end;	still_playing=1;	trial_round=1;	trial_counter=0;    	while still_playing,		%%%%%%%FlushEvents('keyDown');        KbQueueFlush(inputDevice);        Screen('PutImage',w,balloon_img{trial_info(trial).balloon},imgwindow{trial_round});        %start_time=GetSecs;		%trial_info(trial).rt(trial_round,1)=start_time-anchor;  %collect absolute start time		        if trial_info(trial).balloon ~= control_cond, 			oldTextSize=Screen('TextSize', w, 40)            %screen('DrawText',w,sprintf('%5.f',trial_counter),xcenter-75,ycenter-40,white);                    end;        [VBLTimestamp StimulusOnsetTime FlipTimestamp Missed Beampos] =Screen('Flip',w)        trial_info(trial).rt(trial_round,1)=StimulusOnsetTime - anchor;        %Screen ('Flip', w);		no_resp=1;				while no_resp,            [ pressed, firstPress]=KbQueueCheck(inputDevice);			if pressed & no_resp,				tmp=firstPress(find(firstPress));		  		trial_info(trial).rt(trial_round,2)=tmp-StimulusOnsetTime;  %collect rt for each trial		   		trial_info(trial).rt(trial_round,3)=tmp-anchor; %actual time subject makes a key press                no_resp=0;		   		trial_info(trial).resp{trial_round}=find(firstPress); %collect response			    %trial_info(trial).resp{trial_round}= trial_info(trial).rt(trial_round,3);              end;d=clock;outfile=sprintf('%s_r%d_%s.mat',subject_initials,run_number,date);run_info.initials=subject_initials;run_info.date=date;run_info.outfile=outfile;try,      save(outfile);catch,	 fprintf('datestamped filename too long - saving as %s_ic.mat',subject_initials);     %outfile=sprintf('%s_balloon.mat',subject_initials);	 outfile=sprintf('b_%s_%02.0f-%02.0f.mat',date,d(4),d(5));     save(outfile);end;	  		end;				% determine accept/reject		if trial_info(trial).resp{trial_round}==accept_resp,            accept=1;        else,			accept=0;		end;       	if trial_info(trial).balloon==control_cond,			tmp_isi=1 + rand*isi_window;			%waitsecs(tmp_isi);            if trial_round < trial_info(trial).explode_trial   		       Screen('Flip', w)			   WaitSecs(tmp_isi);	                  elseif trial_round >= trial_info(trial).explode_trial,				still_playing=0;				tmp_isi=1 + rand*isi_window;				WaitSecs(tmp_isi);				trial_info(trial).exploded=1;                Screen('PutImage',w,balloon_img{trial_info(trial).balloon},imgwindow{trial_round})                Screen('DrawText',w,sprintf('Total:%5.f',cumulative_ctr),xcenter-150,ycenter+200,black);                [VBLTimestamp StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen('Flip',w)                trial_info(trial).explode_time=StimulusOnsetTime - anchor;				%trial_info(trial).explode_time=GetSecs-anchor;                %Screen ('Flip', w);				WaitSecs(ITI);							end;							trial_round=trial_round+1;		elseif accept==0,			% add total to cumulative counter			trial_info(trial).finish_time=GetSecs-anchor; 			cumulative_ctr=cumulative_ctr+trial_counter;			still_playing=0;            Screen('PutImage',w,balloon_img{trial_info(trial).balloon},imgwindow{trial_round});            %Screen('DrawText',w,sprintf('This Balloon: %5.f',trial_counter),xcenter-270,ycenter+150,black);            Screen('DrawText',w,sprintf('Total:%5.f',cumulative_ctr),xcenter-150,ycenter+200,black);            Screen('Flip', w)			WaitSecs(accept_wait);							trial_info(trial).trial_total=trial_counter;			trial_info(trial).cumulative_total=cumulative_ctr;            Screen('Flip', w);        elseif accept==1,			% is it an explosion trial?			if trial_round >= trial_info(trial).explode_trial,				% explode                Screen ('Flip', w);				tmp_isi=1 + rand*isi_window;				WaitSecs(tmp_isi);				trial_info(trial).exploded=1;                Screen('PutImage',w,exploded_img{trial_info(trial).balloon},imgwindow{trial_round});                Screen(w,'DrawText',sprintf('Total:%5.f',cumulative_ctr),xcenter-150,ycenter+200,black);                [VBLTimestamp StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen('Flip',w)                trial_info(trial).explode_time=StimulusOnsetTime - anchor;                %Screen('Flip',w);       				%trial_info(trial).explode_time=GetSecs-anchor;				still_playing=0;				WaitSecs(ITI);								trial_info(trial).trial_total=0;				trial_info(trial).cumulative_total=cumulative_ctr;                Screen('Flip',w);			else,				% don't explode                Screen('Flip',w);				tmp_isi=1 + rand*isi_window;				WaitSecs(tmp_isi);				trial_counter=trial_counter+trial_info(trial).payoff_level;				trial_round=trial_round+1;			end;		end;				% end it if we get to the largest balloon		if trial_info(trial).exploded==0 & trial_round > nsizes,			cumulative_ctr=cumulative_ctr+trial_counter;			still_playing=0;%             screen('DrawText',w,sprintf('This Balloon: %0.2f',trial_counter),xcenter-140,ycenter+150,black);            Screen('DrawText',w,sprintf('Total:%5.f',cumulative_ctr),xcenter-150,ycenter+200,black);			trial_info(trial).finish_time=GetSecs-anchor;			trial_info(trial).trial_total=trial_counter;			trial_info(trial).cumulative_total=cumulative_ctr;            Screen('Flip',w);			WaitSecs(ITI);		end;		        Screen('Flip',w);	end;	trial_info(trial).finished=1;	tmp_iti=exprnd(mean_iti);	while tmp_iti<min_iti | tmp_iti>max_iti,		tmp_iti=exprnd(mean_iti);	end;    trial_length=GetSecs-trial_start_time;	WaitSecs(tmp_iti);end;FlushEvents('keyDown');%KbQueueFlush;Screen('DrawText',w,sprintf('Thank you for playing.'),xcenter-400,ycenter+200);Screen('DrawText',w,sprintf( 'Your total was %5.f',cumulative_ctr),xcenter-400,ycenter-200);Screen('Flip',w);WaitSecs(3);Screen('Flip',w);GetChar; % wait for a keypressScreen('CloseAll');ShowCursor;% save data to a file, with date/time stampd=clock;outfile_final=sprintf('%s_r%d_%s_%02.0f-%02.0f_final.mat',subject_initials,run_number,date,d(4),d(5));run_info.initials=subject_initials;run_info.date=date;run_info.outfile=outfile_final;ShowCursortry,      save(outfile_final);catch,	 fprintf('datestamped filename too long - saving as %s_ic.mat',subject_initials);     %outfile=sprintf('%s_balloon.mat',subject_initials);	 outfile_too_long=sprintf('b_%s_%02.0f-%02.0f.mat',date,d(4),d(5));     save(outfile_too_long);end;	  