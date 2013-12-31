%Daniel Noyes
%Group 11
%Problem 2.10 (d)

disp('Problem 2.10(d)')

load lineup.mat;
N = 1000;
alpha = 0.5;

a = [1, zeros(1,N-1-length(alpha)), alpha];
d = [1, zeros(1,4000)];
her = filter(1,a,d);

z = filter(1,a,y);

figure(1)
plot(z)
title('Echo removed system')
xlabel('Time')
ylabel('z')

sound(z,8192)
