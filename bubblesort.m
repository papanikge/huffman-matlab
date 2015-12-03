function [chars, probs] = bubblesort(chars, probs)
%
% BUBBLESORT
% Sorting method for an array of probabilities and its accompaning characters.
%

n = length(probs);
while (n > 0)
    % Iterate through probs
    nnew = 0;
    for i = 2:n
        if (probs(i) > probs(i - 1))
            % Swap elements (in both arrays) when in wrong order
            vl = probs(i);
            vc = chars{i};
            probs(i) = probs(i-1);
            chars{i} = chars{i-1};
            probs(i-1) = vl;
            chars{i-1} = vc;
            % ...and update last position.
            nnew = i;
        end
    end
    n = nnew;
end
