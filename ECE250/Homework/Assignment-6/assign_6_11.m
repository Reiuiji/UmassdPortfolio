a=input('a: ');
b=input('b; ');
c=input('c: ');
fprintf('equation: %4.2fx^2 + %4.2fx + %4.2f \n',a,b,c);
D=b.^2-4*a.*c;

if D>0
    fprintf('The equation has two roots\n');
    p=(-b+sqrt(D))/(2*a);
    q=(-b-sqrt(D))/(2*a);
    fprintf('%5.2f, %5.2f\n',p,q);
elseif D==0
    fprintf('The equation hase one root\n');
    p=-b/(2*a);
    fprintf('%5.2f\n',p);
else
    fprintf('The equation has no real roots\n');
end
