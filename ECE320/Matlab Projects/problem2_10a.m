%Daniel Noyes
%Group 11
%Problem 2.10 (a)

load lineup.mat;
N = 1000;
a = 0.5;

a1 = 1;
b = [1, zeros(1,N-1-length(a)), a];

he = filter(b,a1);
nhe = he(1:N)';
n = 1:N;
stem(n,nhe)
title('Impluse response of the echo system')
xlabel('Time (samples)')
ylabel('he[n]')