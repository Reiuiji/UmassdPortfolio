close all
[bnum,bden] = butter(8,1000,'s');
[c1num,c1den] = cheby1(8,1,1000,'s');
[c2num,c2den] = cheby2(8,30,1100,'s');
[enum,eden] = ellip(8,1,30,1000,'s');

w = logspace(2,5,500);
Hb = freqs(bnum,bden,w);
Hc1 = freqs(c1num,c1den,w);
Hc2 = freqs(c2num,c2den,w);
He = freqs(enum,eden,w);

semilogx(w,20*log10(abs(Hb))); xlabel('Frequency in rad/sec'); ylabel('Magnitude in dB'); title('Bode Magnitude Plots of Different Filter Types')
hold on
pause
semilogx(w,20*log10(abs(Hc1)),'g');
pause
semilogx(w,20*log10(abs(Hc2)),'r');
pause
semilogx(w,20*log10(abs(He)),'k');
pause
axis([100 10000 -80 10])