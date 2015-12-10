function [chars, probs] = estimate_probs(file, n)
%
% ESTIMATE_PROBS function file
% Returns the estimated probabilities (based on the occurances) for every
% character in the text of the given file.
% `n` is the n-grams. Give `1` for char-by-char.
%

%   Copyright 2015 George 'papanikge' Papanikolaou
%   $Revision: 1.0 $  $Date: 2015/12/05 13:06:21 $

chars = {};
probs = [];

% get text
text = fileread(file);
if n == 1
    % we don't wanna mess with newlines
    text = strrep(text, sprintf('\n'), '');
    % get a cell to make it manageable
    text = mat2cell(text, ones(1,1), ones(1, length(text)));
elseif n == 2
    % this time we care about spaces too
    text = strrep(text, sprintf('\n'), ' ');
    text = mat2cell(text, ones(1,1), ones(1, length(text)/2)*2);
else
    error('3-grams and above are not supported (yet).');
end
% and finally tabulate to get the appearence percentages
joined = tabulate(text);

for i=1:length(joined)
    chars{i} = joined{i,1};
    probs(i) = joined{i,3};
end

% The probability scope needs to be between 0 and 1, not a percentage.
probs = probs/100;
