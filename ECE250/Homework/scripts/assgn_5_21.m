freq=10:1:10000;
w_d=2*pi*freq;
R=80;
L=260E-3;
C=18E-6;
v_m=10;
I=v_m./sqrt(R^2+(w_d.*L-1./(w_d.*C)).^2);
semilogx(freq,I)

xlabel('Frequency (Hz)');
ylabel('Amplitude (A)');