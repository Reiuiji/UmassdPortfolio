function y = lpfilt(SOS_LP,x,PrintPlot)
%Generate the filtered signal
% and plot the magnitude spectrum 
% of the filtered output
% Author: Jenny Doan
% Checker: Daniel Noyes

y = sosfilt(SOS_LP, x);

Y = fft(y);
Y = mag2db(abs(Y));
YY = linspace(size(Y,1),size(Y,2),size(Y,2));

YS = fftshift(Y,2);
YYS = YY - size(YS,2)/2;
%Plot Response of Butterworth Filter to Test Signal
figure('name','Figure 3: Response of Butterworth Filter to Test Signal','numbertitle','off');

plot(YYS,YS)
title('Response of Butterworth Filter to Test Signal')
xlabel('Frequency in Hz')
ylabel('Magnitude in dB')
axis([-8000 8000 50 150])
if PrintPlot
    print('-dpng','-r100','Part1_5-Response_of_Butterworth_Filter_to_Test_Signal.png')
end
