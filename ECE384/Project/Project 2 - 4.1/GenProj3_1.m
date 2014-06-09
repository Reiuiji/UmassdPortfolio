function [BinNum,PoisNum,GeoNum,UniNum,GausNum,ExpNum] = GenProj3_1(Sequences)
%
%  GenProj3_1   : Generate random sequences as specified in Project 3.1 Step 1.
%
%  INPUT:
%    Sequences  : Number of Sequences for each random variable (10000)
%
%  OUTPUT:
%    BinNum     : Binomial Random variable
%    PoisNum    : Poisson Random Variable
%    GeoNum     : Type 1 Geometric Random Variable
%    UniNum     : (Continous) Uniform Random Variable
%    GausNum    : Gaussian Random Variable
%    ExpNum     : Exponential Raneom Variable
%
% ECE 384 Matlab Project
% (c) Daniel Noyes, MIT License

%Matlab Code For Project 3.1 Step 1
%Generate a Sequences of each of the follow types of random variables
%Part a: binomial random variable, n = 12, p = 0.5109
    BinN = 12;
    BinP =  0.5109;
    BinNum = binornd(BinN,BinP,1,Sequences);

%Part b: poisson random variable, p = 0.0125, %alpha = np =1
    PoisN = 80;
    PoisP = 0.0125;
    Poisalpha = PoisN*PoisP;
    PoisNum = poissrnd(Poisalpha,1,Sequences);

%Part c: type 1 geometric random variable, p = 0.09
    GeoP = 0.09;
    GeoNum = geornd(GeoP,1,Sequences);

%Part d: (continous) uniform random variable, range [-2, 5]
    Lower = -2;
    Upper = 5;
    UniNum = unifrnd(Lower,Upper,1,Sequences);

%Part e: gaussian random variable, %mu = 1.3172, %sigma^2 = 1.9236
    Mu = 1.3172;
    SigmaSqr = 1.9236;
    Sigma = sqrt(SigmaSqr);
    GausNum = randn(1,Sequences).*Sigma + Mu;

%Part f: exponential random variable, %lamda = 1.37
    Lamda = 1.37;
    ExpNum = expon(Sequences,Lamda);
end

