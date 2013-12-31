%Daniel Noyes
%Group 11
%Problem 2.10 (e)

disp('Problem 2.10(e)')

load lineup.mat;
N = 1000;
alpha = 0.5;

he = [1, zeros(1,N-1-length(alpha)), alpha];

a = [1, zeros(1,N-1-length(alpha)), alpha];
d = [1, zeros(1,4000)];
her = filter(1,a,d);

hoa = conv(he,her);
figure(1)
plot(hoa)
title('Convolving he with her')
xlabel('Time')
ylabel('hoa')

