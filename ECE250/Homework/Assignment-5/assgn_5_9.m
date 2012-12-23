%vertical asymtopes: -2,3
axis([-6 6 -20 20]);
xlabel('x');
ylabel('y');
title('f(x)');
hold on
%set the first section -6:-2
x=linspace(-6,-2.01,100);
y=(x.^2-(4*x)-7)./((x.^2)-x-6);
plot(x,y);

%set the first section -2:3
x=linspace(-1.99,2.99,100);
y=(x.^2-(4*x)-7)./((x.^2)-x-6);
plot(x,y);

%set the first section 3:6
x=linspace(3.01,6,100);
y=(x.^2-(4*x)-7)./((x.^2)-x-6);
plot(x,y);