%Daniel Noyes
%Group 11
%Problem 2.10 (c)

disp('Problem 2.10(c)')

load lineup.mat;
N = 1000;
a = 0.5;

b = [1, zeros(1,N-1-length(a)), a];
d = [1, zeros(1,4000)];
her = filter(1,b,d);

stem(her)
title('Impluse response using filter')
xlabel('Time (samples)')
ylabel('her[n]')
