%Problem 9.5 (b)

Omegap = 0.2;
Omegas = 0.3;
d1 = 0.02;
d2 = 0.05;
Rp = -20*log10(1-d1);
Rs = -20*log10(d2);

%Butterworth: 
[N_butter,Omegan_butter] = buttord(Omegap,Omegas,Rp,Rs);
[bbutter,abutter] = butter(N_butter,Omegan_butter);

disp('Butterworth N:')
disp(N_butter)

[H_butter Omega_Butter] = freqz(bbutter, abutter, 8192);
figure(1)
clf
subplot(311)
plot(Omega_Butter/pi,20*log10(abs(H_butter)))
axis([0 1 -100 0]);
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Butterworth Filter')
grid
subplot(312)
plot(Omega_Butter/pi,abs(H_butter))
axis([0 Omegap 1-d1 1+d1])
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Butterworth Filter Passband Detail')
subplot(313)
plot(Omega_Butter/pi,abs(H_butter))
axis([Omegas 1 0 d2])
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Butterworth Filter Stopband Detail')



if FINALPLOTS
    print -deps PS9-5-1.eps
end


%Chebyshev Type II:
[N_Chebyshev,Omegan_Chebyshev] = cheb2ord(Omegap,Omegas,Rp,Rs);
[bcheby2,acheby2] = cheby2(N_Chebyshev,Rs,Omegan_Chebyshev);
[H_Chebyshev,Omega_Chebyshev] = freqz(bcheby2,acheby2,8192);

disp('Chebyshev N')
disp(N_Chebyshev)

figure(2)
clf
subplot(311)

plot(Omega_Chebyshev/pi,20*log10(abs(H_Chebyshev)))
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Chebyshev Type 2 Filter')
axis([0 1 -100 0])
grid
subplot(312)
plot(Omega_Chebyshev/pi,abs(H_Chebyshev))
axis([0 Omegap 1-d1 1+d1])
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Chebyshev Type 2 Filter Passband Detail')
subplot(313)
plot(Omega_Chebyshev/pi,abs(H_Chebyshev))
axis([Omegas 1 0 d2])
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Chebyshev Type 2 Filter Stopband Detail')

if FINALPLOTS
    print -deps PS9-5-2.eps
end


%Elliptic filter:

[N_Elliptic,Omegan_Elliptic] = ellipord(Omegap,Omegas,Rp,Rs);
[bElliptic,aElliptic] = ellip(N_Elliptic,Rp,Rs,Omegan_Elliptic);
[H_Elliptic,Omega_Elliptic] = freqz(bElliptic,aElliptic,8192);

disp('Elliptic N')
disp(N_Elliptic)

figure(3)
clf
subplot(311)
plot(Omega_Elliptic/pi,20*log10(abs(H_Elliptic)))
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Elliptic Filter')
axis([0 1 -100 0])
grid
subplot(312)
plot(Omega_Elliptic/pi,abs(H_Elliptic))
axis([0 Omegap 1-d1 1+d1])
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Elliptic Filter Passband Detail')
subplot(313)
plot(Omega_Elliptic/pi,abs(H_Elliptic))
axis([Omegas 1 0 d2])
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
dpzplot(bbutter,abutter)

if FINALPLOTS
    print -deps PS9-5-4.eps
end

%Chebyshev
figure(5)
xlabel('Re(z)')
ylabel('Im(z)')
title('Dzplot of a Chebyshev Filter')
grid
dpzplot(bcheby2,acheby2)

if FINALPLOTS
    print -deps PS9-5-5.eps
end

%Elliptic
figure(6)
xlabel('Re(z)')
ylabel('Im(z)')
title('Dzplot of a Elliptic Filter')
grid
dpzplot(bElliptic,aElliptic)

if FINALPLOTS
    print -deps PS9-5-6.eps
end
