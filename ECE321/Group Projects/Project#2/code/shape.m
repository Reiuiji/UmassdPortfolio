function OUT = shape(duration,contour)
% Will Generate the contour Shape of the wave
%
% Author: Daniel Noyes
% Checker: Brandyn Fastino
BaseFreq = 8192;
T = 1/BaseFreq;
TS=0:T:duration;

if contour == 1%Regular shape

    %Calculate the Attack from 0 to 0,06 seconds
    Attack_x = 0:T:0.06;
    Attack = Attack_x*1/0.06;

    %Calculate the Decay from 0.06 to 0,09(0.03) seconds
    Decay_x = 0:T:0.03;
    Decay = 1 - Decay_x*1/0.06;

    %Calculate the Release (0.03 seconds)
    Release_x = 0:T:0.03;
    Release = 0.5 - Release_x*1/0.06;

    %Calculate the Sustain from 0.09 to duration - 0,03 seconds
    S_size = size(TS,2) - size(Attack_x,2) - size(Decay_x,2) - size(Release,2);
    Sustain_x = 0:S_size-1; %remove the attack,decay,release
    Sustain = Sustain_x*0 + 0.5;%time 0 just to create a place so the 0.5 goes in

    OUT = [Attack Decay Sustain Release];
elseif contour == 2%Exponential release (Part 1D)

    %Calculate the Attack from 0 to 0,06 seconds
    Attack_x = 0:T:0.06;
    Attack = Attack_x*1/0.06;
    
    Release_x = 0:T:0.03;

    S_size = size(TS,2) - size(Attack_x,2) - size(Release_x,2);
    ExpSize = 0:S_size-1;
    ExpSize = ExpSize.*T;
    Tau = 2/5;
    ExpDecay = exp(-ExpSize/(Tau));
    
    %Calculate the Release (0.03 seconds)
    Release = linspace(ExpDecay(end), 0,round(BaseFreq*0.03));
    
    OUT = [Attack ExpDecay Release];
    
end
end