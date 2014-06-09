function x=expon(N,lambda)

%function x=expon(N,lambda) 
%N= length of the exponential r.v. sequence
%lambda= the parameter of the exponential r.v.

rand('state',0);            % initialize random generator

xu=rand(N,1);
x=-(1/lambda)*log(1-xu);


