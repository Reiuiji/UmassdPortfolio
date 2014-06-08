%ECE 321
%Class Activity 13
%
% Group Members
%    Daniel Noyes
%    Jenny Doan

%Part a
w = -2*pi:0.1:2*pi;
T1= 2;
x = (2.*sin(w*T1))./w;
xa = abs(x);
ang = angle(x);

%plot of the signal
subplot(3,1,1);
plot(w,x);
title('Plot of 2sin(w*T1)/w')
xlabel('(x)')
ylabel('(y)')
grid

%abs plots
subplot(3,1,2);
plot(w,xa);
title('Plot of |2sin(w*T1)/w|')
xlabel('(x)')
ylabel('(y)')
grid
%angle plot
subplot(3,1,3);
plot(w,ang);
title('angle of 2sin(w*T1)/w')
xlabel('(x)')
ylabel('(y)')
%Print to a png image
print('-dpng','-r100', 'classactivity-13-1.png')

%Part b
w2 = -2*pi:0.1:2*pi;
x2 = exp(-1i*w2-8)./(1i*w2);
xa2 = abs(x2);
ang2 = angle(x2);

figure(2)
%plots of the signal
subplot(3,1,1);
plot(w2,x2);
title('Plot of e^{-4t}u(t-2)')
xlabel('(x)')
ylabel('(y)')
grid

%abs plots
subplot(3,1,2);
plot(w2,xa2);
title('Plot of |e^{-4t}u(t-2)|')
xlabel('(x)')
ylabel('(y)')
grid
%angle plot
subplot(3,1,3);
plot(w2,ang2);
title('angle of e^{-4t}u(t-2)')
xlabel('(x)')
ylabel('(y)')
%Print to a png image
print('-dpng','-r100', 'classactivity-13-2.png')
