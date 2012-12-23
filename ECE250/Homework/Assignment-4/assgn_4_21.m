clc
Rnum=input('how many resistors: ');
Rval=input('Enter the values for resistos(matrix format)\n');
Vsor=input('what is the Voltage source: \n');

for i=1:1:Rnum
    R(i)=1/Rval(i);
    Rcur(i)=Vsor/Rval(i);
    Rpow(i)=Vsor*Rcur(i);
end
Reqiv=1/sum(R);
fprintf('resistor Equivalent: %5.2f \n',Reqiv)
ResTable=[Rval',Rcur',Rpow'];
fprintf('|   Res   |   Cur   |   Pow   |\n')
disp(ResTable)
Isor=Vsor/Reqiv;
Tpow=sum(Rpow);
fprintf('\n\n source current: %5.2f A\n power total: %5.2f W\n\n',Isor,Tpow)
