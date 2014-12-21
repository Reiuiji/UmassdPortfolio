close all
clear all
SNR = 1:1:1000;
sigma = 1;
x = sqrt(SNR/2);
P = normcdf(x,sqrt(2*SNR),sigma);
figure('NumberTitle','off','Name','rate in SNR error')
loglog(SNR,P)