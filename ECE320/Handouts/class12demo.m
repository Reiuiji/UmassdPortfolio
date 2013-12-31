% ECE 320
% Class 12 Demo Matlab file
% John Buck

% This file makes an FIR LPF by truncating the sinc function and
% shifting it to make it causal. 

M = 100;
L = M/2
nh = 0:M;
h = 0.5*sinc(0.5*(nh-L));

figure(1)
stem(nh,h)
xlabel('Time (samples)')
ylabel('h[n]')
axis([0 M -0.5 0.5]);
title('Impulse response of FIR LPF with cutoff \pi/2')

% Now find the frequency response
[H,omega] = freqz(h,1,8192);

figure(2)
plot(omega/pi,abs(H))
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Frequency response of FIR LPF with cutoff \pi/2')

% Now make detailed plots zooming in on passband and stopband
figure(3)
subplot(211)
plot(omega/pi,abs(H))
% need to change the next line if you have a different passband 
axis([0 0.5 0.9 1.1])  
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Passband detail for FIR LPF Frequency response')
subplot(212)
plot(omega/pi,abs(H))
% need to change the next line if you have a different stopband
axis([0.5 1 0 0.1])  
xlabel('Frequency (\omega/\pi)')
ylabel('|H(e^{j\omega})|')
title('Stopband detail for FIR LPF Frequency response')
