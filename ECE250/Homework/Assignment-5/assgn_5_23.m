t=linspace(0,2,1000);
R=4;
L=1.3;
V=12;
%plot based on condition statement
i= (t<0.5).*(V/R).*(1-exp(-R.*t/L)) + ... 
  (t>=0.5).*exp(-R.*t/L)*(V/R)*(exp(0.5*R/L)-1);

plot(t,i);
xlabel('time(s)');
ylabel('i(t) (amp''s)');