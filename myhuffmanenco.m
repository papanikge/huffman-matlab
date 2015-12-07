function enco = myhuffmanenco(text, dict)
%
% HUFFMANENCO function file
% Encodes the incoming 'text' arg to a huffman code using the 'dict' arg
%

%   Copyright 2015 George 'papanikge' Papanikolaou
%   $Revision: 1.0 $  $Date: 2015/11/30 15:09:24 $

enco = [];
for i=1:length(text)
    % We'll be working of course char-wise. Getting the character to encode.
    cc = text(i);
    % Building the `t` index matrix.
    % Stupid code but we avoid a lengthy case clause that way.
    t = strcmp(cc, dict);
    for j=1:length(t)
        if (t(j,1) == 1)
            t(j,1) = 0;
            t(j,2) = 1;
       end
    end
    % Finding the code using the index matrix
    enco = [enco dict{t}];
end
