% Camila Rosa (crs94 @GitHub), 2018
% ------------
%   filtlow:   	Lowpass filter of a signal
%   Usage:      Input the name of the name of the variable
%               in which the signal is stored to filter
%               it using a lowpasss filter
%   Inputs:     
%               data =  [var] Variable in which the signal
%                       is stored
%               fc =    [double] Cutoff frequency
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

function filtlow(data, fc, fs, order, type)

%Creating inital data
N = length(data);   % Number of samples
ffilt = [0 fc fc 1];    % Frequency vector
Gfilt = [1 1 0 0];  % Gain associated w/ ffilt
rp = 3; % Passband ripple in dB
rs = 60;    % Stopband ripple in dB
wn = fc/(fs/2); % Rescaled cutoff freq

% Designing different filters
switch type
    case 1
        disp('\n... Using FIR filter')
        b = fir2(order, ffilt, Gfilt);   % FIR filter
        a = 1;        
    case 2
        disp('\n... Using Yulewalk')
        [b, a] = yulewalk(order, f, G); % Yulewalk
    case 3
        disp('\n... Using Butterworth');
        [b, a] = butter(order, wn);  % Butterworth
    case 4
        disp('\n... Using Chebyshev I');
        [b, a] = cheby1(order, rp, wn); % Chebyshev I
    case 5
        disp('\n... Using Chebyshev II');
        [b, a] = cheby2(order, rs, wn); % Chebyshev II
    case 6
        disp('\n... Using Elliptic');
        [b, a] = ellip(order, rp,rs, wn); % Elliptic
    otherwise
        disp('\nNot defined');
end

% Applying designed filter to data
y = filtfilt(b, a, data);

% Calculating magnitude spectra
Xorig = abs(fft(data));
Xfilt = abs(fft(y));

% Plotting signal
figure;

subplot(2, 1, 1);
t = (0:N-1)/fs; % Creating time vector
plot(t, data);  % Signal
ylabel('Amplitude');

subplot(2, 1, 2);
t = (0:N-1)/fs; % Creating time vector
plot(t, y);  % Signal
ylabel('Amplitude');
xlabel('Time (s)')

% Plotting signl and FFT
figure;

subplot(2, 1, 1);
f = fs*(0:N/4)/N;   % Creating frequency vector
plot(f, Xorig(1:N/4+1)); % FFT original
grid on;
ylabel('|X_{orig}(t)|');

subplot(2, 1, 2);
plot(f, Xfilt(1:N/4+1)); % FFT filtered
grid on;
ylabel('|X_{filt}(t)|');
xlabel('Frequecy (Hz)');
