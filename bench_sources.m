function bench_sources()
% Second requirement of the first assignment.
% George 'papanikge' Papanikolaou CEID 2015

eng_letter = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'};
eng_letter_prob = [.08167 .01492 .02782 .04253 .12702 .02228 .02015 .06094 .06966 .00153 .00772 .04025 .02406 .06749 .07507 .01929 .00095 .05987 .06327 .09056 .02758 .00978 .02361 .00150 .01974 .00074];
dict = myhuffmandict(eng_letter, eng_letter_prob);

fprintf('Generating from source A...\n');
A = sourceA(1, 10000);
tic;
fprintf('Encoding and decoding back to back ...\n');
for i=1:length(A)
    % getting a cell of characters
    c = mat2cell(A(i,:), ones(1,1), ones(1,6));
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
