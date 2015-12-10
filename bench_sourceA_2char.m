function bench_sourceA_2char()
% Fourth requirement of the first assignment.
% Testing source A with a 2-char dict based on computed probabilities.
% George 'papanikge' Papanikolaou CEID 2015

fprintf('Generating the dict...\n');
[eng_couples, eng_couple_probs] = generate_probs(2);
dict = myhuffmandict(eng_couples, eng_couple_probs);

fprintf('Generate source...\n');
A = sourceA(2, 5000);

fprintf('Encoding and decoding back to back ...\n');
tic;
for i=1:length(A)
    c = strtrim(A(i,:));
    % The encoding function needs a cell.
    c = mat2cell(c, 1, 2);
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
