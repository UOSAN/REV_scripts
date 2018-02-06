% updated 3-24-15 to include exptCond variable for control vs. experimental
% group

function [] = displayPrepScreens(exptCond,sub_session,w,MRI,xcenter,ycenter)
% startstring = sprintf('Get ready for scan number %d!',sub_session);
% Screen('DrawText',w,startstring,100,100);
if MRI==1,
    Screen('DrawText',w,'Waiting for trigger...',xcenter-150,ycenter);
    Screen('Flip',w);
    elseif exptCond == 1
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
    elseif exptCond == 0
        Screen('DrawText',w,'Press the left button (LEFT index finger) if you see <',100,100); %from Lauren's practice task
        Screen('DrawText',w,'Press the right button (RIGHT index finger) if you see >',100,130); %from Lauren'spractice task
        Screen('DrawText',w,'Press the button as QUICKLY and as ACCURATELY',100,180); %all from Lauren's practice task
        Screen('DrawText',w,'as you can when you see the arrow.',100,210);
        %Screen('DrawText',w,'But if you hear a beep, try very hard to STOP',100,240);
        %Screen('DrawText',w,'yourself from pressing the button on that arrow only.',100,270);
        Screen('DrawText',w,'SPEED and ACCURACY are equally important.',100,300);
        %Screen('DrawText',w,'So DO NOT slow down your response to wait for the beep,',100,330);
        %Screen('DrawText',w,'because then you are no longer going when you are supposed to.',100,360);
        %Screen('DrawText',w,'The task will adjust to your performance as you get better,',100,390);
        %Screen('DrawText',w,'so you won''t always be able to stop when you hear a beep.',100,390);
        %Screen('DrawText',w,'As long as you go quickly all of the time',100,420);
        Screen('DrawText',w,'It is OK to make some mistakes as you try to respond quickly,',100,450);
        Screen('DrawText',w,'but try to get the right answer as much as possible.',100,480);
        Screen('DrawText',w,'Ask the experimenter if you have any questions.',100,530);
        Screen('DrawText',w,'Press any key to go on.',100,560);
        Screen('Flip',w);
end;

