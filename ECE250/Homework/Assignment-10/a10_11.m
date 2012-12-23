t = 0:1:50;
v = 0:1:70;
[V T] = meshgrid(v,t);
T_wc = 35.74 + 0.6215.*T - 35.75.*V.^0.16 + 0.4275.*V.^0.16;
surf(V,T,T_wc)
 xlabel('v'); ylabel('T'); zlabel('T_wc');
