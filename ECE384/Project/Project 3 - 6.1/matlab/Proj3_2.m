%
%  Proj3_2       : Generate the data needed for 6.1 part 2
%
% ECE 384 Matlab Project
% (c) Daniel Noyes, MIT License

%Clear Matlab
clear
clc
close all

%Allow saving printed plots
PrintPlot = 0;

%================%
%     Part a     %
%================%

%Generate 20 sequences of IID exponential random variables Xi

Lamda = 0.5;
Sequences = 10000;

Y = 0;
for i = 1:20
	Y = Y + exprnd(Lamda*i,1,Sequences);
end

[f1 x1] = hist(Y, 30);

[pdf1,cdf1,xxp1,xxc1] = pdfcdf(Y,Sequences);

%Plot fy1
figure(1)
subplot(2,1,1)
fy1 = bar(x1,f1/trapz(x1,f1));
title('PDF of Y')
xlabel('Bins')
ylabel('Amount')

subplot(2,1,2)
plot(xxc1,cdf1)
title('CDF of Y')
xlabel('Bins')
ylabel('Amount')

%================%
%     Part b     %
%================%

%Calculate the mean
mY = mean(Y)

%Calculate the varaiance
vY = std(Y)

%================%
%     Part c     %
%================%

figure(1)
subplot(2,1,1)
hold on
Gauss_Y = 1./sqrt(2.*pi.*(vY.^2)).*exp(-((x1-mY).^2)./(2.*(vY.^2)));
plot(x1, Gauss_Y)
hold off

if PrintPlot
    print('-dpng','-r100','Part2_Y.png')
end
