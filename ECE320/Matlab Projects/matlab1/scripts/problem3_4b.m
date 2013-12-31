%Daniel Noyes
%Group 11
%Problem 3.4 (b)

disp('Problem 3.4(b)')

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



figure(1)
subplot(211)
stem(n,real(y1));
title('Filtered Signal of real part for Y1')
xlabel('Time')
ylabel('imag x1')

subplot(212)
stem(n,imag(y1));
title('Filtered Signal of Imaginary part of Y1')
xlabel('Time')
ylabel('imag x1')

figure(2)
stem(n,y2);
title('Filtered Signal of Y2')
xlabel('Time')
ylabel('X2[n]')

figure(3)
stem(n,y3);
title('Filtered Signal of Y3')
xlabel('Time')
ylabel('X3[n]')

figure(4)
stem(n,y4);
title('Filtered Signal of Y4')
xlabel('Time')
ylabel('X4[n]')

