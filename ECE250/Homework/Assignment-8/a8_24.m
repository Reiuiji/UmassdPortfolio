function [b,m] = powerfit(x,y)
z=polyfit(log(x),log(y),1);
m=z(1)
b=exp(z(2))
y_1=b*x.^m;

hold on
plot(x,y,'+');
plot(x,y_1)
xlabel('x')
ylabel('y')