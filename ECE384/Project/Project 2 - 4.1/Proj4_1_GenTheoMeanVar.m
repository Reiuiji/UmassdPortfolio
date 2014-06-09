%
%  Proj4_1_GenTheoMeanVar	: Generate the Theoretical Mean and Variance
%                               for the random variables in 3.1
%
% ECE 384 Matlab Project
% (c) Daniel Noyes, MIT License

clear   %clear all variables
%clc     %Clear Console

%Sequences
Sequences = 10000;

%Part a: binomial random variable, n = 12, p = 0.5109
    BinN = 12;
    BinP =  0.5109;
    BinMean = BinN*BinP
    BinVar = BinN*BinP*(1-BinP)

%Part b: poisson random variable, p = 0.0125, %alpha = np =1
    PoisN = 80;
    PoisP = 0.0125;
    Poisalpha = PoisN*PoisP;
    PoisMean = Poisalpha
    PoisVar = Poisalpha

%Part c: type 1 geometric random variable, p = 0.09
    GeoP = 0.09;
    GeoMean = 1/GeoP
    GeoVar = (1 - GeoP)/(GeoP^2)

%Part d: (continous) uniform random variable, range [-2, 5]
    Lower = -2;
    Upper = 5;
    UniMean = (Lower + Upper)/2
    UniVar = ((Upper - Lower)^2)/12

%Part e: gaussian random variable, %mu = 1.3172, %sigma^2 = 1.9236
    Mu = 1.3172;
    SigmaSqr = 1.9236;
    GausMean = Mu
    GausVar = SigmaSqr

%Part f: exponential random variable, %lamda = 1.37
    Lamda = 1.37;
    ExpMean = 1/Lamda
    ExpVar = 1/(Lamda^2)