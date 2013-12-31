%Part 2: Project 6.3, parts (d)
N = 1024;
load protoh

%impulse
n = -(length(h)-mod(length(h),2))/2:(length(h)-mod(length(h),2))/2;
IMP = (n == 0);
h2 = h.*2.*cos((pi/2).*n);

h3 =IMP - h2 ;
[H omega] = freqz(h3,1,N);

figure(1)
subplot(211)
plot(omega/pi,abs(H))
title('Project 6.3, Part(d): Frequency Response | bandstop filter')
xlabel('Freq (omega/pi)')
ylabel('|H|')

subplot(212)
stem(n,h3)
title('Project 6.3, Part(d): Impulse Response for a bandstop filter')
xlabel('omega')
ylabel('H_{bsf}(e^{jw})')

if FINALPLOTS
    print -deps proj63PartD.eps
end