
function [pmf,cdf,xx] = pmfcdf(xdata,ndx)

% function [pmf,cdf,xx] = pmfcdf(xdata,ndx)   
% measure the prob mass (fx) and distribution functions (FX)
% xdata = input array of random numbers
% ndx   = the number of theoretical distribution points, if known
% xx    = array that contains the range of xdata in ndx increments
% (c) Murali Tummala, Code EC/Tu, NPS (September 1990)  

if nargin == 1
    ndx = max(xdata);
end
xx = 0:ndx;

pmf(xx+1) = 0;
for n=1:length(xdata)
    pmf(xdata(n)+1) = pmf(xdata(n)+1)+1;
end

pmf = pmf/length(xdata);
cdf = cumsum(pmf);

return
