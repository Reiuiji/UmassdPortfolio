%Part 1: Project 7.1, parts (f)
function Part1Code_F(freq, FINALPLOTS)
%
% This will do both Part A and C for Part F
% freq: what frequency will Omega_0 be based on 2*pi*freq
% FINALPLOTS: bool wheter to print out the graphs
%

%Part A
Omega_0 = 2*pi*freq;
T= 1/8192;
n=0:8191;
t=n*T;
x = sin(Omega_0*t); % x(t)

%Part C
[X,f]=ctfts(x,T);

figure(1)

plot(f,abs(X))
title(['Project 7.1, Part(F) | \Omega_o = 2\pi*(' num2str(freq) ')' ])
xlabel('time samples')
ylabel('x_r(t)  (CTFT)')

 output = sprintf('proj71PartF-%i.eps', freq);

if FINALPLOTS
    print('-deps', output)
end

%play the freq
sound(x,1/T)
