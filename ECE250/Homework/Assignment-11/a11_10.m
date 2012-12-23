%Part a
syms x y;
S_1=(x-1)^2/6^3 + y^2/3^2 - 1
S_2=(x+2)^2/2^2 + (y-5)^2/4^2 - 1
ezplot(S_1,[-15,15])
hold on
ezplot(S_2,[-15,15])
grid on

%Part b
[x,y]=solve(S_1,S_2);
double([x,y])
