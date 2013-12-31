%Problem 9.5 (a)

Omegap = 0.2;
Omegas = 0.3;
delta1 = 0.02;
delta2 = 0.05;
Rp = -20*log10(1-delta1);
Rs = -20*log10(delta2);

%Butterworth: N = 11
Butterworth_N = buttord(Omegap,Omegas,Rp,Rs)

%Chebyshev Type II: N = 6
Chebyshev_N = cheb2ord(Omegap,Omegas,Rp,Rs)
%[bcheby2,acheby2] = cheby2(N,Rs,Omegan)

%Elliptic filter:N=4
Elliptic_N = ellipord(Omegap,Omegas,Rp,Rs)
%[bellip,aellip] = ellip(N,Rp,Rs,Omegan)
