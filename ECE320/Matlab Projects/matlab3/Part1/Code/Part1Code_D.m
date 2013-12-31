%Part 1: Project 7.1, parts (d)

%======================================
%Repeat (a)-(c) for omega_0 = 2pi(1500)
%======================================

Omega_0 = 2*pi*1500;
T= 1/8192;
n=0:8191;
t=n*T;
x = sin(Omega_0*t); % x(t)
x_discrete = sin(Omega_0*n*T); % x[n]


figure(1)
subplot(211)
stem(n,x_discrete)%x[n]
title('Project 7.1, Part(d) : \Omega_0 = 2 \pi (1500)')
xlim([0 49]); %first fifty samples
xlabel('time samples')
ylabel('x[t] = sin(\Omega_0nT)')

subplot(212)
plot(n,x)
xlim([0 49]); %first fifty samples
xlabel('time samples')
ylabel('x(t) = sin(\Omega_0t)')

if FINALPLOTS
    print -deps proj71PartD1.eps
end

[X,f]=ctfts(x,T);

figure(2)
plot(f,abs(X))
title('Project 7.1, Part(d): \Omega_0 = 2 \pi (1500)')
xlabel('time samples')
ylabel('x_r(t)  (CTFT)')


if FINALPLOTS
    print -deps proj71PartD2.eps
end

%======================================
%Repeat (a)-(c) for omega_0 = 2pi(2000)
%======================================

Omega_0 = 2*pi*2000;
x = sin(Omega_0*t); % x(t)
x_discrete = sin(Omega_0*n*T); % x[n]


figure(3)
subplot(211)
stem(n,x_discrete)%x[n]
title('Project 7.1, Part(d) : \Omega_0 = 2 \pi (2000)')
xlim([0 49]); %first fifty samples
xlabel('time samples')
ylabel('x[t] = sin(\Omega_0nT)')

subplot(212)
plot(n,x)
xlim([0 49]); %first fifty samples
xlabel('time samples')
ylabel('x(t) = sin(\Omega_0t)')

if FINALPLOTS
    print -deps proj71PartD3.eps
end

[X,f]=ctfts(x,T);

figure(4)
plot(f,abs(X))
title('Project 7.1, Part(d): \Omega_0 = 2 \pi (2000)')
xlabel('time samples')
ylabel('x_r(t)  (CTFT)')


if FINALPLOTS
    print -deps proj71PartD4.eps
end
