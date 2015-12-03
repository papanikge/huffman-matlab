function text = huffmandeco(enco, dict)
%
% HUFFMANDECO function file
% Decodes the incoming 'enco' arg based on a huffman code using the 'dict' arg
%

%   Copyright 2015 George 'papanikge' Papanikolaou
%   $Revision: 1.0 $  $Date: 2015/12/01 03:12:20 $

i = 1;
while i<=length(enco)
    % We are not working char-wise for the decoding
    % looking through the dictionary
    for j=1:length(dict)
        l = length(dict{j,2});          % `l` is the length of the current code
        if enco(i:(i+(l-1))) == dict{j,2}
            try
                text = {cell2mat(text) dict{j,1}};
            catch
                text = {dict{j,1}};
            end
            break;
        end
    end
    i = i + l;
end
