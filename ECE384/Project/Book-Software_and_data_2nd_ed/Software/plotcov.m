function plotcov(C,m,s,axs)

%Function to plot contour of a 2 X 2 covariance matrix.
%
%Use: plotcov(C,m,s,axs)
%
%where: C is the covariance matrix
%       m is the mean vector
%       s is the size of the ellipse in standard deviations
%         (may be fractional)
%       axs is the vector controling axis scaling
%         (same format as used by the axis command)

%...written by Charles W. Therrien 10/93 (updated for MATLAB 4.0)
%              Department of Electrical and Computer Engineering
%              Naval Postgraduate School
%              Monterey, California
%Copyright (c) 1994 by Charles W. Therrien
if nargin~=4
    error('Wrong number of arguments.')
elseif any(size(C)-[2 2])
    error('First argument must be a 2 x 2 matrix.')
elseif any(any(C'~=C))
    error('First argument does not have proper symmetry.')
elseif min(size(m)) > 1 | max(size(m)) ~= 2
    error('Second argument must be a 2-dimensional vector.')
elseif max(size(s)) > 1 | s(1,1) <=0
   error('Third argument must be a positive scalar.')
elseif min(size(axs)) > 1 | max(size(axs)) ~= 4
    error('Fourth argument must be a vector with 4 elements.')
else
    c=inv(C);
    r1=linspace(axs(1),axs(2));
    r2=linspace(axs(3),axs(4));
    [x1,x2]=meshgrid(r1,r2);
    x1=x1-m(1);
    x2=x2-m(2);
    z=c(1,1)*x1.^2 +2*c(1,2)*x1.*x2 +c(2,2)*x2.^2;
    v=[s s].^2;
    contour(r1,r2,z,v,'r');
end
