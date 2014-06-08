function note = gentone(frequency,duration,gain,contour)
% Generate a note of specified duration value(in seconds)
%
% Author: Daniel Noyes
% Checker: Cullen Fahey
%
% Frequency (in Hertz)
% Gain (start with 1)
% 
% todo : Generate the neccessary pause at the end
%
% The base frequency
BaseFreq = 8192;%Hz

T=0:1/BaseFreq:duration;

note = gain*sin(T*frequency*2*pi);

if contour == 1
    note = note.*shape(duration);
end
    
    

%note = gain*sin(linspace(0, duration*frequency*(2*pi), round(duration*BaseFreq))); % Duration is in Seconds

end
