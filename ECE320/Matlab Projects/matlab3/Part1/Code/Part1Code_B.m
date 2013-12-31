%Part 2: Project 7.1, parts (b)

%Sampling frequency is Omega_s = 2*pi*8192
%Part A
Omega_0 = 2*pi*1000;
T= 1/8192;
n=0:8191;
t=n*T;
x = sin(Omega_0*t); % x(t)
x_discrete = sin(Omega_0*n*T); % x[n]

%Part B
figure(1)

subplot(211)
stem(n,x_discrete)%x[n]
xlim([0 49]); %first fifty samples
title('Project 7.1, Part(b)')
xlabel('time samples')
ylabel('x[t] = sin(\Omega_0nT)')

subplot(212)
plot(n,x)
xlim([0 49]); %first fifty samples
xlabel('time samples')
ylabel('x(t) = sin(\Omega_0t)')

if FINALPLOTS
    print -deps proj71PartB.eps
end

