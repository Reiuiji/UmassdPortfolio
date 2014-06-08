% Part 1B :This will deomonstrate part 1 b
%
% Author: Daniel Noyes
% Checker: Brandyn Fastino
%
close all;
%Enable to Print out the figures
Enb_Print = 0;

shape = 0;
%set up each harmonic tone
outP1_b9 = harmonics(440, 1, 9, ones(1,9), shape);
outP1_b10 = harmonics(440, 1, 10, ones(1,10), shape);

figure(1)
subplot(2,1,1)
%Spectrogram for 9 harmonics
spectrogram(outP1_b9,256,196,512,8192, 'yaxis')
title('Plot of 9 Harmonic spectrogram')
%Spectrogram for 10 harmonics
subplot(2,1,2)
spectrogram(outP1_b10,256,196,512,8192, 'yaxis')
title('Plot of 10 Harmonic spectrogram')

%Output to a png image
if Enb_Print == 1
	print('-dpng','-r100', 'part1_b.png')
end
