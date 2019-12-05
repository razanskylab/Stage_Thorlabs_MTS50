function serialNumbers = List_Devices(tzs)

	 % thorlabsstage.loaddlls; % Load DLLs
    Thorlabs.MotionControl.DeviceManagerCLI.DeviceManagerCLI.BuildDeviceList();  % Build device list
    serialNumbersNet = Thorlabs.MotionControl.DeviceManagerCLI.DeviceManagerCLI.GetDeviceList(); % Get device list
    serialNumbers=cell(ToArray(serialNumbersNet)); % Convert serial numbers to cell array
	
end