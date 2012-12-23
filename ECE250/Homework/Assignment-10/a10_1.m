t=0:0.1:30;
x = (4-0.1*t).*sin(0.8.*t);
y = (4-0.1*t).*cos(0.8.*t);
z = 0.4.*t.^(3/2);
plot3(x,y,z);
grid on
xlabel('x'); ylabel('y'); zlabel('z');
