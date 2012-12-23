x=[-3.5 -5 6.2 11 0 8.1 -9 0 3 -1 3 2.5];
y=x>0;
a=find(y);
b=x(a);
fprintf('Positive elements:\n %4.2f \n',b);

w=x;
z=w<0;
c=find(z);
d=w(c);
fprintf('Negative elements:\n %4.2f \n',d);