x = -3:0.1:3;
y = -3:0.1:3;
k = 0.01;
[X,Y] = meshgrid(x,y);
w = k.*(X.^2 - Y.^2);
surf(X,Y,w)
xlabel('x'); ylabel('y'); zlabel('w');
