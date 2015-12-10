function [chars, probs] = estimate_probs(file, n)
%
% ESTIMATE_PROBS function file
% Returns the estimated probabilities (based on the occurances) for every
% character in the text of the given file.
% `n` is the n-grams. Give `1` for char-by-char.
%

%   Copyright 2015 George 'papanikge' Papanikolaou
%   $Revision: 2.0 $  $Date: 2015/12/10 20:04:10 $

chars = {};
probs = [];

% Getting text from the file.
text = fileread(file);
if n == 1
    % We don't wanna mess with newlines.
    text = strrep(text, sprintf('\n'), '');
    % Get a cell to make it manageable.
    text = mat2cell(text, 1, ones(1, length(text)));
elseif n == 2
    % This time we care about spaces too.
    text = strrep(text, sprintf('\n'), ' ');
    % Plus get rid of the final space.
    text = strtrim(text);
    dict = {};
    for i=1:length(text)
        try
            new_couple = mat2cell(text(i:(i+1)), 1, 2);
        catch
            % We're breaking when we reach the end of the string.
            break;
        end
        % Merging when couple's legit.
        if new_couple{1}(1) ~= ' '
            dict = [dict new_couple];
        end
    end
    text = dict;
else
    error('3-grams and above are not supported (yet).');
end
% ...and finally tabulate to get the appearence percentages.
joined = tabulate(text);

% Let's make it the way we want.
for i=1:length(joined)
    chars{i} = joined{i,1};
    probs(i) = joined{i,3};
end

% The probability scope needs to be between 0 and 1, not a percentage.
probs = probs/100;
