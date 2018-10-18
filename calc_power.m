% Camila Rosa (crs94 @GitHub), 2016
% Cristiano Alves (ishiikurisu @GitHub), 2016
% ------------
%   calc_power:	Updates the signal and the queue
%   Usage:      Input the name of the variable in which 
%               the signal is stored and the size of the
%               window that on desires to select
%   Inputs:	
%               data =      [array] Variable in which the signal
%                           is stored
%               wsize =     [double] Size of the window
%   Output:     
%               pwrspec =	[array] Array conatining the power
%                           spectra calculated
% ------------

function [pwrspec] = calc_power(data, wsize)

[data, queue] = update_queue(data, wsize);
n = 1;
pwrspec = 0;

while length(queue) > 0
	pwrspec(n) = sqrt(sum(queue.^2));
	n = n + 1;
	[data, queue] = update_queue(data, wsize);
end
