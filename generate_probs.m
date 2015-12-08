function [chars, probs] = generate_probs(rank)
%
% Tiny file to avoid code repetition.
% It generates the char/char-pairs and the probabilities thereof.
%

% probs based on wikipedia
singles = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'};
single_probs = [.08167 .01492 .02782 .04253 .12702 .02228 .02015 .06094 .06966 .00153 .00772 .04025 .02406 .06749 .07507 .01929 .00095 .05987 .06327 .09056 .02758 .00978 .02361 .00150 .01974 .00074];

if rank == 1
    chars = singles;
    probs = single_probs;
elseif rank == 2
    % First of all find the probabilities...
    eng_couples_probs = zeros(26);
    for i=1:26
        for j=1:26
            eng_couples_probs(i,j) = single_probs(i) * single_probs(j);
        end
    end
    % Change it to a suitable format.
    probs = reshape(eng_couples_probs, [1, 26*26]);

    k = 1;
    for i=1:26
        for j=1:26
            chars{k} = strcat(singles{i}, singles{j});
            k = k+1;
        end
    end
else
    error('Rank over 3 is not supported yet... :)');
end
