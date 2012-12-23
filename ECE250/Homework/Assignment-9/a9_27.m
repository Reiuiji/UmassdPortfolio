a=5.9065E9; %km
b=5.7208E9; %km
k=sqrt(a^2-b^2)/a; %=0.2488
P=4*a*quad('sqrt(1-(0.2488.*sin(theta)).^2)',0,pi/2);
Speed=P/(24*365*248);
fprintf('Distance traveled by Pluto: %5.2f km\n', P);
fprintf('Average speed: %5.2f km/hr \n\n',Speed);
