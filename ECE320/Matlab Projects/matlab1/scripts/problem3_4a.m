%Daniel Noyes
%Group 11
%Problem 3.4 (a)

disp('Problem 3.4(a)')

n = -20:100;
x1 = exp(j*(pi/4)*n);
x2 = sin(n*(pi/8) + pi/16);
x3 = (9/10).^n;
x4 = n+1;

figure(1)
subplot(211)
stem(n,real(x1));
title('real part for X1 [exp(j*(pi/4)*n)]')
xlabel('Time')
ylabel('imag x1')

subplot(212)
stem(n,imag(x1));
title('Imaginary part of X1[exp(j*(pi/4)*n)]')
xlabel('Time')
ylabel('imag x1')

figure(2)
stem(n,x2);
title('Signal of X2 [sin(n*(pi/8) + pi/16)]')
xlabel('Time')
ylabel('X2[n]')

figure(3)
stem(n,x3);
title('Signal of X3 [(9/10).^n]')
xlabel('Time')
ylabel('X3[n]')

figure(4)
stem(n,x4);
title('Signal of X4 [n+1]')
xlabel('Time')
ylabel('X4[n]')

