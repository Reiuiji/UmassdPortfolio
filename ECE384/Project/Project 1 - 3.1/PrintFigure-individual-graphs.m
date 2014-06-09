function PrintFigure(FigNum,PdfData_A,CdfData_A,PdfData_T,CdfData_T,XXP_A,XXC_A,XXP_T,XXC_T,Name)
%
%  PrintFigure : will print out all the data for each part
%
%  CdfData_A : Actual Data for CDF
%  PdfData_A : Actual Data for PDF
%  CdfData_T : theoretical Data for CDF
%  PdfData_T : theoretical Data for PDF
%
% ECE 384 Matlab Project
% (c) Daniel Noyes, MIT License


figure('name',sprintf('Figure %i : PDF and CDF of %s Plots for ECE 384 Project 1',FigNum, Name),'numbertitle','off');
%suptitle(sprintf('Plots of a %s random variable', Name))

%Ploting A_PdfData
subplot(2,2,1);
plot(XXP_A,PdfData_A);
title('PDF Actual')
xlabel('Occurance(x)')
ylabel('Percentage')

%Ploting T_PdfData
subplot(2,2,2);
plot(XXP_T,PdfData_T);
title('PDF Theoretical')
xlabel('Occurance(x)')
ylabel('Percentage')

%Ploting A_CdfData
subplot(2,2,3);
plot(XXC_A,CdfData_A);
title('CDF Actual')
xlabel('Occurance(x)')
ylabel('Percentage')

%Ploting T_CdfData
subplot(2,2,4);
plot(XXC_T,CdfData_T);
title('CDF Theoretical')
xlabel('Occurance(x)')
ylabel('Percentage')
