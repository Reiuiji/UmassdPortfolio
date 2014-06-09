%
%  Proj4_1_Part4a   : Repeat Steps 2 and 3 by increasing the sequence 
%                       length n to 40000.
%
% ECE 384 Matlab Project
% (c) Daniel Noyes, MIT License

clear   %clear all variables
%clc     %Clear Console

%Sequences set to 40000 for part a
Sequences = 40000;

%Generate the random Values for Project 3.1 Step 1
[BinNum,PoisNum,GeoNum,UniNum,GausNum,ExpNum] = GenProj3_1(Sequences);

% Generate the mean and variance for each Random Value
[BinMean,BinVar,PoisMean,PoisVar,GeoMean,GeoVar,UniMean,UniVar,GausMean,GausVar,ExpMean,ExpVar] = Proj4_1_GenMeanVar(BinNum,PoisNum,GeoNum,UniNum,GausNum,ExpNum)
