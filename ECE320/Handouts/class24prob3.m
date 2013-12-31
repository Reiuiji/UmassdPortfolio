Omegap = 0.4;
Omegas = 0.6;
delta1 = 0.05;
delta2 = 0.01;
Rp = -20*log10(1-delta1);
Rs = -20*log10(delta2);
[Nb,Wnb] = buttord(Omegap,Omegas,Rp,Rs)
[bb,ab] = butter(Nb,Wnb);

[Hb,Omega] = freqz(bb,ab,8192);
figure(1)
subplot(311)
plot(Omega/pi,20*log10(abs(Hb)))
axis([0 1 -100 0]);
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Butterworth Filter')
grid
subplot(312)
plot(Omega/pi,abs(Hb))
axis([0 Omegap 1-delta1 1+delta1])
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Butterworth Filter Passband Detail')
subplot(313)
plot(Omega/pi,abs(Hb))
axis([Omegas 1 0 delta2])
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Butterworth Filter Stopband Detail')

[Nc,Wnc] = cheb2ord(Omegap,Omegas,Rp,Rs)
[bc,ac] = cheby2(Nc,Rs,Wnc);
[Hc,Omega] = freqz(bc,ac,8192);
figure(2)
clf
subplot(311)
plot(Omega/pi,20*log10(abs(Hc)))
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Chebyshev Type 2 Filter')
axis([0 1 -100 0])
grid
subplot(312)
plot(Omega/pi,abs(Hc))
axis([0 Omegap 1-delta1 1+delta1])
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Chebyshev Type 2 Filter Passband Detail')
subplot(313)
plot(Omega/pi,abs(Hc))
axis([Omegas 1 0 delta2])
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Chebyshev Type 2 Filter Stopband Detail')
