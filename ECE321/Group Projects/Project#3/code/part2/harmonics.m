function Y = harmonics(Frequency, Duration, N, A_vect, Shape)
% harmonics : Generate the harmonic note
%
% Author: Daniel Noyes
% Checker: Jenny Doan
%

%calculate each notes add to make it softer to 1
%H_amp = 1/N;

%create the first Note.
Note = gentone(Frequency,Duration,1,Shape);

for I = 2:N
    %too low for now with amp, revert it
    %Note = H_amp*gentone(Frequency*I,Duration,A_vect(I),Shape) + Note;
    Note = gentone(Frequency*I,Duration,A_vect(I),Shape) + Note;
end

Y = Note;
end