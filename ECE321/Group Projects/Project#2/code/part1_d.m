% Part 1B :This will deomonstrate part 1C
%
% Author: Daniel Noyes
% Checker: Cullen Fahey
%
% The base frequency to display in time
close all;

%Enable to Print out the figures
Enb_Print = 0;

BaseFreq = 8192;%Hz
T = 1/BaseFreq;
duration = 2;
AH = 440;

%9 number of harmonics
N = 9;
NH = 1:N;
H_amp = 0.707.^NH;

%Generate the Notes
AH_Note_Envolope = harmonics(AH, duration, N, H_amp, 1);
AH_Note_ExpDecay = harmonics(AH, duration, N, H_amp, 2);

Time_AH = 0:T:roundn(length(AH_Note_Envolope)*T,-1);%both the same length


%Plot the two notes vs time in sec
figure(1)
subplot(2,1,1)
plot(Time_AH, AH_Note_Envolope);
title('High A with Envelope shape')
xlabel('Time (2 seconds)')
ylabel('Amplitude')
grid on
xlim([0 length(AH_Note_Envolope)*T])

subplot(2,1,2)
plot(Time_AH, AH_Note_ExpDecay);
title('High A with Exponential Decay shape')
xlabel('Time (2 seconds)')
ylabel('Amplitude')
grid on
xlim([0 length(AH_Note_ExpDecay)*T])

%Output to a png image
if Enb_Print == 1
    print('-dpng','-r100', 'part1_d1.png')
end

%Spectrograms
figure(2)
subplot(2,1,1)
spectrogram(AH_Note_Envolope,256,196,512,8192, 'yaxis')
title('Spectrogram of AH note with Envolope shape')

subplot(2,1,2)
spectrogram(AH_Note_ExpDecay,256,196,512,8192, 'yaxis')
title('Spectrogram of AH note with Exponential Decay shape')

%Output to a png image
if Enb_Print == 1
    print('-dpng','-r100', 'part1_d2.png')
end


%plot 2 periods of the first note and compare that plot
% with the 2-period plots in c)
AH_Note_Nine_harmonics = harmonics(AH, duration, 9, ones(1,9), shape);


figure(3)
subplot(2,1,1)
plot(Time_AH, AH_Note_Nine_harmonics);
title('High A with Envelope shape')
xlabel('Time (2 seconds)')
ylabel('Amplitude')
grid on
xlim([0 duration/AH])

subplot(2,1,2)
plot(Time_AH, AH_Note_Envolope);
title('High A with Exponential Decay shape')
xlabel('Time (2 seconds)')
ylabel('Amplitude')
grid on
xlim([0 duration/AH])

%Output to a png image
if Enb_Print == 1
    print('-dpng','-r100', 'part1_d3.png')
end