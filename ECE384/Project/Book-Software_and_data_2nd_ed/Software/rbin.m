function x=rbin(P)
%
% x=rbin(P) returns a binary random number where Pr[1]=P and Pr[0]=1-P.
%
x=rand(1)<P;