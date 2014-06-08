function rest = genrest( duration )
% Generate a rest of specified duration value(in seconds)
%
% Author: Daniel Noyes
% Checker: [NULL]
%
% Frequency (in Hertz)
%
% The base frequency
BaseFreq = 8192;%Hz

rest = zeros(1,fix(BaseFreq*duration));

end

