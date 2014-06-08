function y = lpfilt(x)
%Generate the filtered signal
% and plot the magnitude spectrum 
% of the filtered output

[SOS_LP, G_LP] = LP;

y = sosfilt(SOS_LP, x);
