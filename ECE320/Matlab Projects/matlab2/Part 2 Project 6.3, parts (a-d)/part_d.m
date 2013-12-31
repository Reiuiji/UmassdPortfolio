%Part 2: Buck, Daniel, & Singer, Project 6.3, parts (d)
N = 1024;
load protoh


%impulse
n = -(length(h)-mod(length(h),2))/2:(length(h)-mod(length(h),2))/2;
I = imp(n);
Hi = h.*2.*cos((pi/2).*n);

Hii =I - Hi ;

[H omega] = freqz(Hii,1,N);
figure(1)
subplot(211)
plot(omega/pi,abs(H))
title('Project 6.3, Part(b)')
xlabel('Freq (omega/pi)')
ylabel('abs(Hi)')
subplot(212)


stem(n,Hii)
xlabel('omega')
ylabel('Hid')

if FINALPLOTS
    print -deps proj63PartD.eps
end