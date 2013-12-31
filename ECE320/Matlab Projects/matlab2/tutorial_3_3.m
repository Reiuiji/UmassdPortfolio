a = [1 -0.8];b = [2 0 -1];
%[H omega] = freqz(b,a,N)
%a: y part
%b: X part
%N: evenly spaced from between 0 and pi
%H:frequency response
%omega: frewuencies w_k
[H1 omega1] = freqz(b,a,4);
H1.'
omega1.'
%'whole' shows even;y spaced N from 0 to 2pi
[H2 omega2] = freqz(b,a,4,'whole');
H2.'
omega2.'