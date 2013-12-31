%Daniel Noyes
%Group 11
%Problem 2.7 (b)

%Problem(a)
disp('Problem (b)')
%N = 10;
%M = 20;
N = input('Enter N:');
M = input('Enter M:');
a = 0;
b = N - 1;
c = 0;
d = M - 1;

nh = a:b;
nx = c:d;

h = imp(nh - a) + imp(nh - b);
x = imp(nx - c) + imp(nx - d);

figure(1);
subplot(211)
stem(nx,x)
title('Input Signal for Problem 2.7b');
xlabel('Time (samples)');
ylabel('x[n]');

subplot(212)
stem(nh,h)
title('Impulse response for Problem 2.7b');
xlabel('Time (samples)');
ylabel('h[n]');


%find the convolution
y = conv(h,x);
disp('y length')
length(y)
ny = (a+c): (b+d);

figure(2);
stem(ny,y)
title('y[n] = h[n]*x[n]');
xlabel('Time (samples)');
ylabel('y[n]');
