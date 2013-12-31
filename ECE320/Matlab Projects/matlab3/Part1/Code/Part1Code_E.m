%Part 1: Project 7.1, parts (e)

Omega_0_1 = 2*pi*1500;
Omega_0_2 = 2*pi*2000;
T= 1/8192;
n=0:8191;
t=n*T;
x1 = sin(Omega_0_1*t); % x1(t)
x2 = sin(Omega_0_2*t); % x2(t)

sound(x1,1/T)
sound(x2,1/T)
