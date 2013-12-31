function dzplot(b,a)
%DPZPLOT plots the poles and zeros of a discrete-time LTI system.
%
% Usage:  dpzplot(b,a) 
%
% The LTI system is defined by the coefficients in 'b' and 'a', which
% are in the form required by the MATLAB function 'filter'. Namely,
% the system function has a numerator polynomial given by the
% coefficients in 'b' and a denominator polynomial given by the
% coefficients in 'a'.  

%---------------------------------------------------------------
% copyright 1996, by John Buck, Michael Daniel, and Andrew Singer.
% For use with the textbook "Computer Explorations in Signals and
% Systems using MATLAB", Prentice Hall, 1997.
%---------------------------------------------------------------

la=length(a);
lb=length(b);
if (la>lb),
  b=[b zeros(1,la-lb)];
elseif (lb>la),
  a=[a zeros(1,lb-la)];
end
ps = roots(a);
zs = roots(b);
mx = max( abs([ps' zs' .95]) ) + .05;
mx = 4;
%clf;
axis([-mx mx -mx mx]);
axis('equal');
hold on
w = [0:.01:2*pi];
plot(cos(w),sin(w),'k-');
plot([-mx mx],[0 0],'k-');
plot([0 0],[-mx mx],'k-');
plot(real(ps),imag(ps),'kx','MarkerSize',10);
plot(real(zs),imag(zs),'ko','MarkerSize',8);
numz=sum(abs(zs)==0);
nump=sum(abs(ps)==0);
if numz>1,
  text(.1,.1,num2str(numz));
% text(.1,-.1,num2str(numz));
elseif nump>1,
  text(.25,.25,num2str(nump));
  %text(-.25,-.25,num2str(nump));
end
hold off;

