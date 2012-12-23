x=sym('x');
S_1 = x^2*(x-6)+4*(3*x-2)
S_2=(x+2)^2-8*x
a=S_1*S_2
b=S_1/S_2
c=S_1+S_2
subs(c,x,5)
