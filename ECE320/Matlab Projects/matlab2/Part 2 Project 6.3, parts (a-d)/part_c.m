%Part 2: Buck, Daniel, & Singer, Project 6.3, parts (c)
N = 1024;
load protoh


%calculate Hi
Hi = h.*2.*cos((pi/2).*n);

[H omega] = freqz(Hi,1,N);
figure(1)
subplot(211)
plot(omega/pi,abs(H))
title('Project 6.3, Part(b)')
xlabel('Freq (omega/pi)')
ylabel('abs(Hi)')
subplot(212)

n = -(length(h)-mod(length(h),2))/2:(length(h)-mod(length(h),2))/2;
stem(n,Hi)
xlabel('omega')
ylabel('Hid')
if FINALPLOTS
    print -deps proj63PartC.eps
end