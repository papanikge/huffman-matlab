function ar = sourceA(rank, n)
%
% SOURCEA function file
% source A for the second (and fourth) requirement of the first assignment.
% `rank` is the number of char-groups generated e.g. 2 for 'aa', 'ab' ...
% `n` is how many of these groups we want to be generated.
%

%   Copyright 2015 George 'papanikge' Papanikolaou
%   $Revision: 2.0 $  $Date: 2015/12/08 19:26:29 $

% based on wikipedia
eng_letters = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'};
eng_letter_probs = [.08167 .01492 .02782 .04253 .12702 .02228 .02015 .06094 .06966 .00153 .00772 .04025 .02406 .06749 .07507 .01929 .00095 .05987 .06327 .09056 .02758 .00978 .02361 .00150 .01974 .00074];

if rank == 1
    % Rank 1: generate single characters.
    % Using randsrc to generate the corresponding numbers for each letter.
    ar = randsrc(n, 1, [1:26; eng_letter_probs]);
    % Convert to actual letters.
    ar = char(ar+'a'-1);
elseif rank == 2
    % Rank 2: generate couples.
    % First of all find the probabilities...
    eng_couples_probs = zeros(26);
    for i=1:26
        for j=1:26
            eng_couples_probs(i,j) = eng_letter_probs(i) * eng_letter_probs(j);
        end
    end

    % Generate the random-ry.
    numbers = randsrc(n, 1, [1:(26*26); reshape(eng_couples_probs, [1, 26*26])]);

    % Try to 'translate' these back to letter couples
    k = 1;
    for i=1:26
        for j=1:26
            alphabet{k} = strcat(eng_letters{i}, eng_letters{j});
            k = k+1;
        end
    end

    % Translate based on the temp 'alphabet'
    ar = {};
    for i=1:n
        ar{i,1} = alphabet{numbers(i)};
    end
    ar = cell2mat(ar);
else
    error('Rank over 3 is not supported yet... :)');
end
