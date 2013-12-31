%Daniel Noyes
%Group 11
%Problem 2.10 (a)

disp('Problem 2.10(a)')

load lineup.mat;
N = 1000;
a = 0.5;

he = [1, zeros(1,N-1-length(a)), a];

stem(he)
title('Impluse response of the echo system')
xlabel('Time (samples)')
ylabel('he[n]')
