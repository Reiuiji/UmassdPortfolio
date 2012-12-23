%Part A
C = 15E-6; L = 240E-3; V_m = 24;
f = 60:0.5:110;
r = 10:0.5:40;
[F,R] = meshgrid(f,r);
W_d = 2*pi*F;
I = V_m./sqrt(R.^2 + (W_d.*L - 1./(W_d*C)).^2);
mesh(F,R,I)
xlabel('f'); ylabel('r'); zlabel('I');

%Part B
view(0,0)
1/(2*pi*sqrt(L.*C))

