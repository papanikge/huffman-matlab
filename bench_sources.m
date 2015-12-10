function bench_sources()
% Second requirement of the first assignment.
% George 'papanikge' Papanikolaou CEID 2015

fprintf('Generating dict...');
[eng_letters, eng_letter_probs] = generate_probs(1);
[dict, avg] = myhuffmandict(eng_letters, eng_letter_probs);
fprintf('Average Huffman code length is %f bits.\n', avg);

fprintf('Generating from source A...\n');
A = sourceA(1, 10000);
tic;
fprintf('Encoding and decoding back to back ...\n');
for i=1:length(A)
    % getting a cell of characters
    c = mat2cell(A(i,:), ones(1,1), ones(1,1));
    c_enc = myhuffmanenco(c, dict);
    c_dec = myhuffmandeco(c_enc, dict);
    % Check whether the decoding is correct.
    if ~isequal(c, c_dec)
        error('Error! Encoded and decoded not matching.')
    end
end
fprintf('Source A checking passed successfully!!!\n\n');
toc

fprintf('Generating from source B...\n');
B = sourceB();
fprintf('Encoding and decoding back to back ...\n');
tic;
for i=1:length(B)
    c = strtrim(B(i,:));
    % Compromise #1: Check for and remove invalid characters.
    k = 1;
    while k <= length(c)
        if isalpha_num(c(k)) == 0
            c(k) = [];
        else
            k = k + 1;
        end
    end
    % Compromise #2: converting all letters to lowercase.
    c = lower(c);
    % Getting a cell of 'correct' characters.
    c = mat2cell(c, ones(1,1), ones(1,length(c)));
    % The actual thing.
    c_enc = myhuffmanenco(c, dict);
    c_dec = myhuffmandeco(c_enc, dict);
    % Check whether the decoding is correct.
    if ~isequal(c, c_dec)
        error('Error! Encoded and decoded not matching.')
    end
end
fprintf('Source B checking passed successfully!!!\n');
toc
