function OUT = shape(duration)
% Will Generate the contour Shape of the wave
%
% Author: Daniel Noyes
% Checker: [NULL]
BaseFreq = 8192;
T=0:1/BaseFreq:duration;

%Calculate the Attack from 0 to 0,06 seconds
Attack_x = 0:1/BaseFreq:0.06;
Attack = Attack_x*1/0.06;

%Calculate the Decay from 0.06 to 0,09(0.03) seconds
Decay_x = 0:1/BaseFreq:0.03;
Decay = 1 - Decay_x*1/0.06;

%Calculate the Release (0.03 seconds)
Release_x = 0:1/BaseFreq:0.03;
Release = 0.5 - Release_x*1/0.06;

%Calculate the Sustain from 0.09 to duration - 0,03 seconds
S_size = size(T,2) - size(Attack_x,2) - size(Decay_x,2) - size(Release,2);
Sustain_x = 0:S_size-1; %remove the attack,decay,release
Sustain = Sustain_x*0 + 0.5;%time 0 just to create a place so the 0.5 goes in


OUT = [Attack Decay Sustain Release];

end