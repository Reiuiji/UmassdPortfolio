y(1) = 0;
y(2) = 1;
for i=3:20
    y(i)=y(i-2)+y(i-1);
end
fprintf('%i ',y)
fprintf('\n');