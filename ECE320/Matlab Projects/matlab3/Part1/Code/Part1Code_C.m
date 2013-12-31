%Part 1: Project 7.1, parts (c)

%Part A
Omega_0 = 2*pi*1000;
T= 1/8192;
n=0:8191;
t=n*T;
x = sin(Omega_0*t); % x(t)

%Part C
[X,f]=ctfts(x,T);

figure(1)

plot(f,abs(X))
title('Project 7.1, Part(c)')
xlabel('time samples')
ylabel('x_r(t)  (CTFT)')


if FINALPLOTS
    print -deps proj71PartC.eps
end
