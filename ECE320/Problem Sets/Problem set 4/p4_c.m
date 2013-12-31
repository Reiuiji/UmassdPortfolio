a = [1 -0.9 0.81];
b = [1 1 0];
[H,omega] = freqz(b,a,4096);

plot(omega,H)
grid on
title('Problem set 4(c)')
xlabel('\omega');
ylabel('H(e^jw)')
