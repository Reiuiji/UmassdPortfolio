xlabel('x');
ylabel('y');
title('f(x)');
hold on

x=-pi:pi/100:pi;
y=cos(x).*sin(2*x);
dy=(2.*cos(x).*cos(2.*x))-(sin(2.*x).*sin(x));

plot(x,y,'-b');
plot(x,dy,'--r');

legend('y','dy/dx');
hold off