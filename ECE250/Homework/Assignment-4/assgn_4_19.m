clc
Coefficients = [38.49, 3.904E-2, -3.105E-5, 8.606E-9;
48.5, 9.188E-2, -8.54E-5, 32.4E-9;
29.1, 1.158E-2, -0.6076E-5, 1.311E-9;
29, 0.2199E-2, -0.5723E-5, -2.871E-9];
fprintf('\n|    Temp    |    Cso2    |    Cso3    |    Cpo2    |    Cn20    |')
x=1;
for Temp=200:20:400
    T(x) = Temp;
    fprintf('\n|   %6.2f   |',T(x))
    
    for y=1:1:4
        Heat_Cap(x)=Coefficients(y,1) + Coefficients(y,2)*T(x) + Coefficients(y,3)*(T(x))^2 + Coefficients(y,4)*(T(x))^3;
        fprintf('   %6.2f   |',Heat_Cap(x))
    end
    x=x+1;
end
fprintf('\n\n');