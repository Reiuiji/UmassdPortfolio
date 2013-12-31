%Daniel Noyes
%Group 11
%Problem 2.7 (d)

%Problem(d)
disp('Problem (d)')

n = 0:99;

x = cos(n.^2).*sin(2*pi.*n/5).*Heaviside(n);
h = (0.9).^(n) .*(Heaviside(n) - Heaviside(n-10));

figure(1);
subplot(211)
stem(n,x)
title('Input Signal for Problem 2.7d');
xlabel('Time (samples)');
ylabel('x[n]');

subplot(212)
stem(n,h)
title('Impulse response for Problem 2.7d');
xlabel('Time (samples)');
ylabel('h[n]');


%find the convolution
y = conv(h,x);
ny = n(1)*2: n(end)*2;

figure(2);
stem(ny,y)
xlim([n(1) n(end)]);
title('y[n] = h[n]*x[n]');
xlabel('Time (samples)');
ylabel('y[n]');
