x = [-5:0.1:4];
p = [-0.4 0 7 -20.5 -28];
y = polyval(p,x);
plot(x,y)
xlabel('x')
ylabel('y')