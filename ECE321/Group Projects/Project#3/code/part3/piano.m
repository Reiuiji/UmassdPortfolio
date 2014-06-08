% piano.m :Simulate playing a piano
% Uses the exponential delay function
%
% Author: Daniel Noyes
% Checker: Jenny Doan
%
% Generate all the notes
Period = 8192;
%Skip sound: for debugging
Sound_Enable = 1;
Enb_Print = 0;

%generate the note freq
gennotes;

%number of harmonics: 9
N = 9;
NH = 1:N;
H_amp = 0.2.^NH;

contour = 2;

%generate Each note needed
%Notes: tweaked the scale to fit the given Spectrogram(Project 1: part 1:task4)
Eight_G = [harmonics(G,0.25,N,H_amp,contour) genrest(0.1)];
Half_Eb = [harmonics(Eb,0.9,N,H_amp,contour) genrest(0.1)];
Eight_F = [harmonics(F,0.25,N,H_amp,contour) genrest(0.1)];
Half_D =  [harmonics(D,0.9 ,N,H_amp,contour) genrest(0.1)];

%Rest
Eight_Rest = genrest(0.25);


%Assemble the melody
melody = [Eight_Rest Eight_G Eight_G Eight_G Half_Eb Eight_Rest Eight_F Eight_F Eight_F Half_D];

%Spectrograms
figure(1)
spectrogram(melody,256,196,512,8192, 'yaxis')
title('Spectrogram of Piano')
%Output to a png image
if Enb_Print == 1
    print('-dpng','-r100', 'part2_1.png')
end

if Sound_Enable == 1
    soundsc(melody);
end