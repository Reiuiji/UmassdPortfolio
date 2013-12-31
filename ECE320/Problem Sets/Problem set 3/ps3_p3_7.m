%Daniel Noyes
%Group 11
%Problem Set 3, 3.7

a = [1 1/2 1/8];
b = [1 0 2];
n = 0:100;
delta = (n == 0);
%y = impz(b,a,n);
y = filter(b,a,delta);
stem(n,y)
xlim([0 100]);
title('y[n] = h[n]*x[n]');
xlabel('Time (samples)');
ylabel('y[n]');