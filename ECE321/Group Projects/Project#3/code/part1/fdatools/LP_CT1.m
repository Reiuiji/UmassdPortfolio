function [sosMatrix,ScaleValues] = LP_CT1
%LP_CT1 Returns a discrete-time filter object.

%
% MATLAB Code
% Generated by MATLAB(R) 7.12 and the Signal Processing Toolbox 6.15.
%
% Generated on: 27-Apr-2014 21:34:28
%

% Chebyshev Type I Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
Fs = 8192;  % Sampling Frequency

Fpass = 2000;        % Passband Frequency
Fstop = 3000;        % Stopband Frequency
Apass = 1;           % Passband Ripple (dB)
Astop = 80;          % Stopband Attenuation (dB)
match = 'passband';  % Band to match exactly

% Construct an FDESIGN object and call its CHEBY1 method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'cheby1', 'MatchExactly', match);

sosMatrix = Hd.sosMatrix;
ScaleValues = Hd.ScaleValues;