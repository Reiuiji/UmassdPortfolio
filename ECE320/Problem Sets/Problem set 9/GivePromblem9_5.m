Omegap = 0.2;
Omegas = 0.3;
delta1 = 0.02;
delta2 = 0.05;
Rp = -20*log10(1-delta1);
Rs = -20*log10(delta2);

%computes the butterworth

[Nb,Wnb] = buttord(Omegap,Omegas,Rp,Rs);
[bb,ab] = butter(Nb,Wnb);
disp('Butterworth N')
disp(Nb)

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

if FINALPLOTS
    print -deps PS9-5-1.eps
end


%calculate the chebys

[Nc,Wnc] = cheb2ord(Omegap,Omegas,Rp,Rs);
[bc,ac] = cheby2(Nc,Rs,Wnc);
[Hc,Omega] = freqz(bc,ac,8192);

disp('Chebyshev N')
disp(Nc)

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

if FINALPLOTS
    print -deps PS9-5-2.eps
end

%computer Elliptic

[Ne,WNe] = ellipord(Omegap,Omegas,Rp,Rs);
[be,ae] = ellip(Ne,Rp,Rs,WNe);
[He,OmegaE] = freqz(be,ae,8192);

disp('Elliptic N')
disp(Ne)

figure(3)
clf
subplot(311)
plot(OmegaE/pi,20*log10(abs(He)))
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Elliptic Filter')
axis([0 1 -100 0])
grid
subplot(312)
plot(OmegaE/pi,abs(He))
axis([0 Omegap 1-delta1 1+delta1])
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Elliptic Filter Passband Detail')
subplot(313)
plot(OmegaE/pi,abs(He))
axis([Omegas 1 0 delta2])
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Elliptic Filter Stopband Detail')

if FINALPLOTS
    print -deps PS9-5-3.eps
end


%Part 3
%Butterworth
figure(4)
xlabel('Re(z)')
ylabel('Im(z)')
title('Dzplot of a ButterWorth Filter')
grid
dpzplot(bb,ab)

if FINALPLOTS
    print -deps PS9-5-4.eps
end

%Chebyshev
figure(5)
xlabel('Re(z)')
ylabel('Im(z)')
title('Dzplot of a Chebyshev Filter')
grid
dpzplot(bc,ac)

if FINALPLOTS
    print -deps PS9-5-5.eps
end

%Elliptic
figure(6)
xlabel('Re(z)')
ylabel('Im(z)')
title('Dzplot of a Elliptic Filter')
grid
dpzplot(be,ae)

if FINALPLOTS
    print -deps PS9-5-6.eps
end
