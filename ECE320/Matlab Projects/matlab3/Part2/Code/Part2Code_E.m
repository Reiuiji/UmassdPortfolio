%Matlab # 3 : Part 2: parts (e)
%Group 4

[s] = wavread('group4.wav');
%soundsc(s, Freq) %10KHz

Freq = 10000;%10KHz

s=s';
x=s.*Freq;


T=1/Freq;
xlen=[0:(length(x)-1)];
N=2^nextpow2(length(x));
X=fftshift(fft(x,N));

%x[n]
figure(1)
plot(xlen/Freq,x)
grid on
xlabel('samples (s)')
ylabel('x[n]')
title('Project 3, Part 2, Section (e): x[n]')

if FINALPLOTS
    print -deps Part2E-1.eps
end


%==========
%Top Branch
%==========

Wn=[0.5 0.9];
n = 2048;

b = fir1(n, Wn);
BPF=fftshift(fft(b,N));

V1=X.*BPF;
v1=ifft(V1,N);

k=0:N-1;
whz=(((2*pi*k/N)-pi)./T).*(10/(2*pi));

%V1(t)
figure(2)
plot(whz.*T,abs(V1))
grid on
xlabel('freq (Khz)')
ylabel('|V_1(t)|')
title('Project 3, Part 2, Section (e): V_1(t)')

if FINALPLOTS
    print -deps Part2E-2.eps
end


w1=v1.*(2*cos(2*pi*2000.*whz));
W1=fft(w1,N);

%W1(t)
figure(3)
plot(whz.*T,abs(W1))
grid on
xlabel('freq (Khz)')
ylabel('|W_1(t)|')
title('Project 3, Part 2, Section (e): W_1(t)')

if FINALPLOTS
    print -deps Part2E-3.eps
end


wlpf=2000/5000;
b = fir1(n, wlpf);
LPF=fftshift(fft(b,N));

S1 = LPF.*W1;

%s1(t)
figure(4)
plot(whz.*T,abs(S1))
grid on
xlabel('freq (Khz)')
ylabel('|S_1(t)|')
title('Project 3, Part 2, Section (e): S_1(t)')

if FINALPLOTS
    print -deps Part2E-4.eps
end


%==========
%Bot Branch
%==========

b = fir1(n, wlpf);
LPF2 = fftshift(fft(b,N));

V2 = X.*LPF2;
v2=ifft(V2,N);

%V2(t)
figure(5)
plot(whz.*T,abs(V2))
grid on
xlabel('freq (Khz)')
ylabel('|V_2(t)|')
title('Project 3, Part 2, Section (e): V_2(t)')

if FINALPLOTS
    print -deps Part2E-5.eps
end


w2 = v2.*(2*cos(2*pi*2000.*whz));
W2 = fft(w2,N);


%W2(t)
figure(6)
plot(whz.*T,abs(W2))
grid on
xlabel('freq (Khz)')
ylabel('|W_2(t)|')
title('Project 3, Part 2, Section (e): W_2(t)')

if FINALPLOTS
    print -deps Part2E-6.eps
end


Wn2 = [1000/5000 4000/5000];%need to change
b = fir1(n, Wn2);
BPF2=fftshift(fft(b,N));


S2=W2.*BPF2;

%s2(t)
figure(7)
plot(whz.*T,abs(S2))
grid on
xlabel('freq (Khz)')
ylabel('|S_2(t)|')
title('Project 3, Part 2, Section (e): S_2(t)')

if FINALPLOTS
    print -deps Part2E-7.eps
end


Y=S1+S2;

y = ifft(Y,N);
yy=0:length(y)-1;
%Y(t)
figure(7)
plot(whz.*T,Y)
grid on
xlabel('freq (Khz)')
ylabel('Y(t)')
title('Project 3, Part 2, Section (e): Y(t)')

if FINALPLOTS
    print -deps Part2E-7.eps
end



y=ifft(Y,N);
soundsc(y,10000)