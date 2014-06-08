function [sosMatrix,ScaleValues] = lpfilter_2_1
%LPFILTER_2_1 Returns a discrete-time filter object.

%
% MATLAB Code
% Generated by MATLAB(R) 7.12 and the Signal Processing Toolbox 6.15.
%
% Generated on: 27-Apr-2014 23:51:45
%
% Author: Jenny Doan
% Checker: Daniel Noyes
%

% Elliptic Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 8192;  % Sampling Frequency

Fstop1 = 50;      % First Stopband Frequency
Fpass1 = 350;     % First Passband Frequency
Fpass2 = 3500;    % Second Passband Frequency
Fstop2 = 4000;    % Second Stopband Frequency
Astop1 = 40;      % First Stopband Attenuation (dB)
Apass  = 1;       % Passband Ripple (dB)
Astop2 = 40;      % Second Stopband Attenuation (dB)
match  = 'both';  % Band to match exactly

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, ...
                      Astop2, Fs);
Hd = design(h, 'ellip', 'MatchExactly', match);

sosMatrix = Hd.sosMatrix;
ScaleValues = Hd.ScaleValues;
