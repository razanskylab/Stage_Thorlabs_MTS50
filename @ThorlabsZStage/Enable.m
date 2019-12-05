function Enable(tzs)

	if ~tzs.deviceNET.IsEnabled()
		tzs.deviceNET.Enable();
	else
		fprintf('[ThorlabsZStage] Device is already enabled.\n');
	end

	if ~tzs.deviceNET.IsEnabled()
		error('Could not enable device');
	end

end