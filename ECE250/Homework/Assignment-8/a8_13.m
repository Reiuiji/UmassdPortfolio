function p = polyadd(p1,p2,operation)
m=max([length(p1) length(p2)]);

if length(p1)~=m
    k = length(p1);
    for i=k:-1:1
        p1(i+m-k) = p1(i);
    end
    for j = 1:m-k
        p1(j) = 0;
    end
end

if length(p2)~=m
    k = length(p2);
    for i=k:-1:1
        p2(i+m-k) = p2(i);
    end
    for j = 1:m-k
        p2(j) = 0;
    end
end

p=zeros(1,2*m-1);

if operation (1,1) == 'a'
    p=p1+p2;
else
    if operation (1,1) == 's'
        p=p1-p2;
    end;
end

