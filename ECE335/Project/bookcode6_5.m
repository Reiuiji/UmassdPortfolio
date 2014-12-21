% Solution of Laplace's equation

p = [ ];
Vo = 100.0;
a = 1.0;
b = 2*a;
x = a;
y = a/2.;
c = 4.*Vo/pi;
sum = 0.0;
for k = 1:10
	n = 2*k -1;
	a1 = sin(n*pi*x/b);
	a2 = sinh(n*pi*y/b);
	a3 = n*sinh(n*pi*a/b);
	sum = sum + c*a1*a2/a3;
	p = [n, sum];
end
diary test.out
p
diary off
