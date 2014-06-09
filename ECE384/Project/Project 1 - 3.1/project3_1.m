%Matlab Code For Project 3.1

%1: 
%Generate a sequence of each of the follow types of random variables
clc;
clear;
close all;
%Should it print out the figures
PrintPlot = false;

%10,000 "each sequence should be at least 10,000 points long"
Sequence = 10000;

%Part a: binomial random variable, n = 12, p = 0.5109
    BinN = 12;
    BinP =  0.5109;
    BinNum = binornd(BinN,BinP,1,Sequence);

%Part b: poisson random variable, p = 0.0125, %alpha = np =1
    PoisN = 80;
    PoisP = 0.0125;
    Poisalpha = PoisN*PoisP;
    PoisNum = poissrnd(Poisalpha,1,Sequence);

%Part c: type 1 geometric random variable, p = 0.09
    GeoP = 0.09;
    GeoNum = geornd(GeoP,1,Sequence);

%Part d: (continous) uniform random variable, range [-2, 5]
    Lower = -2;
    Upper = 5;
    UniNum = unifrnd(Lower,Upper,1,Sequence);

%Part e: gaussian random variable, %mu = 1.3172, %sigma^2 = 1.9236
    Mu = 1.3172;
    SigmaSqr = 1.9236;
    Sigma = sqrt(SigmaSqr);
    GausNum = randn(1,Sequence).*Sigma + Mu;

%Part f: exponential random variable, %lamda = 1.37
    Lamda = 1.37;
    ExpNum = expon(Sequence,Lamda);


%2:
%Plot each of the previous parts via CDF, PDF, or PMF
%Plot a: binomial random variable

    %Actual
    [BinPdf_A,BinCdf_A,BinPX_A,BinCX_A] = PdfCdf(BinNum,BinN);
    %Theoretical
    BinX_T = 0:BinN;
    BinPdf_T = binopdf(BinX_T, BinN, BinP); %pdf('Binomial',BinX_T,BinN,BinP);
    BinCdf_T = binocdf(BinX_T, BinN, BinP); %cdf('Binomial',BinX_T,BinN,BinP);
    %Print the figure
    PrintFigure(1,BinPdf_A,BinCdf_A,BinPdf_T,BinCdf_T,BinPX_A,BinCX_A,BinX_T,BinX_T,'Binomial',PrintPlot);

%Plot b: poisson random variable

    %Actual
    [PoisPdf_A,PoisCdf_A,PoisPX_A,PoisCX_A] = PdfCdf(PoisNum,PoisN);
    %Theoretical
    PoisX_T = 0:7;
    PoisPdf_T = poisspdf(PoisX_T,Poisalpha);%pdf('Poisson',PoisX_T,Poisalpha);
    PoisCdf_T = poisscdf(PoisX_T,Poisalpha);%cdf('Poisson',PoisX_T,Poisalpha);
    %Print the figure
    PrintFigure(2,PoisPdf_A,PoisCdf_A,PoisPdf_T,PoisCdf_T,PoisPX_A,PoisCX_A,PoisX_T,PoisX_T,'Poisson',PrintPlot);

%Plot c: type 1 geometric random variable

    %Actual
    [GeoPdf_A,GeoCdf_A,GeoPX_A,GeoCX_A] = PdfCdf(GeoNum);
    %Theoretical
    GeoX_T = 0:100;
    GeoPdf_T = geopdf(GeoX_T,GeoP);%pdf('Geometric',GeoX_T,GeoP);
    GeoCdf_T = geocdf(GeoX_T,GeoP);%cdf('Geometric',GeoX_T,GeoP);
    %Print the figure
    PrintFigure(3,GeoPdf_A,GeoCdf_A,GeoPdf_T,GeoCdf_T,GeoPX_A,GeoCX_A,GeoX_T,GeoX_T,'Geometric',PrintPlot);
    
%Plot d: (continous) uniform random variable

    %Actual
    [UniPdf_A,UniCdf_A,UniPX_A,UniCX_A] = PdfCdf(UniNum); 
    %Theoretical
    UniX_T = Lower:Upper;
    UniPdf_T = unifpdf(UniX_T,Lower,Upper);%pdf('Uniform',Lower,Upper);
    UniCdf_T = unifcdf(UniX_T,Lower,Upper);%cdf('Uniform',Lower,Upper);
    %Print the figure
    PrintFigure(4,UniPdf_A,UniCdf_A,UniPdf_T,UniCdf_T,UniPX_A,UniCX_A,UniX_T,UniX_T,'Uniform',PrintPlot);

%Plot e: gaussian random variable

    %Actual
    [GausPdf_A,GausCdf_A,GausPX_A,GausCX_A] = PdfCdf(GausNum);
    %Theoretical
    GausX_T = -10:10;
    GausPdf_T = normpdf(GausX_T,Mu,Sigma);%pdf('Normal',Mu,Sigma);
    GausCdf_T = normcdf(GausX_T,Mu,Sigma);%cdf('Normal',Mu,Sigma);
    %Print the figure
    PrintFigure(5,GausPdf_A,GausCdf_A,GausPdf_T,GausCdf_T,GausPX_A,GausCX_A,GausX_T,GausX_T,'Gaussian',PrintPlot);


%Plot f; exponential random variable

    %Actual
    [ExpPdf_A,ExpCdf_A,ExpPX_A,ExpCX_A] = PdfCdf(ExpNum);
    %Theoretical
    ExpX_T = 0:10;
    ExpPdf_T = exppdf(ExpX_T,Lamda);%pdf('Exponential',Lamda);
    ExpCdf_T = expcdf(ExpX_T,Lamda);%cdf('Exponential',Lamda);
    %Print the figure
    PrintFigure(6,ExpPdf_A,ExpCdf_A,ExpPdf_T,ExpCdf_T,ExpPX_A,ExpCX_A,ExpX_T,ExpX_T,'Exponential',PrintPlot);
    
