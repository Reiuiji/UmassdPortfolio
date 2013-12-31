%Part 2: Project 6.3, parts (b)
N = 1024;
load protoh

%calculate h1
h1 = h.*(exp(1j.*pi.*n));
[H1 omega] = freqz(h1,1,N);

figure(1)
subplot(211)
plot(omega/pi,abs(H1))
title('Project 6.3, Part(b): Frequency Response | highpass filter')
xlabel('Freq (omega/pi)')
ylabel('|H|')

subplot(212)
n = -(length(h)-mod(length(h),2))/2:(length(h)-mod(length(h),2))/2;
stem(n,h1)
title('Project 6.3, Part(b): Impulse Response for a highpass filter')
xlabel('omega')
ylabel('H_{hpf}(e^{jw})')

if FINALPLOTS
    print -deps proj63PartB.eps
end
