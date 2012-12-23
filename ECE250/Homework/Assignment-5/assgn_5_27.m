V_D=0:0.01:5;
I_O=1E-14;
V_S=1.5;
R=1200;
KTQ=0.03;
I_D1=I_O*(exp(V_D/KTQ)-1);
I_D2=(V_S-V_D)/R;
plot(V_D,I_D1,V_D,I_D2,'--r');
xlabel('V_D');
ylabel('I_D (amp''s)');
title('I_D vs. V_D');
legend('I_D1','I_D2');
axis([0 2 0 0.001]);
grid on;

%intersection is V_D=0.75 and I_D=0.000625