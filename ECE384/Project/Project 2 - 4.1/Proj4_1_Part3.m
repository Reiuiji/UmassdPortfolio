%
%  Proj4_1_Part3    : Estimate the mean and the variance of these random
%                      variables(Project 3.1 Step 1) using the following
%                      formulas
%
% ECE 384 Matlab Project
% (c) Daniel Noyes, MIT License

clear   %clear all variables
%clc     %Clear Console

%Sequences
Sequences = 10000;

%Generate the random Values for Project 3.1 Step 1
[BinNum,PoisNum,GeoNum,UniNum,GausNum,ExpNum] = GenProj3_1(Sequences);

% Generate the mean and variance for each Random Value
[BinMean,BinVar,PoisMean,PoisVar,GeoMean,GeoVar,UniMean,UniVar,GausMean,GausVar,ExpMean,ExpVar] = Proj4_1_GenMeanVar(BinNum,PoisNum,GeoNum,UniNum,GausNum,ExpNum)
