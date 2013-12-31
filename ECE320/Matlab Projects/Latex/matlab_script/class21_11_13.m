%Class 23 Problem 2

N = 64;
k = 0:63;

Xa = fft(xa,N);
Xb = fft(xb,N);
Xc = fft(xc,N);
Xd = fft(xd,N);

%Y 32 at X = 13
%Y 32 at X = 51
%32 samples per pi
Xaomega = 14/32

subplot(411)
stem(k,abs(Xa))
title('Class Problem 2b Xa')
xlabel('n(samples)')
ylabel('x[n]')

%Y 20 at X = 18,19
%32 samples per pi
Xbomega = (19+1)/32
subplot(412)
stem(k,abs(Xb))
title('Class Problem 2b Xb')
xlabel('n(samples)')
ylabel('x[n]')

%Y 64 at X = 5
%32 samples per pi
Xcomega = (5+1)/32
subplot(413)
stem(k,abs(Xc))
title('Class Problem 2b Xc')
xlabel('n(samples)')
ylabel('x[n]')

%Y 20 at X = 18,19
%32 samples per pi
Xbomega = (9+1)/32
subplot(414)
stem(k,abs(Xd))
title('Class Problem 2b Xd')
xlabel('n(samples)')
ylabel('x[n]')
    print -deps class19_11_13.eps
