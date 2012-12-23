t = [1 3 4 7 8 10];
p = [2.1 4.6 5.4 6.1 6.4 6.6];
x = polyfit(t,t./p,1);
m = 1/x(1)
b = x(2)*m
plot(t,p,'+')
t_1=1:10;
p_1=m*t_1./(b+t_1);
hold on
plot(t_1,p_1);
xlabel('t')
ylabel('p')
