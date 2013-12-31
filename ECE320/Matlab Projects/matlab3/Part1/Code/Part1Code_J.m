%Part 1: Project 7.1, parts (j)

Omega_0 = 2*pi*(3000);

%Based on matlab3.pdf infomation
beta = 2*pi*(2000);

%Omega_s=2*pi*(8192)
T= 1/8192;
n=0:8191*10;%increase the capture length by 10 seconds
t=n*T;

x = sin(Omega_0*t + (1/2)*beta*t.^2);

sound(x,1/T)
