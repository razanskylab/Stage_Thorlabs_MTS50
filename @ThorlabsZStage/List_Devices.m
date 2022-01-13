% Function: List_Devices.m @ ThorlabsZStage.m
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 22.03.2021

% Description: should list all devices

function validSerials = List_Devices(tzs)

	 % thorlabsstage.loaddlls; % Load DLLs
	Thorlabs.MotionControl.DeviceManagerCLI.DeviceManagerCLI.BuildDeviceList();  % Build device list
	serialNumbersNet = Thorlabs.MotionControl.DeviceManagerCLI.DeviceManagerCLI.GetDeviceList(); % Get device list
	serialNumbers=cell(ToArray(serialNumbersNet)); % Convert serial numbers to cell array

	% make sure to only return the ones which do start with 27
	validSerials = [];
	noValidSerials = 0;
	for iSerial = 1:length(serialNumbers)
		currSerial = serialNumbers{iSerial};
		if ~isempty(currSerial)
			if strcmp(currSerial(1:2), '27')
				noValidSerials = noValidSerials + 1;
				validSerials{noValidSerials} = currSerial;
			end
		end
	end

	% if we did not find anything useful in this shithole, let people know that
	% we are angry
	if (noValidSerials == 0)
		warning('I could not find any device with a correct serial number');
	end

	% if there is a unique device, return ID instead of cell
	if (noValidSerials == 1)
		validSerials = validSerials{1};
	end

end