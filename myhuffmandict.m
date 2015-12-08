function [dict, avg] = myhuffmandict(sym, prob)
%
% HUFFMANDICT function file
% Generates a dictionary for the Huffman code for the given alphabet and probs.
%

%   Copyright 2015 George 'papanikge' Papanikolaou
%   $Revision: 1.0 $  $Date: 2015/12/01 18:30:01 $

% Basic checks
if ~isa(sym, 'cell')
    error('The alphabet argument must be a cell array.')
end
if round(sum(prob)) ~= 1
    error('Probabilities must sum up to 1.')
end
if length(prob) ~= length(sym)
    error('Argument dimensions must agree.')
end

% Basic algorithm. We don't return the char cell in the same order.
l = length(prob);
dict = cell(l, 2);
if l == 1
    dict{1,1} = sym{l};
    dict{1,2} = 0;
end

i = 1;
while l > 1
    % We can't use system's sort since we want the char-prob couples together
    % so we built a simple bubblesort.
    [sym, prob] = bubblesort(sym, prob);

    % Assigning codes. We don't build the tree, but using its logic instead, to
    % assign 0 or 1 accordingly, based on the sorted list.
    % For the last element...
    k = length(sym{l});
    if k > 1
        % Case 2: Append the new code digit in front of every existing one for
        % the appropriate (current) characters. Case 1 follows
        for j=1:k
            index = find([dict{:}] == sym{l}(j));
            dict{index,2} = [1 dict{index,2}];
        end
    else
        % Case 1: Append the character and the first code digit to the dictionary
        dict{i,1} = sym{l};
        dict{i,2} = 1;
        i = i + 1;
    end
    % ... and - the same stuff - for the one before it.
    k = length(sym{l-1});
    if k > 1
        for j=1:k
            index = find([dict{:}] == sym{l-1}(j));
            dict{index,2} = [0 dict{index,2}];
        end
    else
        dict{i,1} = sym{l-1};
        dict{i,2} = 0;
        i = i + 1;
    end

    % Merging elements in both arrays.
    prob(l-1) = prob(l-1) + prob(l);
    prob(l) = [];                        % Delete last element
    sym{l-1} = strcat(sym{l-1},sym{l});
    sym{l} = [];                         % This does not delete it,
    % it just puts an empty vector there. It works for lists above because
    % vectors(lists) that is are like numbers in MATLAB.

    % Getting the new length
    l = length(prob);
end

dict = flip(dict);

% finding average
total = 0;
for i=1:length(dict)
    total = total + length(dict{i,2});
end
avg = total / length(dict);
