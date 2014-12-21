clear all
close all
N = 10000;
T = 1;
A = 1;
t = A*T*[1:N];
varn=1/64;
sigma = sqrt(varn/T);
noise = sigma*randn(1,N);

phi = normcdf(t,1,sigma)
figure('NumberTitle','off','Name','Probability of bit error')
plot(phi,'b')



%%

snr=[1:.2:100]
%% for OOK
Perr(1,:)=normcdf(sqrt(snr/2),sqrt(2*snr),1)
%%  bpsk
Perr(2,:)=normcdf(0,sqrt(snr),1)

plot(snr,loglog(Perr(2)))