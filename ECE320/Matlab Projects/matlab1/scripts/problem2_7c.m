%Daniel Noyes
%Group 11
%Problem 2.7 (c)

%Problem(c)
disp('Problem (c)')

a = 0;
b = 24;
c = -2;
d = 14;

nx = a:b;
nh = c:d;

x = (1/2).^(nx - 2) .* Heaviside(nx -2);
h = Heaviside(nh+2);

figure(1);
subplot(211)
stem(nx,x)
title('Input Signal for Problem 2.7c');
xlabel('Time (samples)');
ylabel('x[n]');

subplot(212)
stem(nh,h)
title('Impulse response for Problem 2.7c');
xlabel('Time (samples)');
ylabel('h[n]');


%find the convolution
y = conv(h,x);
ny = (a+c): (b+d);

figure(2);
stem(ny,y)
title('y[n] = h[n]*x[n]');
xlabel('Time (samples)');
ylabel('y[n]');
