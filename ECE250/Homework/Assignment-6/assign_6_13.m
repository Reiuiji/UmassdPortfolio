m=input('Enter m: ');
format long;
S=0;
for i=0:m
    S=S+(-1/3)^i/(2*i+1);
end
sum=sqrt(12)*S