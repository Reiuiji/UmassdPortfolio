function [Variation,Mean] = GenVar(Data)
%
%  GenVar       : Generate Variance Value for a 1D array
%
%  Equation     : Var[x] = Sig_n^2 = (1/n) sum from i=1 to n (X_i-Mn)^2
%
%  INPUT:
%    Data       : Input Data (1D Array)
%  OUTPUT:
%    Variation  : Variance for the Data
%    Mean       : Mean for the Data
%
% ECE 384 Matlab Project
% (c) Daniel Noyes, MIT License

    %Generate the Mean
    Mean = GenMean(Data);

    %Generate the Variance
	n = size(Data,2);

    %Generate the Variance
    Variation = (1/n) * sum((Data-Mean).^2);

end