%Daniel Noyes
%Group 11
%Problem 3.4 (c)

disp('Problem 3.4(c)')

n = -20:100;
x1 = exp(j*(pi/4)*n);
x2 = sin(n*(pi/8) + pi/16);
x3 = (9/10).^n;
x4 = n+1;

a = [1 -0.25];
b = [1 0.9];

%calculate the y function from the constant-coefficient edifference equation
y1 = filter(a,b,x1);
y2 = filter(a,b,x2);
y3 = filter(a,b,x3);
y4 = filter(a,b,x4);

h1 = y1./x1;
h2 = y2./x2;
h3 = y3./x3;
h4 = y4./x4;


figure(1)
subplot(211)
stem(n,real(h1));
title('Ratio of output to input sequence at each time index for real signal h1 = y1./x1')
xlabel('Time')
ylabel('imag h1')

subplot(212)
stem(n,imag(h1));
title('Ratio of output to input sequence at each time index for imaginary signal h1 = y1./x1')
xlabel('Time')
ylabel('imag h1')

figure(2)
stem(n,h2);
title('Ratio of output to input sequence at each time index for h2 = y2./x2')
xlabel('Time')
ylabel('h2[n]')

figure(3)
stem(n,h3);
title('Ratio of output to input sequence at each time index for h3 = y3./x3')
xlabel('Time')
ylabel('h3[n]')

figure(4)
stem(n,h4);
title('Ratio of output to input sequence at each time index for h4 = y4./x4')
xlabel('Time')
ylabel('h4[n]')

