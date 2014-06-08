function y = lpfiltc(SOS_LP,G_LP,x,PrintPlot)
% Part 1.6 : Correct the magnitude range
% Extra credit
%
% Author: Daniel Noyes
% Checker: Jenny Doan
%

%multiply all the G_LP terms together
G = 1;
for k = 1:size(G_LP,1)
    G = G*G_LP(k);
end
%Output the corrected gain
y = G*sosfilt(SOS_LP, x);

Y = fft(y);
Y = mag2db(abs(Y));
YY = linspace(size(Y,1),size(Y,2),size(Y,2));
YS = fftshift(Y,2);
YYS = YY - size(YS,2)/2;

%Plot Corrected Gain: Response of Butterworth Filter to Test Signal
figure('name','Figure 4:Corrected Gain: Response of Butterworth Filter to Test Signal','numbertitle','off');

plot(YYS,YS)
title('Corrected Gain: Response of Butterworth Filter to Test Signal')
xlabel('Frequency in Hz')
ylabel('Magnitude in dB')
axis([-8000 8000 00 100])
if PrintPlot
    print('-dpng','-r100','Part1_6-Corrected_Gain-Response_of_Butterworth_Filter_to_Test_Signal.png')
end
