%Daniel Noyes
%Group 11
%Problem 2.7 (e)

%Problem(e)
disp('Problem (e)')

L = 50;
n = 0:99;

x = cos(n.^2).*sin(2*pi.*n/5).*Heaviside(n);
h = (0.9).^(n) .*(Heaviside(n) - Heaviside(n-10));

x0 = x(1:L);
x1 = x(L+1:2*L);

n0 = n(1:L);
n1 = n(L+1:2*L);


figure(1);
subplot(211)
stem(n,x)
title('Input Signal for Problem 2.7e');
xlabel('Time (samples)');
ylabel('x[n]');

subplot(212)
stem(n,h)
title('Impulse response for Problem 2.7e');
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

%seperated finite-length impulse

figure(3);
subplot(211)
stem(n0,x0)
title('Input Signal x0 for Problem 2.7e');
xlabel('Time (samples)');
ylabel('x[n]');

subplot(212)
stem(n1,x1)
title('Input Signal x1 for Problem 2.7e');
xlabel('Time (samples)');
ylabel('h[n]');


%find the convolution of the seperate parts and add them together
y0 = conv(h,x0);
ny0 = n0(1): (n0(end)*2+L);

y1 = conv(h,x1);
ny1 = n1(1): (n1(end)*2);


nyy = ny0(1)*2: ny1(end);
yy = zeros(1, length(nyy));

%go through and add all the data together
for i = 1: length(yy)
    
if(i <= L)
    yy(i) = y0(i);
else
    if(i < length(y0))
        yy(i) = y0(i) + y1(i-L);
    else
        yy(i) = y1(i-L);
    end
end

end

figure(4);
subplot(211)
stem(ny0,y0)
title('y0[n] = h[n]*x0[n]');
xlabel('Time (samples)');
ylabel('y[n]');

subplot(212)
stem(ny1,y1)
title('y1[n] = h[n]*x1[n]');
xlabel('Time (samples)');
ylabel('y[n]');

figure(5)
stem(nyy,yy)
xlim([0 99]);
title('y[n] = y0[n] + y1[n]');
xlabel('Time (samples)');
ylabel('y[n]');

