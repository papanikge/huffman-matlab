function bench_sourceB_2char()
% Fifth requirement of the first assignment.
% Testing source B with a 2-char dict based on the file and more...
% George 'papanikge' Papanikolaou CEID 2015

fprintf('>> First: Checking against computed probabilities.\n');
fprintf('Generating the dict...\n');
[eng_couples, eng_couple_probs] = generate_probs(2);
[dict, avg] = myhuffmandict(eng_couples, eng_couple_probs);
fprintf('Average Huffman code length is %f bits.\n', avg);

fprintf('Pulling the file in...\n');
B = sourceB();
fprintf('Encoding and decoding back to back ...\n');
tic;
for i=1:length(B)
    % `c` is a word of the text. We're gonna need to skip words that we don't
    % have symbols for. (or chars that are not couples)
    c = strtrim(B(i,:));
    c = lower(c);
    % For some god forsaken reason I can't chain clauses.
    if length(c) == 1
        continue;
    end
    if strfind(c, '-')
        continue;
    end
    if strfind(c, '.')
        continue;
    end
    if strfind(c, '/')
        continue;
    end
    if strfind(c, char(39))
        continue;
    end
    % We're deleting extra 'stray' characters, because we just have the eng-alphabet pairs.
    if mod(length(c), 2) ~= 0
        c(length(c)) = [];
    end
    % Splitting to two by two chars cell.
    c = mat2cell(c, ones(1,1), ones(1,length(c)/2)*2);
    % The actual thing.
    c_enc = myhuffmanenco(c, dict);
    c_dec = myhuffmandeco(c_enc, dict);
    % Check whether the decoding is correct.
    if ~isequal(c, c_dec)
        c
        c_dec
        error('Error! Encoded and decoded not matching.')
    end
end
fprintf('Tests passed successfully!!!\n');
toc
fprintf('\n');

fprintf('>> Second: Checking against probabilities based on the file itself.\n');
fprintf('Generating the dict...\n');
[eng_couples eng_couple_probs] = estimate_probs('kwords.txt', 2);
[dict, avg] = myhuffmandict(eng_couples, eng_couple_probs);
fprintf('Average Huffman code length is %f bits.\n', avg);

fprintf('Pulling the file in...\n');
B = sourceB();
fprintf('Encoding and decoding back to back ...\n');
tic;
for i=1:length(B)
    % Safety
    c = strtrim(B(i,:));
    if length(c) == 1
        continue;
    end
    if mod(length(c), 2) ~= 0
        c = [c, ' '];
    end
    % Splitting to two by two char cells.
    c = mat2cell(c, ones(1,1), ones(1,length(c)/2)*2);
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
