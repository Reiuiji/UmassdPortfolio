x=sym('x');
y=sym('y');
S=x+sqrt(x)*y^2 +y^4;
T=sqrt(x)-y^2;
S*T
subs(S*T,{x,y},{9,2})

