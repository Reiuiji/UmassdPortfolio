syms x y;
S = (x^4 - 2*y)/(2*x)
y1=dsolve('Dy=(x^4 - 2*y)/(2*x)','x')
A=diff(y1)
B=subs(S,y,A)
simplify(B)
