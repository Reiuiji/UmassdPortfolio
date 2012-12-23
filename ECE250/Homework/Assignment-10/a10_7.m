x = -pi:0.11:pi; %Dont know why but graph flip if inc is 0.1 so set to 0.11
y = -pi:0.11:pi;
[X Y] = meshgrid(x,y);
Z = cos(X*Y).*cos(sqrt(X.^2+Y.^2));
surf(X,Y,Z)
xlabel('x'); ylabel('y'); zlabel('z');
