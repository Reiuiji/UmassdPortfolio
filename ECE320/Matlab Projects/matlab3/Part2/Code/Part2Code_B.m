%Proj 3 - Part 2 - Section (b)
Nfft = 10000; % 10 kHz
S = fft(s,Nfft);
omega = (0:(Nfft-1));

figure(1)
clf

plot(omega,fftshift(abs(S)));

grid on
xlabel('Frequency (Hz)')
ylabel('X(e^{j\omega})')
title('Project 3, Part 2, Section (b): Scrambled signal spectrum |X(e^{j\omega})|')


if FINALPLOTS
    print -deps Part2B.eps
end
