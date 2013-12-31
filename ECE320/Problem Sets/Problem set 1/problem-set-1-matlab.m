n = [-5:20];
%problem 1
x1 = sin((pi/4)*n);
stem(n,x1)
%label graph
title('x1 = sin((pi/4)*n)')
xlabel('n (samples)')
ylabel('x[n]')


%%%%%%%%%

n = [-5:20];
%problem 2
x2 = sin((3*pi/4)*n);
stem(n,x2)
%label graph
title('x2 = sin((3*pi/4)*n)')
xlabel('n (samples)')
ylabel('x[n]')


%%%%%%%%%

n = [-5:20];
%problem 3
x3 = (4/5).^n.*n;
stem(n,x3)
%label graph
title('x3 = (4/5).^n.*n')
xlabel('n (samples)')
ylabel('x[n]')

%%%%%%%%%

n = [-5:20];
%problem 4
x4 = (4/5).^(n-2).*(n-2);
stem(n,x4)
%label graph
title('x4 = (4/5).^(n-2).*(n-2)')
xlabel('n (samples)')
ylabel('x[n]')

%%%%%%%%%

n = [-5:20];
%problem 5
x5 = (-3/4).^n.*n;
stem(n,x5)
%label graph
title('x5 = (-3/4).^n.*n')
xlabel('n (samples)')
ylabel('x[n]')
