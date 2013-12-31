%Daniel Noyes
%Group 11
%Problem 2.7 (a)

%Problem(a)
disp('Problem (a)')

len = 10;

n = -len:len;
x = (n == 0) + (n == 2);

h = 2*(n == -1) - 2*(n == 1);

%y = x*h;
y = conv(x,h);

ny = -(len*2):(len*2);
figure(1);
stem(ny,y)
title('y[n] = h[n]*x[n]');
xlabel('n (samples)');
ylabel('y[n]');

