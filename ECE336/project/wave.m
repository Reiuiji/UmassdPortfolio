%ECE 336 Project
%(c) Daniel Noyes, MIT License
%function wave(n,m,mode)
%function [x,y,E_X,E_Y,E_Z,H_X,H_Y,H_Z] = wave(n,m,mode)
clear
close all

%INPUT
SID = input('Enter last 3 Digits of Student ID: ','s');
n = str2double(SID(1));
m = str2double(SID(2));
mode = str2double(SID(3));

%check if n or m are greater than 5
if n > 5
    n = n-5;
end
if m > 5
    m = m-5;
end

%Display the entered parameters
if mod(mode,2) == 0
    fprintf('(i) Mode: TE_MN\n');
else
    fprintf('(i) Mode: TM_MN\n');
end
fprintf('(ii)  m : %d\n',m);
fprintf('(iii) n : %d\n',n);


%Base Parameters
a = 4;
b = 2;
x = (0:a/400:a)';%transpose to make it WORK!
y = 0:b/200:b;

%Calculated Parameters
k  = 2*pi;
kx = (m*pi)/a;
ky = (n*pi)/b;
kc = sqrt(kx^2 + ky^2);
prop = kc/k;
theta = 90 - rad2deg(asin(prop));


if mod(mode,2) == 0
    %TE formulas
    E_X = cos(kx*x) * sin(ky*y);
    E_Y = sin(kx*x) * cos(ky*y);
    E_Z = 0;
    H_X = sin(kx*x) * cos(ky*y);
    H_Y = cos(kx*x) * sin(ky*y);
    H_Z = cos(kx*x) * cos(ky*y);

    % E_X = (1i*omega*MU*n*pi/(beta_c^2*b)) * A_mn * cos(m*pi*x/a) * sin(n*pi*y/b) * exp(-1i*beta_z*z);
    % E_Y = (-1i*omega*MU*m*pi/(beta_c^2*a)) * A_mn * sin(m*pi*x/a) * cos(n*pi*y/b) * exp(-1i*beta_z*z);
    % E_Z = 0;
    % H_X = (1i*beta_z*m*pi/(beta_c^2*a)) * A_mn * sin(m*pi*x/a) * cos(n*pi*y/b) * exp(-1i*beta_z*z);
    % H_Y = (1i*beta_z*n*pi/(beta_c^2*b)) * A_mn * cos(m*pi*x/a) * sin(n*pi*y/b) * exp(-1i*beta_z*z);
    % H_Z = A_mn * cos(m*pi*x/a) * cos(n*pi*y/b) * exp(-1i*beta_z*z);
    
else
    %TM formulas
    E_X = cos(kx*x) * sin(ky*y);
    E_Y = sin(kx*x) * cos(ky*y);
    E_Z = sin(kx*x) * sin(ky*y);
    H_X = sin(kx*x) * cos(ky*y);
    H_Y = cos(kx*x) * sin(ky*y);
    H_Z = 0;

    % E_X = (-1i*beta_z*m*pi/(beta_c^2*a)) * B_mn * cos(m*pi*x/a) * sin(n*pi*y/b) * exp(-1i*beta_z*z);
    % E_Y = (-1i*beta_z*n*pi/(beta_c^2*b)) * B_mn * sin(m*pi*x/a) * cos(n*pi*y/b) * exp(-1i*beta_z*z);
    % E_Z = B_mn * sin(m*pi*x/a) * sin(n*pi*y/b) * exp(-1i*beta_z*z);
    % H_X = (1i*omega*epsilon*n*pi/(beta_c^2*b)) * B_mn * sin(m*pi*x/a) * cos(n*pi*y/b) * exp(-1i*beta_z*z);
    % H_Y = (-1i*omega*epsilon*m*pi/(beta_c^2*a)) * B_mn * cos(m*pi*x/a) * sin(n*pi*y/b) * exp(-1i*beta_z*z);
    % H_Z = 0;
end

%Output the Information on the waveguide

if k > kc
    fprintf('(b) Propagation mode\n');
    fprintf('(c) Cut-off freq: %.4f\n',prop);
    fprintf('(d)  Theta (deg): %.4f\n',theta);
else
    fprintf('(b) Evansent mode\n');
    fprintf('(c) Cut-off freq: %.4f\n',prop);
    fprintf('(d) Down 10%%: %s\n','N/A (Not yet implemented)');
end



%Plot each chart on one figure

figure('NumberTitle','off','Name','(a) Plot of field components in a rectangular waveguide')
subplot(2,3,1)
imagesc(x,y,E_X)
title('Plot of E_X')

subplot(2,3,2)
imagesc(x,y,H_X)
title('Plot of H_X')

subplot(2,3,3)
imagesc(x,y,E_Y)
title('Plot of E_Y')

subplot(2,3,4)
imagesc(x,y,H_Y)
title('Plot of H_Y')

if mod(mode,2) == 1
    subplot(2,3,5)
    imagesc(x,y,E_Z)
    title('Plot of E_Z')
else
    subplot(2,3,6)
    imagesc(x,y,H_Z)
    title('Plot of H_Z')
end