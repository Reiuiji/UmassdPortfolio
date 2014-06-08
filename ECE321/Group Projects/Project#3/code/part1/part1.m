% Part 1 : Create a test signal that will make up of the first 40 harmonics
% of 100Hz. samles 1/8192s with 2 second time.
%
% Author: Daniel Noyes
% Checker: Jenny Doan
%
close all
clear
clc
%Print
PrintPlot = 0;
%Sound
Sound_Enable = 0;

%Part 1.1 : generate a 2 second time vector
t=0:1/8192:2;
x = zeros(size(t));

%For loop for adding sine waves at harmonic frequencies k*100 Hz to x
for k = 1:40
    x = x + sin(t*100*k*2*pi);
end

%Part 1.2 : Compute the magnitude spectrum of x using the fft
X = fft(x);
X = mag2db(abs(X));
XX = linspace(size(X,1),size(X,2),size(X,2));

%Plot Magnitude Spectrum of Test Signal
figure('name','Figure 1: Magnitude Spectrum of Test Signal','numbertitle','off');

plot(XX,X)
title('Magnitude Spectrum of Test Signal')
xlabel('Frequency in Hz')
ylabel('Magnitude in dB')
axis([0 16000 0 100])
if PrintPlot
    print('-dpng','-r100','Part1_2-Magnitude_Spectrum_of_Test_Signal.png')
end

%Part 1.3 : Center the magnitude
XS = fftshift(X,2);
XXS = XX - size(XS,2)/2;
%Plot "corrected" Magnitude Spectrum of Test Signal plot
figure('name','Figure 2: Centered Magnitude Spectrum of Test Signal','numbertitle','off');

plot(XXS,XS)
title('Centered Magnitude Spectrum of Test Signal')
xlabel('Frequency in Hz')
ylabel('Magnitude in dB')
axis([-8000 8000 0 100])
if PrintPlot
    print('-dpng','-r100','Part1_3-Centered_Magnitude_Spectrum_of_Test_Signal.png')
end

%Part 1.4 : Generate the LP values
[SOS_LP, G_LP] = LP;
disp('Part 1.4 generated SOS_LP')
disp(SOS_LP)
disp('Part 1.4 generated G_LP')
disp(G_LP)

%Part 1.5
y1 = lpfilt(SOS_LP,x,PrintPlot);

%Part 1.6
y2 = lpfiltc(SOS_LP,G_LP,x,PrintPlot);

%Part 1.7 : listen to the signal before and after filtering,
% What differences did you noticed: the tone is alot lower

%before filter
if Sound_Enable
    soundsc(x);
end

%after filter
if Sound_Enable
    soundsc(y1); %Filtered
    %soundsc(y2); %Gained fixed Filtered
end

%Part 1.8 :Change the Design Method. Keep
%the IIR button selected but change from Butterworth to Chebyshev Type 1 
%then to Chebyshev Type 2 then to Elliptic.
