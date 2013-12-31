%Part 2: Project 6.3, parts (a)
N = 1024;
load protoh

%[H omega] = freqz(h,1,N);
[H omega] = freqz(h,1,N);

%calculate Hid
Hid = (abs(omega) < pi/5);
figure(1)
subplot(211)
plot(omega/pi,abs(H))
title('Project 6.3, Part(a): Frequency Response')
xlabel('Freq (\omega/\Pi)')
ylabel('|H|')
subplot(212)

n = -(length(h)-mod(length(h),2))/2:(length(h)-mod(length(h),2))/2;
stem(n,h)
title('Project 6.3, Part(a): Impulse Response')
xlabel('\omega')
ylabel('Hid(e^{jw})')

if FINALPLOTS
    print -deps proj63PartA.eps
end
