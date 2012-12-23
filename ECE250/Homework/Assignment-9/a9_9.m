fplot('(x-2)/((x-2)^4+2)^1.8', [0 5]);
xlabel('x');
ylabel('f(x)');
[x_1 fmin] = fminbnd('(x-2)/((x-2)^4+2)^1.8',0,2);
[x_2 fmax] = fminbnd('-(x-2)/((x-2)^4+2)^1.8',0,3);
fprintf('Min: %5.2f at x = %5.2f\n', fmin, x_1);
fprintf('Max: %5.2f at x = %5.2f\n', -fmax, x_2);