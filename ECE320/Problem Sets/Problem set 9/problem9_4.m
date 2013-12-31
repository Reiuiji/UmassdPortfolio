%Part B
x = [1 -1 0 2 1 0 0 3];
h = [ 1 1 2 1 -1];

%Part C
N=8;
X = fft(x,N);
H = fft(h,N);
Y=X.*H;
y = ifft(Y,N);
n = 0:7;
figure(1)

stem(n,y);
xlabel('samples[n]')
ylabel('y[n]= x[n]*h[n]')
title('Convolution y[n] = x[n]*h[n] | N = 8')
grid

if FINALPLOTS
    print -deps PS9-4-1.eps
end

%part D
%its does not match due to aliasing

%part E
N=32;
X = fft(x,N);
H = fft(h,N);
Y=X.*H;
y = ifft(Y,N);
n = 0:31;

figure(2)
stem(n,y);
xlabel('samples[n]')
ylabel('y[n]= x[n]*h[n]')
title('Convolution y[n] = x[n]*h[n] | N = 32')
grid

if FINALPLOTS
    print -deps PS9-4-2.eps
end