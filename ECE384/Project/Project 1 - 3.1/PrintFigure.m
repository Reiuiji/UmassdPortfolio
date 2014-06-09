function PrintFigure(FigNum,PdfData_A,CdfData_A,PdfData_T,CdfData_T,XXP_A,XXC_A,XXP_T,XXC_T,Name,PrintPlot)
%
%  PrintFigure : will print out all the data for each part
%  Will print two graphs with both actual and theoretical ploted on each
%  self for comparison
%
%  CdfData_A : Actual Data for CDF
%  PdfData_A : Actual Data for PDF
%  CdfData_T : theoretical Data for CDF
%  PdfData_T : theoretical Data for PDF
%
% ECE 384 Matlab Project
% (c) Daniel Noyes, MIT License
% PrintPlot = false;

figure('name',sprintf('Figure %i : PDF and CDF of %s Plots for ECE 384 Project 1',FigNum, Name),'numbertitle','off');
%suptitle(sprintf('Plots of a %s random variable', Name))

%Ploting A_PdfData
subplot(1,2,1);
plot(XXP_A,PdfData_A,'r');
hold on
%Ploting T_PdfData
plot(XXP_T,PdfData_T,'b');
%title('PDF Actual and Theoretical')
title(sprintf('%s : PDF Actual and Theoretical', Name))
xlabel('Occurance(x)')
ylabel('Percentage')
legend('Actual','Theoretical','Location','NorthEast')
grid

%Ploting A_CdfData
subplot(1,2,2);
plot(XXC_A,CdfData_A,'r');
hold on
%Ploting T_CdfData
plot(XXC_T,CdfData_T,'b');

%title('CDF Actual and Theoretical')
title(sprintf('%s : CDF Actual and Theoretical', Name))
xlabel('Occurance(x)')
ylabel('Percentage')
legend('Actual','Theoretical','Location','SouthEast')
grid

%Print to file
if PrintPlot
    print('-dpng','-r100', sprintf('%s.png', Name))
end
