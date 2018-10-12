% Camila Rosa (crs94 @GitHub), 2018
% ------------
%   loadtxt:    Loads the txt files from a database
%   Usage:      Input the name of the directory where
%               the files are stores and the files
%               of the folder ../subject/cont will be
%               loaded into a variable to be save as .mat
%   Inputs:     
%               folder =    [char] Path of the directory 
%                           where the files are stored
%   Output:     none
% ------------

function loadtxt(folder)

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
save('emgdata.mat', 'pos', 'vel', 'ten', 'emg');
clear all;
close all;
