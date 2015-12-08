function ar = sourceA(rank, n)
%
% SOURCEA function file
% source A for the second (and fourth) requirement of the first assignment.
% `rank` is the number of char-groups generated e.g. 2 for 'aa', 'ab' ...
% `n` is how many of these groups we want to be generated.
% See 'generate_probs' file about the generation of probs based on the others.
%

%   Copyright 2015 George 'papanikge' Papanikolaou
%   $Revision: 2.0 $  $Date: 2015/12/08 19:26:29 $

if rank == 1
    % Rank 1: generate single characters.
    [eng_letters, eng_letter_probs] = generate_probs(1);
    % Using randsrc to generate the corresponding numbers for each letter.
    ar = randsrc(n, 1, [1:26; eng_letter_probs]);
    % Convert to actual letters.
    ar = char(ar+'a'-1);
elseif rank == 2
    % Rank 2: generate couples.
    [eng_couples, eng_couple_probs] = generate_probs(2);

    % Generate the random-ry.
    numbers = randsrc(n, 1, [1:(26*26); eng_couple_probs]);

    % Try to 'translate' these back to letter couples
    ar = {};
    for i=1:n
        ar{i,1} = eng_couples{numbers(i)};
    end
    ar = cell2mat(ar);
else
    error('Rank over 3 is not supported yet... :)');
end
