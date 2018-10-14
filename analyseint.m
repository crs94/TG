% Camila Rosa (crs94 @GitHub), 2018
% ------------
%   analyseint: Analyse the FFT of each rep of the signal
%   Usage:      Input the name of the variable in which 
%               the signal is stored cut it by the intervals
%               that were previouly determined and calculate
%               the magnitude spectra, MDS and max amplitude
%   Inputs:     
%               data =  [var] Variable in which the signal
%                       is stored
%               fs =    [double] Sampling frequency
%               inter =	[matrix] Matrix containing the
%                       intervals of each serie of rep
%   Output:     none
% ------------

function analyseint(data, fs, inter)

%Creating inital data
N = length(data);   % Number of samples
inter = inter*fs;   % Transforming time to sample
subint = diff(inter, 1, 2)/10;   % Creating subintervals

% Craeting series subdivisions (repetitions)
for n = 1:4
    subcut{n} = inter(n,1):subint(n):inter(n,2);
end

for n = 1:4
    for m = 1:10
        mdf((n-1)*10+m) = medfreq(data(subcut{n}(m):subcut{n}(m+1)));
    end
end

figure;
plot(mdf);
