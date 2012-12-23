x = -2:0.1:2;
y = -2:0.1:2;
[X,Y] = meshgrid(x,y);
Z = 0.5.*abs(X) + abs(Y).*0.5;
surf(X,Y,Z)
grid on
xlabel('x'); ylabel('y'); zlabel('z');
