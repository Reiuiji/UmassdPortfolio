% Part 1B :This will deomonstrate part 1C
%
% Author: Daniel Noyes
% Checker: Jenny Doan
%
% The base frequency to display in time
close all;
%Enable to Print out the figures
Enb_Print = 0;

BaseFreq = 8192;%Hz
T = 1/BaseFreq;
duration = 2;
AH = 440;
shape = 0;

%Generate the Notes
AH_Note = harmonics(AH, duration, 1,ones(1,1), shape);
AH_Note_Nine_harmonics = harmonics(AH, duration, 9, ones(1,9), shape);

%Calculate the Time duration for the graph
Time_AH = 0:T:roundn(length(AH_Note)*T,-1);
Time_AH_Harmonics = 0:T:roundn(length(AH_Note_Nine_harmonics)*T,-1);

figure(1)
subplot(2,1,1)

plot(Time_AH,AH_Note);

title('Plot of Note(non harmonic)')
xlabel('Time (2 seconds)')
ylabel('Amplitude')
grid on
xlim([0 (duration/AH)])

subplot(2,1,2)

plot(Time_AH_Harmonics,AH_Note_Nine_harmonics);

title('Plot of 9 Harmonics')
xlabel('Time (2 seconds)')
ylabel('Amplitude')
xlim([0 (duration/AH)])

%Output to a png image
if Enb_Print == 1
	print('-dpng','-r100', 'part1_c.png')
end
