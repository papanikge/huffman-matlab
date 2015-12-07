function bench_sourceB_charwise()
% Third requirement of the first assignment.
% Testing source B with a dict based on probabilities from the file.
% George 'papanikge' Papanikolaou CEID 2015

fprintf('Generating the dict based on the file...\n');
[chars probs] = estimate_probs('kwords.txt', 1)
dict = myhuffmandict(chars, probs);

fprintf('Pull the file in...\n');
B = sourceB();
fprintf('Encoding and decoding back to back ...\n');
tic;
for i=1:length(B)
    c = strtrim(B(i,:));
    % Getting a cell of 'correct' characters. Still one-by-one.
    c = mat2cell(c, ones(1,1), ones(1,length(c)));
    % The actual thing.
    c_enc = myhuffmanenco(c, dict);
    c_dec = myhuffmandeco(c_enc, dict);
    % Check whether the decoding is correct.
    if ~isequal(c, c_dec)
        error('Error! Encoded and decoded not matching.')
    end
end
fprintf('Tests passed successfully!!!\n');
toc
