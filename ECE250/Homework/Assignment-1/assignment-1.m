(2.3^2*1.7)/sqrt((1-0.8^2)^2+(2-sqrt(0.87))^2)
%1.4)b
2.34+.5*2.7*(5.9^2-2.4^2)+9.8*log(51)
%1.7
%a
t=6.8;
log(abs(t^2-t^3))
(75/(2*t))*cos(0.8*t-3)
%b above
%1.8
%a
x=8.3 ; y=2.4;
x^2+y^2-x^2/y^2
sqrt(x*y)-sqrt(x+y)+((x-y)/(x-2*y))^2-sqrt(x/y)
%b above
%1.10
%a
cube=18
surface_area=18*2*6 %area of one side then time 6 for each side of cube
radius_of_sphere=sqrt(surface_area/(4*pi)) %surface area for a sphere is 4 pi r^2
%1.10 b
volume_cube=18^3
radius_of_sphere=nthroot(volume_cube/((4*pi)/3),3)
%volume of a sphere is v=(4/3)*pi*r^3
%1.14
alpha=(5*pi)/8 ; beta=pi/8;
%left side
sin(alpha)*cos(beta)
.5*(sin(alpha - beta) + sin(alpha + beta))
%both are the same so the trig identity is corect
%1.17
a=5;b=7;gamma=25 ;%degrees
%a)
c=sqrt(a^2+b^2-2*a*b*cos(gamma))
%law of sine: sin(a)/a = sin(b)/b
%alpha =
alpha=asind((a*sind(gamma))/b)
alpha=asind((a*sind(gamma))/c)
beta=asind((b*sind(gamma))/c)
beta=asind((b*sind(alpha))/a)
%c law of tangents
%left side
(a-b)/(a+b)
tand(.5*(alpha-beta))/tand(.5*(alpha+beta))
%forgot to cosd at the beginning XD
c=sqrt(a^2+b^2-2*a*b*cos(gamma))
c=sqrt(a^2+b^2-2*a*b*cosd(gamma))
alpha=asind((a*sind(gamma))/c)
beta=asind((b*sind(gamma))/c)
(a-b)/(a+b)
tand(.5*(alpha-beta))/tand(.5*(alpha+beta))
%both sides were correct :D
%1.23
R1= 120;R2=100;R3=220;R4=120; % all expressed as ohms
V=12 %volts
Vab=V*(R2/(R1+R2) - R4/(R3+R4))
%1.33
%a
P=85000;y=15;r=0.0575; %P:payment,y:year,r:interest rate
M=(P*(r/12))/(1-(1+r/12)^(-12*y))
M*y
diary assignment-1-work.txt
diary
format long
ans
format short g
ans
