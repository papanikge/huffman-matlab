function text = myhuffmandeco(enco, dict)
%
% HUFFMANDECO function file
% Decodes the incoming 'enco' arg based on a huffman code using the 'dict' arg
% Second version with regexp. Slower but better.
%

%   Copyright 2015 George 'papanikge' Papanikolaou
%   $Revision: 2.0 $  $Date: 2015/12/11 15:12:20 $

% New algorithm. We're gonna work with regular expressions.
i = 1;
enco = sprintf('%d', enco);
while i <= length(dict)
    % Convert them to strings.
    code = sprintf('%d', dict{i,2});
    % Make the pattern. '^' is the string beginning anchor, we need the pattern
    % on the front to make sure it's the correct code (see: prefix-code).
    patt = ['^' code];
    if regexp(enco, patt);
        try
            text = [text {dict{i,1}}];
        catch
            text = {dict{i,1}};
        end
        % Let's go from the beginning...
        i = 1;
        % Updating the encoding part for the next iteration.
        le = length(enco);
        lc = length(code) + 1;
        if lc > le
            break;
        else
            enco = enco(lc:le);
        end
    else
        i = i + 1;
    end
end
