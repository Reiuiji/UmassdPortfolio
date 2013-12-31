n = [-5:15];
x1 = (n >= 0);
x2 = (n >= 7);
x = x1-x2;
figure('name','Problem 2.7');
subplot(3,1,1);
stem(n,x);
title('x[n] = u[n]-u[n-7]');
xlabel('n (samples)');
ylabel('x[n]');

h = 2*(n == 0)+(n == 1)-(n==2)-2*(n==3);
subplot(3,1,2);
stem(n,h);
title('h[n] = 2\delta[n]+\delta[n-1]-\delta[n-2]-2\delta[n-3]');
xlabel('n (samples)');
ylabel('x[n]');

ny = [-10:30];
y = conv(h,x);
subplot(3,1,3);
stem(ny,y);
title('y[n] = x[n]*h[n]');
xlabel('n (samples)');
ylabel('y[n]');
