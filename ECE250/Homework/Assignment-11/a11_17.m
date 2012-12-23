syms x;
S = cos(x)^2/(1+sin(x)^2)
ezplot(S,[0,pi])
int(S,0,pi)
