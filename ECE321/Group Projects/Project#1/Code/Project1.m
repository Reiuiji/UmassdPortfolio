% Start the Project
%
% Author: Daniel Noyes
% Checker: [NULL]

% Generate all the notes
Period = 8192;

%Enable Contour
contour = 1;

%Enable Echo
Echo_Enable = 0;

%Enable to Print out the figures
Enb_Print = 0;

%Skip sound: for debugging
Sound_Enable = 1;

%gennotes;
AL  = 220; %A Low
As = 233.08;
Bb = 233.08;
B  = 246.94;
C  = 261.63;
Cs = 277.18;
Db = 277.18;
D  = 293.66;
Ds = 311.13;
Eb = 311.13;
E  = 329.63;
F  = 349.23;
Fs = 369.99;
Gb = 369.99;
G  = 392;
Gs = 415.30;
Ab = 415.30;
AH  = 440; %A High

%generate Each note needed
%Notes: tweaked the scale to fit the given Spectrogram(part 1:task4)
Eight_G = [gentone(G,0.25,1,contour) genrest(0.08)];
Half_Eb = [gentone(Eb,0.9,1,contour) genrest(0.1)];
Eight_F = [gentone(F,0.25,1,contour) genrest(0.08)];
Half_D = [gentone(D,0.9,1,contour) genrest(0.1)];

%Rest
Eight_Rest = genrest(0.25);

%Task# 3 :Plot Each Note
if Enb_Print == 1
    %G Eight Note
    figure(1)
    plot(Eight_G)
    xlim([0 Period*2])
    title('Plot of G - Eight Note')
    xlabel('Time (2 seconds)')
    ylabel('Amplitude')
    %Eb Half
    figure(2)
    plot(Half_Eb)
    xlim([0 Period*2])
    title('Plot of Eb - Half Note')
    xlabel('Time (2 seconds)')
    ylabel('Amplitude')
    %F Eight Note
    figure(3)
    plot(Eight_F)
    xlim([0 Period*2])
    title('Plot of F - Eight Note')
    xlabel('Time (2 seconds)')
    ylabel('Amplitude')
    %D Whole Note
    figure(4)
    plot(Half_D)
    xlim([0 Period*2])
    title('Plot of D - Whole Note')
    xlabel('Time (2 seconds)')
    ylabel('Amplitude')
    %End Plot Each Note
end

%Task #4
melody = [Eight_Rest Eight_G Eight_G Eight_G Half_Eb Eight_Rest Eight_F Eight_F Eight_F Half_D];

if Enb_Print == 1
    %Melody
    figure(5)
    plot(melody)
    xlim([0 Period*2])
    title('Plot of Melody')
    xlabel('Time (2 seconds)')
    ylabel('Amplitude')
    
    %Spectrogram
    figure(6)
    spectrogram(melody,256,196,512,8192, 'yaxis')
    title('Plot of Melody spectrogram')
end

if Sound_Enable == 1
    soundsc(melody);
end

%Part 3
if Echo_Enable == 1
    echo = zeros(1,2*Period);
    echo(1) = 1;
    echo(Period*0.5) = 0.5;
    echo(Period*1) = 0.25;
    echo(Period*1.5) = 0.125;
    echo(Period*2) = 0.0625;
    
    reverb = conv(melody,echo);
    
    if Sound_Enable == 1
        soundsc(reverb)
    end
    if Enb_Print == 1
        %Echoed Melody spectrogram
        figure(7)
        plot(reverb)
        xlim([0 Period*2])
        title('Plot of Echoed Melody')
        xlabel('Time (2 seconds)')
        ylabel('Amplitude')
        figure(8)
        spectrogram(reverb,256,196,512,8192, 'yaxis')
        title('Plot of Echoed Melody spectrogram')
    end
end