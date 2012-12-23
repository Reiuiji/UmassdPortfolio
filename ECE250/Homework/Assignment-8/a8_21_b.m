x = [1750:50:1950 1990 2000 2009];
y = [791 980 1260 1650 2520 5270 6060 6800];
p=polyfit(x,y,3);
x_1=1750:10:2050;
y_1=p(1)*x_1.^3 + p(2)*x_1.^2 + p(3)*x_1+p(4);

plot(x,y,'+')
hold on
plot(x_1,y_1);
xlabel('year')
ylabel('population')

z=p(1)*1980^3 + p(2)*1980^2 + p(3)*1980+p(4);
fprintf('the populaion in 1980: %6.2f\n',z);