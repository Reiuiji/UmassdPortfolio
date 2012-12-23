fplot('x^3-8*x^2+17*x+sqrt(x)-10',[0 7])
grid on

x_1=fzero('x^3-8*x^2+17*x+sqrt(x)-10',1);
x_2=fzero('x^3-8*x^2+17*x+sqrt(x)-10',3);
x_3=fzero('x^3-8*x^2+17*x+sqrt(x)-10',5);
fprintf('Positive roots: \n');
fprintf(' x_1: %d \n x_2: %d \n x_3: %d\n',x_1,x_2,x_3);