% Camila Rosa (crs94 @GitHub), 2018
% ------------
%   filtband:   Bandpass filter of a signal
%   Usage:      Input the name of the name of the variable
%               in which the signal is stored to filter
%               it using a bandpasss filter
%   Inputs:     
%               data =  [var] Variable in which the signal
%                       is stored
%               fc =    [1x2 array] Cutoff frequency [low high]
%               fs =    [double] Sampling frequency
%               order = [double] Filter order
%               type =  [1~6] Type of filter
%                       (1) FIR;
%                       (2) Yulewalk;
%                       (3) Butterworth;
%                       (4) Chebyshev I;
%                       (5) Chebyshev II;
%                       (6) Elliptic;
%   Output:     none
% ------------

function filtband(data, fc, fs, order, type)

%Creating inital data
N = length(data);   % Number of samples
wn = fc/(fs/2); % Rescaled cutoff freq
ffilt = [0 wn(1) wn(1) wn(2) wn(2) 1];    % Frequency vector
Gfilt = [0 0 1 1 0 0];  % Gain associated w/ ffilt
rp = 3; % Passband ripple in dB
rs = 60;    % Stopband ripple in dB
flag = 0;   % If not plotting is required, set it to 1

% Designing different filters
switch type
    case 1
        disp('... Using FIR filter')
        b = fir2(order, ffilt, Gfilt);   % FIR filter
        a = 1;        
    case 2
        disp('... Using Yulewalk ...')
        [b, a] = yulewalk(order, ffilt, Gfilt); % Yulewalk
    case 3
        disp('... Using Butterworth ...');
        [b, a] = butter(order, wn);  % Butterworth
    case 4
        disp('... Using Chebyshev I ...');
        [b, a] = cheby1(order, rp, wn); % Chebyshev I
    case 5
        disp('... Using Chebyshev II ...');
        [b, a] = cheby2(order, rs, wn); % Chebyshev II
    case 6
        disp('... Using Elliptic ...');
        [b, a] = ellip(order, rp,rs, wn); % Elliptic
    otherwise
        disp('Not defined');
        disp('... Ending function ...')
        flag = 1;
end

if ~flag
    % Applying designed filter to data
    y = filtfilt(b, a, data);

    % Calculating magnitude spectra
    Xorig = abs(fft(data));
    Xfilt = abs(fft(y));

    % Plotting signal
    figure;

    subplot(2, 2, 1);
    t = (0:N-1)/fs; % Creating time vector
    plot(t, data);  % Signal
    ylabel('Amplitude');
    axis([19 21.5 -inf inf]);

    subplot(2, 2, 2);
    t = (0:N-1)/fs; % Creating time vector
    plot(t, y);  % Signal
    ylabel('Amplitude');
    xlabel('Time (s)')
    axis([19 21.5 -inf inf]);

    % Plotting FFT
    %figure;

    subplot(2, 2, 3);
    f = fs*(0:N/4)/N;   % Creating frequency vector
    plot(f, Xorig(1:N/4+1)); % FFT original
    grid on;
    ylabel('|X_{orig}(t)|');

    subplot(2, 2, 4);
    plot(f, Xfilt(1:N/4+1)); % FFT filtered
    grid on;
    ylabel('|X_{filt}(t)|');
    xlabel('Frequecy (Hz)');
end
