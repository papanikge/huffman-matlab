function ar = sourceB()
% source B for the second requirement of the first assignment.
% George 'papanikge' Papanikolaou CEID 2015

ar = [];
fid = fopen('kwords.txt');
line = fgets(fid);
while ischar(line)
    ar = strvcat(ar, strtrim(line));
    line = fgets(fid);
end
fclose(fid);
