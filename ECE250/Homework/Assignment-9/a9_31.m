dy_dt=@(t,y) 80*exp(-1.6*t)*cos(4*t) - 0.4*y;
[t y] = ode45(dy_dt, 0:0.05:4, 0);
plot(t,y);
grid on
xlabel('t');
ylabel('y');
