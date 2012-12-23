V=12;
R2=120;
R3=250;
R4=250;
%A
R1=0:500;
V_AB=V*(R2./(R1+R2)-R4./(R3+R4));
subplot(2,1,1);
plot(R1,V_AB,'r');
xlabel('R\rm_1');
ylabel('V_AB');
title('V_AB versus R 1 for 0 <= R 1 <= 500 \Omega , given R 2 = 120 ?');

%B
R1=120;
R2=0:500;
V_AB=V*(R2./(R1+R2)-R4./(R3+R4));
subplot(2,1,2);
plot(R2,V_AB);
xlabel('R\rm_1');
ylabel('V_AB');
title('V_AB versus R 2 for 0 <= R 2 <= 500 \Omega , given R 1 = 120 ? .');
