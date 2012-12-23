%Part A
x=sym('x');
S = 4*sin(x)*cos(x) - 8*sin(x)^3*cos(x)
simplify(S)

%Part B
x=sym('x');
y=sym('y');
S=(1/2)*(cos(x-y)+cos(x+y))
simplify(S)
