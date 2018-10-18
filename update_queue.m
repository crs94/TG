% Camila Rosa (crs94 @GitHub), 2016
% Cristiano Alves (ishiikurisu @GitHub), 2016
% ------------
%   update_queue:   Updates the signal and the queue
%   Usage:          Input the name of the variable in which 
%                   the signal is stored and the size of the
%                   window that on desires to select
%   Inputs:     
%                   data =  [array] Variable in which the signal
%                           is stored
%                   wsize = [double] Size of the window
%   Output:     
%                   data =  [array] Variable in which the updated
%                           signal is stored
%                   queue = [array] Window selected
% ------------

function [data, queue] = update_queue(data, wsize)

queue = zeros(1, wsize); % Create empty array

if length(data) == 0
	queue = [];
else
	if length(data) >= wsize
		queue = data(1:wsize);
		data = data((wsize+1):length(data));
	elseif length(data) < wsize
		queue = data(1:length(data));
		data = data((wsize+1):length(data));
	end		
end
