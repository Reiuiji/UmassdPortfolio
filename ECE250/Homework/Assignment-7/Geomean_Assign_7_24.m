function GM = Geomean(x)
G=1;
for i=1:1:length(x)
    G=G*x(i);
end
GM=G^(1/length(x));
