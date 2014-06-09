%
%  Proj3_3       : Generate the data needed for 6.1 part 3
%
% ECE 384 Matlab Project
% (c) Daniel Noyes, MIT License

%Clear Matlab
clear
clc
close all

%Allow saving printed plots
PrintPlot = 0;
Sequences = 10000;

p = 0.8;
k = 0:1;

%calculate the Bernoulli PMFs
u = (p.^k).*(1-p).^(1-k);

for i = 0:50
    
    q =(p.^k).*(1-p).^(1-k);
    
    u = conv(q,u);
    
end


%Mean
M_u = mean(u)

%variance
V_u = std(u)

%Calculate the Gaussian
Mu = M_u;
SigmaSqr = V_u;
Sigma = sqrt(SigmaSqr);
x = 0:0.1:60;
Gnum = normpdf(x,Mu,Sigma);


%plot u the 50 integrated Bernoulli PMFs
figure(1)
plot(u)
hold on
plot(x,Gnum)
title('PDF Bernoulli PMFs')
xlabel('x')
ylabel('y')


if PrintPlot
    print('-dpng','-r100','Part3_Y.png')
end
