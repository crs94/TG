folder = 'D:\CR_Reference\TG\isokinetic\';
ldir = struct2cell(dir(folder));
[R, C] = size(ldir);
m = 0;
for n = 1:C
    if isdir(strcat(folder, ldir{1,n}, '\cont\'))
        if ~strcmp(ldir{1,n}(1), '.')
            m = m + 1;
            pos{m} = load(strcat(folder, ldir{1,n}, '\cont\canal1p.txt'));
            vel{m} = load(strcat(folder, ldir{1,n}, '\cont\canal2v.txt'));
            ten{m} = load(strcat(folder, ldir{1,n}, '\cont\canal3t.txt'));
            emg{m} = load(strcat(folder, ldir{1,n}, '\cont\canal4emg.txt'));
        end
    end
end
        