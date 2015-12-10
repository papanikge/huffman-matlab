function [dict, avg] = myhuffmandict(sym, prob)
%
% HUFFMANDICT function file
% Generates a dictionary for the Huffman code for the given alphabet and probs.
% Be aware: Messy code. This was written in a way not suitable for code quality,
% and is of immediate necessity of a refactoring, which I don't need to do...
%

%   Copyright 2015 George 'papanikge' Papanikolaou
%   $Revision: 2.0 $  $Date: 2015/12/10 01:07:31 $

% Basic checks
if ~isa(sym, 'cell')
    error('The alphabet argument must be a cell array.')
end
if 0.99 > sum(prob) || sum(prob) > 1.0  % God damn you floating point numbers
    error('Probabilities must sum up to 1.')
end
if length(prob) ~= length(sym)
    error('Argument dimensions must agree.')
end

% Basic algorithm. That way, we don't return the char cell in the same order.
l = length(prob);
dict = cell(l, 2);

% Check in which mode are we. Since we're working with the size of the characters
% in the dictionary, we'll use this flag to start the creation of it.
if length(sym{1}) > 1
    two_char_mode = 1;
else
    two_char_mode = 0;
end

% Since we're working with two elements in every loop, we need to get the
% single entry dictionary case outta the way.
if l == 1
    % fuck matlab and everything about its array dimensions.
    dict{1,2} = sym{l};
    dict{1,1} = 0;
end

i = 1;
while l > 1
    % We can't use system's sort since we want the char-prob couples together
    % so we built a simple bubblesort.
    [sym, prob] = bubblesort(sym, prob);

    % Assigning codes. We don't build the tree, but using its logic instead, to
    % assign 0 or 1 accordingly, based on the sorted list.

    % For the last element in the array...
    k = length(sym{l});
    if two_char_mode == 0
        for j=1:k
            index = find([dict{:}] == sym{l}(j));
            if index
                % A dictionary entry already exists.
                dict{index,2} = [1 dict{index,2}];
            else
                % Create a new entry in the dict.
                dict{i,1} = sym{l};
                dict{i,2} = 1;
                i = i + 1;
            end
        end
    else  % two-character dictionary mode
        for j=1:2:k
            index = find(strcmp(dict, sym{l}(j:(j+1))));
            if index
                % A dictionary entry already exists.
                dict{index,2} = [1 dict{index,2}];
            else
                % Create a new entry in the dict.
                dict{i,1} = sym{l};
                dict{i,2} = 1;
                i = i + 1;
            end
        end
    end

    % ... and - the same stuff - for the one before it...  (The only things
    % different are the indices and the codes, check above for comments.)
    k = length(sym{l-1});
    if two_char_mode == 0
        for j=1:k
            index = find([dict{:}] == sym{l-1}(j));
            if index
                dict{index,2} = [0 dict{index,2}];
            else
                dict{i,1} = sym{l-1};
                dict{i,2} = 0;
                i = i + 1;
            end
        end
    else
        for j=1:2:k
            index = find(strcmp(dict, sym{l-1}(j:(j+1))));
            if index
                dict{index,2} = [0 dict{index,2}];
            else
                dict{i,1} = sym{l-1};
                dict{i,2} = 0;
                i = i + 1;
            end
        end
    end

    % Merging elements in both arrays.
    prob(l-1) = prob(l-1) + prob(l);     % Probabilities are numbers
    prob(l) = [];                        % Delete last element
    sym{l-1} = strcat(sym{l-1}, sym{l}); % Chars are strings. Duh!
    sym{l} = [];                         % This does not delete it,
    % it just puts an empty vector there. It works for lists above because
    % vectors(lists) are like numbers in MATLAB.

    % Getting the new length. Length of 'sym' is not changing (after the merge)
    % as it should, but 'prob' does, and we don't mind.
    l = length(prob);
end

% We need it sorted the right way.
dict = flip(dict);

% Finding average.
total = 0;
s = size(dict);
for i=1:s(1)
    total = total + length(dict{i,2});
end
avg = total / s(1);
