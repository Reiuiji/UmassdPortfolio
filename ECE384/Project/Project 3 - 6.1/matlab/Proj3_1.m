%
%  Proj3_1       : Generate the data needed for 6.1 part 1
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

%Generate six sequences of uniform random variables (length ? 10,000) in the range [0.5, 0.5].
Sequences = 10000;
Lower = -0.5;
Upper = 0.5;
%uniform random arrays
X1 = unifrnd(Lower,Upper,1,Sequences);
X2 = unifrnd(Lower,Upper,1,Sequences);
X3 = unifrnd(Lower,Upper,1,Sequences);
X4 = unifrnd(Lower,Upper,1,Sequences);
X5 = unifrnd(Lower,Upper,1,Sequences);
X6 = unifrnd(Lower,Upper,1,Sequences);

%Sum of Y1
Y1 = X1 + X2 + X3 + X4 + X5 + X6;

%Sum of Y2
Y2 = X1 + 0.5*X2 + 0.8*X3 + 1.8*X4 + 0.3*X5 + 0.5*X6;

%Part a
[pdf1,cdf1,xxp1,xxc1] = pdfcdf(Y1,Sequences);
[pdf2,cdf2,xxp2,xxc2] = pdfcdf(Y2,Sequences);

[f1 x1] = hist(Y1, 30);
[f2 x2] = hist(Y2, 30);

%Plot Y1
figure(1)
subplot(2,1,1)
fy1 = bar(x1,f1/trapz(x1,f1));
%plot(xxp1,pdf1)
title('PDF of Y1')
xlabel('Bins')
ylabel('Amount')

subplot(2,1,2)
plot(xxc1,cdf1)
title('CDF of Y1')
xlabel('Bins')
ylabel('Amount')

%Plot Y2
figure(2)
subplot(2,1,1)
fy2 = bar(x2,f2/trapz(x2,f2));

%plot(xxp2,pdf2)
title('PDF of Y2')
xlabel('Bins')
ylabel('Amount')

subplot(2,1,2)
plot(xxc2,cdf2)
title('CDF of Y2')
xlabel('Bins')
ylabel('Amount')

%================%
%     Part b     %
%================%

%Calculate the mean
mY1 = mean(Y1)
mY2 = mean(Y2)

%Calculate the varaiance
vY1 = std(Y1)
vY2 = std(Y2)


%================%
%     Part c     %
%================%

x = [-2.5:0.1:2.5];
Gauss_Y1 = 1./sqrt(2.*pi.*(vY1.^2)).*exp(-((x-mY1).^2)./(2.*(vY1.^2)));
Gauss_Y2 = 1./sqrt(2.*pi.*(vY2.^2)).*exp(-((x-mY2).^2)./(2.*(vY2.^2)));


figure(1)
subplot(2,1,1)
hold on
plot(x,Gauss_Y1)
hold off

if PrintPlot
    print('-dpng','-r100','Part1_Y1.png')
end

figure(2)
subplot(2,1,1)
hold on
plot(x,Gauss_Y2)
hold off

if PrintPlot
    print('-dpng','-r100','Part1_Y2.png')
end
