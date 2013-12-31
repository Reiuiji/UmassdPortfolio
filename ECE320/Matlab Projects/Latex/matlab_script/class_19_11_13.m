b = [1 2 1];
a = [5 -2 1];
[H, Omega] = freqz(b,a,2048);
plot(Omega/pi, 20*log10(abs(H)))
title('Class Problem 1.b')
xlabel('DT Frequency \omega (rad/sec)')
ylabel('|H(j \omega)|')
YI = INTERP1(20*log10(abs(H)),Omega/pi,-3)


if FINALPLOTS
    print -deps class19_11_13.eps
end
