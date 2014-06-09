%
%  TestMeanVarGen      : Test the GenMean and GenVar functions
%
%  Data used Originated from 
%       ECE384Lesson_9 Example 1, Slide 3 (c) Costa 2014
%
% ECE 384 Matlab Project
% (c) Daniel Noyes, MIT License

disp('Example 1 from Lesson 9 slide 3')

%Set up the Data From Example 1
Example1 = [0,0,0,2,2,4,4,4,4,4,6,6,6,6,6,6]

%GenVar will output the mean from GenMean and used it to calculate the Var
[Var,Mean] = GenVar(Example1)