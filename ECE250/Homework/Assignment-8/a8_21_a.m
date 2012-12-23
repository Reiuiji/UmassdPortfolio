x = [1750:50:1950 1990 2000 2009];
y = [791 980 1260 1650 2520 5270 6060 6800];
p=polyfit(x,log(y),1);
x_1=1750:10:2050;
y_1=exp(p(1)*x_1+p(2));

plot(x,y,'+')
hold on
plot(x_1,y_1);
xlabel('year')
ylabel('population')

z=exp(p(1)*1980 + p(2));
fprintf('the populaion in 1980: %6.2f\n',z);