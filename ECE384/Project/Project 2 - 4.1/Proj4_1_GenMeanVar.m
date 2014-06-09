function [BinMean,BinVar,PoisMean,PoisVar,GeoMean,GeoVar,UniMean,UniVar,GausMean,GausVar,ExpMean,ExpVar] = Proj4_1_GenMeanVar(BinNum,PoisNum,GeoNum,UniNum,GausNum,ExpNum)
%
%  Proj4_1_GenMeanVar   : Generate the mean and Variance for each random
%                         variable based on Project 3.1 part 1
%
%  INPUT:
%    BinNum         : Binomial Random variable
%    PoisNum        : Poisson Random Variable
%    GeoNum         : Type 1 Geometric Random Variable
%    UniNum         : (Continous) Uniform Random Variable
%    GausNum        : Gaussian Random Variable
%    ExpNum         : Exponential Random Variable
%
%  OUTPUT:
%    BinMean        : Binomial Mean
%    BinVar         : Binomial Variance
%    PoisMean       : Poisson Mean
%    PoisVar        : Poisson Variance
%    GeoMean        : Geometric Mean
%    GeoVar         : Geometric Variance
%    UniMean        : Uniform Mean
%    UniVar         : Uniform Variance
%    GausMean       : Gaussian Mean
%    GausVar        : Gaussian Variance
%    ExpMean        : Exponential Mean
%    ExpVar         : Exponential Variance
%
% ECE 384 Matlab Project
% (c) Daniel Noyes, MIT License

    %Part a: Binomial
    [BinVar, BinMean] = GenVar(BinNum);

    %Part b: Poisson
    [PoisVar, PoisMean] = GenVar(PoisNum);

    %Part c: Geometric (Type 1)
    [GeoVar, GeoMean] = GenVar(GeoNum);

    %Part d: Uniform (continous)
    [UniVar, UniMean] = GenVar(UniNum);

    %Part e: Gaussian
    [GausVar, GausMean] = GenVar(GausNum);

    %Part f: Exponential
    [ExpVar, ExpMean] = GenVar(ExpNum');

end

