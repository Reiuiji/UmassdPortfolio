%Part 2: Project 6.3, parts (c)
N = 1024;
load protoh

%calculate h2
h2 = h.*2.*cos((pi/2).*n);
[H2 omega] = freqz(h2,1,N);

figure(1)
subplot(211)
plot(omega/pi,abs(H2))
title('Project 6.3, Part(c): Frequency Response | ideal bandpass filter')
xlabel('Freq (\omega/\Pi)')
ylabel('|H|')

subplot(212)
n = -(length(h)-mod(length(h),2))/2:(length(h)-mod(length(h),2))/2;
stem(n,h2)
title('Project 6.3, Part(c): Impulse Response for a ideal bandpass filter')
xlabel('\omega')
ylabel('H_{bpf}(e^{jw})')

if FINALPLOTS
    print -deps proj63PartC.eps
end