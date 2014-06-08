% Part 2 :
% Pass frequencies: 350-3500 Hz ; no more than 1 dB of amplitude distortion
% Attenuate frequencies below 50 and above 4000 Hz at least 40 dB.
% You get to select the type of filter and any other parameters.
%
% Author: Daniel Noyes
% Checker: Cullen Fahey, Jenny Doan, Brandyn Fastino
%
close all
clear
clc
%generate the data for clar
clar;
%Print
PrintPlot = 0;
%Sound
Sound_Enable = 0;

%generate the filter values
[SOS_LP, G_LP] = lpfilter_2_1;

disp('SOS_LP values:')
disp(SOS_LP)
disp('G_LP values:')
disp(G_LP)

%Calculate the magnitude for the melody
X = fft(melody);
X = mag2db(abs(X));
XX = linspace(size(X,1),size(X,2),size(X,2));

%Plot Magnitude Spectrum of Melody
figure('name','Figure 1: Magnitude Spectrum of Melody','numbertitle','off');

plot(XX,X)
title('Magnitude Spectrum of Melody')
xlabel('Frequency in Hz')
ylabel('Magnitude in dB')
axis([0 16000 0 100])

if PrintPlot
    print('-dpng','-r100','Part2_2-Magnitude_Spectrum_of_Melody.png')
end

%Plot filtered Melody

%multiply all the G_LP terms together
G = 1;
for k = 1:size(G_LP,1)
    G = G*G_LP(k);
end

y = G*sosfilt(SOS_LP, melody);

Y = fft(y);
Y = mag2db(abs(Y));
YY = linspace(size(Y,1),size(Y,2),size(Y,2));
YS = fftshift(Y,2);
YYS = YY - size(YS,2)/2;

figure('name','Figure 2: Filtered Melody','numbertitle','off');

plot(YYS,YS)
title('Filtered Melody')
xlabel('Frequency in Hz')
ylabel('Magnitude in dB')
axis([-8000 8000 00 100])
if PrintPlot
    print('-dpng','-r100','Part2_2-Filtered_melody.png')
end

%Spectrograms
figure('name','Figure 3: Spectrogram comparisons','numbertitle','off')

subplot(2,1,1)
spectrogram(melody,256,196,512,8192, 'yaxis')
title('Spectrogram of filtered melody')
subplot(2,1,2)
spectrogram(YS,256,196,512,8192, 'yaxis')
title('Spectrogram of filtered melody')
if PrintPlot
    print('-dpng','-r100','Part2_2-Spectrogram_Filtered_melody.png')
end

%play the unfiltered and filter sound
if Sound_Enable
    disp('playing unfiltered melody')
    soundsc(melody);
    disp('playing filtered melody')
    soundsc(y);
end
