clc
Golf_score=input('Enter each golfers scores(except for the points and Par''s) in a matrix format:\n');
Golf_points=input('Enter the points for each golfer(matrix):\n');
Unknowns=Golf_score\Golf_points;
fprintf('\npoint values\n\n');
fprintf('Eagles:  \t%5f\n',Unknowns(1));
fprintf('Birdies: \t%5f\n',Unknowns(2));
fprintf('Pars:    \t0\n');
fprintf('Bogeys:  \t%5f\n',Unknowns(3));
fprintf('Doubles: \t%5f\n\n',Unknowns(4));
