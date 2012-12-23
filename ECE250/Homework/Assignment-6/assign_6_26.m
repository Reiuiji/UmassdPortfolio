clear
P=input('value to square root: ');
x=[];
x(1)=P;
k=1;
E=1;

while E>=0.00001
    x(k+1)=(x(k)+P/x(k))/2;
    E=abs((x(k+1)-x(k))/x(k));
    k=k+1;
end
len=length(x);
fprintf('square root of %4.2f is %6.2f\n',P,x(len));
