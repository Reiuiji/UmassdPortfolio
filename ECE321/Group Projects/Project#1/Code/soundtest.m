% for i=1:12
% sound(gentone(220*2^(i/12),0.1,1),8192);
% end
Quarter_AL = [gentone(AL,0.9,1) genrest(0.1)];
sound(Quarter_AL);


for i=1:120
sound(gentone(220*2^(i/12),0.1,2),8192);
%sound(genrest(0.2),8192);
end

sound(genrest(2),8192);

for i=0:12
sound(gentone(220*2^((12 - i)/12),0.1,2),8192);
end