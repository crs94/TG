% Camila Rosa (crs94 @GitHub), 2018
% ------------
%   plotfft:	Plots the magnitude spectra of a signal
%   Usage:      Input the name of the name of the variable
%               in which the signal is stored to calculate
%               the FFT and plot its magnitude spectra
%   Inputs:     
%               data =  [var] Variable in which the signal
%                       is stored
%               fs =    [double] Sampling frequency
%   Output:     none
% ------------

function plotfft(data, fs)

N = length(data);
y = fft(data);  % Calculating FFT

% Vector rescaling of sawtooth waveform
P2 = abs(y/N);
P1 = P2(1:N/4+1);
P1(2:end-1) = 2*P1(2:end-1);

% Plotting signl and FFT
figure;

subplot(2, 1, 1);
t = (0:N-1)/fs; % Creating time vector
plot(t, data);  % Signal
ylabel('Amplitude');
xlabel('Time (s)')

subplot(2, 1, 2);
f = fs*(0:N/4)/N;   % Creating frequency vector
plot(f, P1);    % FFT
ylabel('|X(t)|');
xlabel('Frequecy (Hz)');

