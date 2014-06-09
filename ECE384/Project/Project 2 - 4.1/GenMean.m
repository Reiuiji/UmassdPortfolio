function Mean = GenMean(Data)
%
%  GenMean   : Generate Mean Value for a 1D array
%
%  Equation  : E{x} = Mn = (1/n) sum from i=1 to n {X_i}
%
%  INPUT:
%    Data    : Input Data (1D Array)
%  OUTPUT:
%    Mean    : Mean for the Data
%
% ECE 384 Matlab Project
% (c) Daniel Noyes, MIT License

    %calculate the width of the array
	n = size(Data,2);
    
    %calculate the mean
    Mean = (1/n) * sum(Data);

end