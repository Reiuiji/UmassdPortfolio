%Part 2: Buck, Daniel, & Singer, Project 6.3, parts (a)
N = 1024;
load protoh

%[H omega] = freqz(h,1,N);
[H omega] = freqz(h,1,N);

%calculate Hid
Hid = (abs(omega) < pi/5);
figure(1)
subplot(211)
plot(omega/pi,abs(H))
title('Project 6.3, Part(a)')
xlabel('Freq (omega/pi)')
ylabel('abs(H)')
subplot(212)

n = -(length(h)-mod(length(h),2))/2:(length(h)-mod(length(h),2))/2;
stem(n,h)
xlabel('omega')
ylabel('Hid')

if FINALPLOTS
    print -deps proj63PartA.eps
end