x = [1750:50:1950 1990 2000 2009];
y = [791 980 1260 1650 2520 5270 6060 6800];

x_1=1750:10:2050;
y_1=interp1(x,y,x_1, 'linear');
y_2=interp1(x,y,x_1, 'spline');

fprintf('the populaion in 1975:\n %6.2f[linear] \n %6.2f[spline]\n',interp1(x,y,1975, 'linear'), interp1(x,y,1975, 'spline'));

plot(x,y,'+')
hold on
plot(x_1,y_1);
plot(x_1,y_2);
xlabel('year')
ylabel('population')
