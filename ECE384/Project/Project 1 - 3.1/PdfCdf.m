
function [pdf,cdf,xxp,xxc] = pdfcdf(xdata,ndx)

% function [pdf,cdf,xxp,xxc] = pdfcdf(xdata,ndx)   
% measure the prob density (fx) and distribution functions (FX)
% xdata = input array of random numbers
% ndx   = the number of intervals or bins in the hist function
% xxp   = array that contains the range of the pdf
% xxc   = array that contains the range of the cdf
% (c) Murali Tummala, Code EC/Tu, NPS (September 1990)  

if (nargin == 1)
  ndx = 25;	%ndx in the range of 20 to 40 is suggested
end

[nx,xxp] = hist(xdata,ndx);
px = nx/length(xdata);
binwidth=xxp(2)-xxp(1);
pdf = px/binwidth;

[nx2,xxc] = hist(xdata,length(xdata));
px2 = nx2/length(xdata);
cdf = cumsum(px2);

return