clc
Temp=40:-10:-40;
fprintf('\t\t\t\tTemperature (F)\n\n')
fprintf('\t%5d',Temp);
fprintf('\n Speed\n(mi/h)\n');
for Speed=10:10:60
    fprintf('  %d',Speed)
    for Temp=40:-10:-40
        Wchill=35.74 + 0.6215*Temp - 35.75*Speed^(0.16) + 0.4275*Temp*Speed^(0.16);
        fprintf('\t%5.0f',Wchill);
    end
    fprintf('\n');
end
