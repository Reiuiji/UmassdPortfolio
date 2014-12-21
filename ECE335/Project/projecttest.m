%ECE 335 Project
%(c) Daniel Noyes, MIT License
clear
close all
V1 = 50; %0;
V2 = 50;
a = 1.0; %height
b = 1.0; %width
N = 10; %iterations
d = 1E-2; %1 cm scale


x= 0:d:a;
y= 0:d:b;
V = zeros(length(y),length(x));

for yy = 1:length(y)
    for xx = 1:length(x)
        sum = 0.0;
        for k = 1:N
            m = 2*k -1;
            gm = 4*V2/(m*pi);
            hm = ( 4*V1/(m*pi) - 4*V2/(m*pi)*cosh(m*pi*a/b))/sinh(m*pi*a/b);
            v = sin(m*pi*x(xx)/b)*(gm*cosh(m*pi*y(yy)/b) + hm*sinh(m*pi*y(yy)/b));
            sum = sum + v;
        end
        V(yy,xx) = sum;
    end
end
%diary test.out
%V
%diary off
image(x,y,V)
set(gca,'YDir','normal')