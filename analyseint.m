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

function [segment] = analyseint(data, fs)
close all;

%Creating inital data
N = length(data);   % Number of samples
wsize = 256;    % Size of window that selects data
segment = {};

pwrspec = calc_power(data, wsize);    % Calculating power of data
pwrspec = pwrspec/max(pwrspec); % Normalizing values
threshold = mean(pwrspec);  % Defining threshold

plot(pwrspec, 'bo'); hold on;
plot([0 (N/wsize)-1], [threshold threshold], 'r--');
hold off;

k = 1;
n = 1;
figure;
hold on;
while n > length(pwrspec)
    if pwrspec(n) >= threshold
        m = n;
        while pwrspec(m) > threshold
            m = m + 1;
        end
        segment{k} = data(n*wsize:m*wsize);
        plot(n:1/wsize:m, segment{k});
        k = k + 1;
        n = m;
        pause;
    end
end

%figure;
%plot(segment);
%hold on;
%plot([0 N/wsize], [threshold threshold], 'r--');
%hold off;
