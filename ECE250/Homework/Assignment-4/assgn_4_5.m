clc
Grades= input('enter the grades\n');
L=length(Grades);
M=mean(Grades);
SD=std(Grades);
Md=median(Grades);
fprintf('\n# of Grades: %d',L)
fprintf('\nGrade Average: %5.2f',M)
fprintf('\nStandard Deviant: %5.2f',SD)
fprintf('\nMedian: %5.2f',Md)
fprintf('\n\n');