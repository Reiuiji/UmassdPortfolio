%This is a script that will calculate the charges of point p
%Based on the Charge
%Reiuiji - 10-6-12
format SHORTENG
Q1=input('Enter the Charge of Q1 in C(2.4E-6): ');
% Q1=2.4E-6;
Q1x=input('Enter the X component of Q1 in m(0E-2): ');
% Q1x=0;
Q1y=input('Enter the y component of Q1 in m(-3.5E-2): ');
% Q1y=-3.5E-2;
Q2=input('Enter the Charge of Q2 in C(6.8E-6): ');
% Q2=6.8E-6;
Q2x=input('Enter the X component of Q2 in m(0E-2): ');
% Q2x=0;
Q2y=input('Enter the y component of Q2 in m(3.5E-2): ');
% Q2y=3.5E-2;
Px=input('Enter the X component of Point P in m(6E-2): ');
% Px=6E-2;
Py=input('Enter the y component of Point P in m(0): ');
% Py=0;

%Calculate the difference between points
Q1x_Px=Px-Q1x;
Q1y_Py=Py-Q1y;
Q2x_Px=Px-Q2x;
Q2y_Py=Py-Q2y;

%Calculate the magnitude
R_Q1_P=sqrt(Q1x_Px^2+Q1y_Py^2);
R_Q2_P=sqrt(Q2x_Px^2+Q2y_Py^2);

%Calculate R^hat
R_hat_Q1x_P=Q1x_Px/R_Q1_P;
R_hat_Q1y_P=Q1y_Py/R_Q1_P;
R_hat_Q2x_P=Q2x_Px/R_Q2_P;
R_hat_Q2y_P=Q2y_Py/R_Q2_P;

%Calculate the electric field
K=8.99E9;
Ep_Q1_P=(K*Q1)/(R_Q1_P)^2;
Ep_Q2_P=(K*Q2)/R_Q2_P^2;

Ex_Q1_P=Ep_Q1_P*R_hat_Q1x_P;
Ey_Q1_P=Ep_Q1_P*R_hat_Q1y_P;
Ex_Q2_P=Ep_Q2_P*R_hat_Q2x_P;
Ey_Q2_P=Ep_Q2_P*R_hat_Q2y_P;

%Calculate The resultant
E_Rx=Ex_Q1_P+Ex_Q2_P;
E_Ry=Ey_Q1_P+Ey_Q2_P;

%calculate the Magnitude
E_Mag_P_Q1=sqrt((Ex_Q1_P)^2+(Ey_Q1_P)^2);
E_Mag_P_Q2=sqrt(E_Rx^2+E_Ry^2);

%angle of the resultant
theta=atand(E_Ry/E_Rx);

F=E_Mag_P_Q2*(1.6E-19);

%print the data
fprintf('\n\n Magnitude of point P due to Q1 alone: %5.3e\n',E_Mag_P_Q1);
fprintf('x-component total electric field at P: %5.3e\n',E_Rx);
fprintf('y-component total electric field at P: %5.3e\n',E_Ry);
fprintf('magnitude of the total electric field at P: %5.3e\n',E_Mag_P_Q2);
fprintf('angle of Total electric field at P: %5.2f deg\n',theta);
fprintf('magnitude of the force on an electron placed at P: %5.3e \n',F);
fprintf('\n\n\n');


