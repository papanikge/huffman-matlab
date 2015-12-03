function ar = sourceA(n)
% source A for the second requirement of the first assignment.
% George 'papanikge' Papanikolaou CEID 2015

eng_letter_prob = [.08167 .01492 .02782 .04253 .12702 .02228 .02015 .06094 .06966 .00153 .00772 .04025 .02406 .06749 .07507 .01929 .00095 .05987 .06327 .09056 .02758 .00978 .02361 .00150 .01974 .00074];

% generate 10000 random 5-letter words
ar = randsrc(10000, n, [1:26; eng_letter_prob]);
% convert to actual letters
ar = char(ar+'a'-1);
