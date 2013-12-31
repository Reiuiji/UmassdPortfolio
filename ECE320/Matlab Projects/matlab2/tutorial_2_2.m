x=[1 2 3 4];
a1 = [1];
b1 = [0.5 1 2];
y1 = filter(b1,a1,x)

a2 = [1 -0.8];
b2 = [2];
y2 = filter(b2,a2,x)

a3 = [1 -0.8];
b3 = [0 2];
y3 = filter(b3,a3,x)
