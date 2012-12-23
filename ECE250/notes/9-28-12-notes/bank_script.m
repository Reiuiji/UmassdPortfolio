%matlab example #2
clc
format bank
F=1000000; r=0.0485;
y=10:30;
M=P.*(r/12)./(1+r/12).^(-12.*y);
T=M*12.*y;
Table=[y' M' T'];
disp('      Years       Monthly pay     Total Pay')
disp(table)