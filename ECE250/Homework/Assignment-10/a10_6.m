x = -10:0.25:10;
y = -10:0.25:10;
[X,Y] = meshgrid(x,y);
R = sqrt(X.^2 + Y.^2);
Z = sin(R)./R;
mesh(X,Y,Z)
