% Part 3 : Syntesis music from sheet music.
%
% Author: Daniel Noyes
% Checker: Cullen Fahey, Jenny Doan, Brandyn Fastino
%
clear all
clc
Period = 8192;

%Skip sound: for debugging
Sound_Enable = 1;
Display = 0;
Enb_Print = 0;

%generate the note freq
gennotes;

%number of harmonics: 9 : clarinet
N = 9;
NH = 1:N;
%H_amp = 1.*NH;
%number of harmonics: 9 : piano
H_amp = 0.3.^NH;

contour = 2;
time = 0.5;
% whole = 2*time
% half  = 1*time
% quater= 0.5*time
% eight = 0.25*time

%generate Eight Notes
EC4 = [harmonics(Cs4,0.25*time,N,H_amp,contour) genrest(0.08)];
ED4 = [harmonics(Ds4,0.25*time,N,H_amp,contour) genrest(0.08)];
EE4 = [harmonics(E4,0.25*time,N,H_amp,contour) genrest(0.08)];
EF4 = [harmonics(Fs4,0.25*time,N,H_amp,contour) genrest(0.08)];
EG4 = [harmonics(Gs4,0.25*time,N,H_amp,contour) genrest(0.08)];
EA4 = [harmonics(As4,0.25*time,N,H_amp,contour) genrest(0.08)];
EB4 = [harmonics(B4,0.25*time,N,H_amp,contour) genrest(0.08)];
EC5 = [harmonics(Cs5,0.25*time,N,H_amp,contour) genrest(0.08)];
ED5 = [harmonics(Ds5,0.25*time,N,H_amp,contour) genrest(0.08)];
EE5 = [harmonics(E5,0.25*time,N,H_amp,contour) genrest(0.08)];
EF5 = [harmonics(Fs5,0.25*time,N,H_amp,contour) genrest(0.08)];
EG5 = [harmonics(Gs5,0.25*time,N,H_amp,contour) genrest(0.08)];
EA5 = [harmonics(As5,0.25*time,N,H_amp,contour) genrest(0.08)];
EB5 = [harmonics(B5,0.25*time,N,H_amp,contour) genrest(0.08)];
EC6 = [harmonics(Cs6,0.25*time,N,H_amp,contour) genrest(0.08)];

%Generate 3/8 note
E3A4 = [harmonics(As4,0.75*time ,N,H_amp,contour) genrest(0.08)];
E3B4 = [harmonics(B4,0.75*time ,N,H_amp,contour) genrest(0.08)];
E3C5 = [harmonics(Cs5,0.75*time ,N,H_amp,contour) genrest(0.08)];
E3D5 = [harmonics(Ds5,0.75*time ,N,H_amp,contour) genrest(0.08)];
E3E5 = [harmonics(E5,0.75*time ,N,H_amp,contour) genrest(0.08)];
E3F5 = [harmonics(Fs5,0.75*time ,N,H_amp,contour) genrest(0.08)];
E3G5 = [harmonics(Gs5,0.75*time ,N,H_amp,contour) genrest(0.08)];
E3A5 = [harmonics(As5,0.75*time ,N,H_amp,contour) genrest(0.08)];
E3B5 = [harmonics(B5,0.75*time ,N,H_amp,contour) genrest(0.08)];

E3CN5 = [harmonics(C5,0.75*time ,N,H_amp,contour) genrest(0.08)];

%Generate 3/4 Notes
Q3A4 =  [harmonics(As4,1.5*time ,N,H_amp,contour) genrest(0.08)];
Q3B4 =  [harmonics(B4,1.5*time ,N,H_amp,contour) genrest(0.08)];
Q3C5 =  [harmonics(Cs5,1.5*time ,N,H_amp,contour) genrest(0.08)];
Q3F5 =  [harmonics(Fs5,1.5*time ,N,H_amp,contour) genrest(0.08)];
Q3G5 =  [harmonics(Gs5,1.5*time ,N,H_amp,contour) genrest(0.08)];
Q3A5 =  [harmonics(As5,1.5*time ,N,H_amp,contour) genrest(0.08)];
Q3B5 =  [harmonics(B5,1.5*time ,N,H_amp,contour) genrest(0.08)];

%Generate 6/4 half note

H3GN4 = [harmonics(G4,3*time ,N,H_amp,contour) genrest(0.08)];
H3A5  = [harmonics(A5,3*time ,N,H_amp,contour) genrest(0.08)];

%Generate Quarter note
QB4 = [harmonics(B4,0.5*time ,N,H_amp,contour) genrest(0.08)];
QD4 = [harmonics(Ds4,0.5*time ,N,H_amp,contour) genrest(0.08)];
QE4 = [harmonics(E4,0.5*time,N,H_amp,contour) genrest(0.08)];
QF4 = [harmonics(Fs4,0.5*time,N,H_amp,contour) genrest(0.08)];
QA5 = [harmonics(A5,0.5*time,N,H_amp,contour) genrest(0.08)];
QC5 = [harmonics(Cs5,0.5*time ,N,H_amp,contour) genrest(0.08)];
QD5 = [harmonics(Ds5,0.5*time,N,H_amp,contour) genrest(0.08)];
QE5 = [harmonics(E5,0.5*time,N,H_amp,contour) genrest(0.08)];
QG5 = [harmonics(Gs5,0.5*time,N,H_amp,contour) genrest(0.08)];

QCN5= [harmonics(C5,0.5*time,N,H_amp,contour) genrest(0.08)];

%generate Half note
HD5 = [harmonics(Ds5,1*time,N,H_amp,contour) genrest(0.08)];
HF5 = [harmonics(Fs5,1*time,N,H_amp,contour) genrest(0.08)];

%generate whole note
WA4 = [harmonics(A4,2*time,N,H_amp,contour) genrest(0.08)];
WB4 = [harmonics(B4,2*time,N,H_amp,contour) genrest(0.08)];
WC5 = [harmonics(Cs5,2*time,N,H_amp,contour) genrest(0.08)];

%special note configurations

E5D5 = [harmonics(E5,1.25*time,N,H_amp,contour) genrest(0.08)];
E5F5 = [harmonics(Fs5,1.25*time,N,H_amp,contour) genrest(0.08)];
E7E5 = [harmonics(E5,1.75*time,N,H_amp,contour) genrest(0.08)];
E9D5 = [harmonics(Ds5,2.25*time,N,H_amp,contour) genrest(0.08)];
E9E5 = [harmonics(E5,2.25*time,N,H_amp,contour) genrest(0.08)];
E13D5 = [harmonics(Ds5,3.25*time,N,H_amp,contour) genrest(0.08)];

Q7GN4 = [harmonics(G4,3.5*time,N,H_amp,contour) genrest(0.08)];
Q7B4 = [harmonics(B4,3.5*time,N,H_amp,contour) genrest(0.08)];
Q7D5 = [harmonics(Ds5,3.5*time,N,H_amp,contour) genrest(0.08)];

W2D5 = [harmonics(Ds5,4*time,N,H_amp,contour) genrest(0.08)];

%Rest
ER = genrest(0.25*time);
QR = genrest(0.5*time);



%Create each verse: "," indicate next measure
GV1 = [ER ED4 EG4 EA4 E3B4 ED4, EG4 EA4 Q3B4, ER EE4 EG4 EA4 E3B4 EE4, EG4 EA4 Q3B4];
GV2 = [ER EC4 EF4 EG4 E3A4 EC4, EF4 EG4 Q3B4, ER EG4 EA4 EG4 H3GN4];
GV3 = [ER ED5 EG5 EA5 E3B5 ED5, EG5 EA5 Q3B5, ER EE5 EG5 EA5 E3B5 EE5, EG5 EA5 Q3B5];
GV4 = [ER EC5 EF5 EG5 E3A5 EC5, EF5 EG5 Q3A5, ER EB5 EC6 EB5 H3A5 ]; 
GV5 = [QR E3D5 E3B5, E3A5 E3G5 QD5, HF5 EF5 EG5 EF5 E9E5];
GV6 = [QR E3C5 E3A5, E3G5 E3F5 QE5, HD5 EE5 EF5 EE5 E9D5];
GV7 = [QR E3D5 E3B5, E3A5 E3G5 QD5, HF5 EF5 EG5 EF5 E7E5 QB4];
GV8 = [Q3C5 QG5, Q3F5 QE5, W2D5];
GV9 = [QR E3B5 E3A5, E3B5 E3A5 QD5, E5F5 EE5 ED5 E9E5];
GV10 =[QR E3A5 E3G5, E3A5 E3F5 QE5, HD5 EE5 EF5 EE5 E9D5];
GV11 =[QR EG4 EA4 EB4 E3D5, EG4 EA4 EB4 E5D5, QR EG4 EA4 EB4 E3E5, EG4 EA4 EB4 E3E5 EB4];
GV12 =[Q3C5 QA5, Q3G5 QC5, W2D5];
GV13 =[EB4 EA4 WB4, EG4 EA4 EB4 EC5 EB4 EA4, EB4 EA4 Q7B4];
GV14 =[EA4 EG4 WA4, EF4 EG4 EA4 EB4 EA4 EG4, EA4 EG4 Q7GN4];
GV15 = GV13;
GV16 =[EC5 EB4 WC5, EA4 EB4 EC5 ED5 EE5 EF5, ED5 EE5 Q7D5];
GV17 =[QD4 EB4 E3A4 QB4, QD4 EB4 E3A4 QB4, QE4 EB4 E3A4 QB4, QE4 EB4 E3A4 QB4];
GV18 =[QF4 EC5 E3CN5 QC5, QF4 EC5 E3CN5 QC5, EE5 EF5 EE5 E13D5];

%Assemble the melody
% soundsc wont output more than two sets (GV1 GV2), idk why....
%Gerudo_Valley = [GV1 GV2 GV3 GV4 GV5 GV6 GV7 GV8 GV9 GV10 GV11 GV12 GV13 GV14 GV15 GV16 GV17 GV18];
GVm1 = [GV1  GV2 ];
GVm2 = [GV3  GV4 ];
GVm3 = [GV5  GV6 ];
GVm4 = [GV7  GV8 ];
GVm5 = [GV9  GV10];
GVm6 = [GV11 GV12];
GVm7 = [GV13 GV14];
GVm8 = [GV15 GV16];
GVm9 = [GV17 GV18];




%Filter the melody segments
%Gerudo_Valley_Filter = lpfilt(Gerudo_Valley);
GVm1F = lpfilt(GVm1);
GVm2F = lpfilt(GVm2);
GVm3F = lpfilt(GVm3);
GVm4F = lpfilt(GVm4);
GVm5F = lpfilt(GVm5);
GVm6F = lpfilt(GVm6);
GVm7F = lpfilt(GVm7);
GVm8F = lpfilt(GVm8);
GVm9F = lpfilt(GVm9);

% if Display
% %Spectrograms
% figure(1)
% spectrogram(Gerudo_Valley_Filter,256,196,512,8192, 'yaxis')
% title('Spectrogram of Clarinet')
% end
%Output to a png image
% if Enb_Print
%     print('-dpng','-r100', 'part2_2.png')
% end

if Sound_Enable
    %soundsc(Gerudo_Valley_Filter);
    soundsc(GVm1F);
    soundsc(GVm2F);
    soundsc(GVm3F);
    soundsc(GVm4F);
    soundsc(GVm5F);
    soundsc(GVm6F);
    soundsc(GVm7F);
    soundsc(GVm8F);
    soundsc(GVm9F);
end
