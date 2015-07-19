clear
a = input('Enter the wave guide width\n >  ')
b = input('Enter the wave guide height\n >  ')
er = input('Enter the relative permittivity\n >  ')
ur = input('Enter the relative permeability\n >  ')

index = 1;
%Tm modes
for m=1:10,
    for n=1:10,
        modes(index,1)=1;
        modes(index,2)=m;
        modes(index,3)=n;
        modes(index,4)=3e8/sqrt(er*ur)*sqrt((m*pi/a)^2+(n*pi/b)^2);
        index=index+1;
    end
end

%TE Modes
for m=0:9,
    for n=0:9,
        if m | n
            modes(index,1)=2;
            modes(index,2)=m;
            modes(index,3)=n;
            modes(index,4)=3e8/sqrt(er*ur)*sqrt((m*pi/a)^2+(n*pi/b)^2);
            index=index+1;
        else
            %NOP
        end
    end
end

modes=sortrows(modes,4);
mode_string='ME';
disp(sprintf('\n'));
for k= 1:10
    disp(sprintf('ModeL T%c%d%d, ',...
        mode_string(modes(k,1)),modes(k,2),modes(k,3)));
    disp(sprintf('Cutoff frequency = %0.3f GHz\n', ...
        modes(k,4)/(2*pi*1e9)))
end