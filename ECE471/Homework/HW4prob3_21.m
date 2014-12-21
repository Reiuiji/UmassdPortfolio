% Daniel Noyes
% HW4: 3.21
mu = 0.75;
Ac = 50;
fm = 1;
fc = 10;
t=-1:0.01:1;
figure

%a.)
phase = 0;
S = Ac.*(1+mu.*cos(2.*pi.*fm.*t)).*cos(2.*pi.*fc.*t + phase);
subplot(2,2,1)
plot(S)
title('a) Phase 0')

%b.)
phase = 45;
S = Ac.*(1+mu.*cos(2.*pi.*fm.*t)).*cos(2.*pi.*fc.*t + phase);
subplot(2,2,2)
plot(S)
title('b) Phase 45')

%c.)
phase = 90;
S = Ac.*(1+mu.*cos(2.*pi.*fm.*t)).*cos(2.*pi.*fc.*t + phase);
subplot(2,2,3)
plot(S)
title('c) Phase 90')

%d.)
phase = 135;
S = Ac.*(1+mu.*cos(2.*pi.*fm.*t)).*cos(2.*pi.*fc.*t + phase);
subplot(2,2,4)
plot(S)
title('d) Phase 135')