Rp = -20*log10(0.95)
Rs = -20*log10(0.01)
[N, OmegaN] = buttord(0.4,0.6,Rp,Rs);
N
[b,a] = butter(N, OmegaN);
[Hb,omega] = freqz(b,a,2048)
plot(omega/pi,20*log10(abs(Hb)))