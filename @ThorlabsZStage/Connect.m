function Connect(tzs, serialNo)

	tzs.List_Devices();

	if ~tzs.isConnected
        switch(serialNo(1:2))
            case '27'   % Serial number corresponds to KCDWHATEVER
                tzs.deviceNET= ...
                    Thorlabs.MotionControl.KCube.DCServoCLI.KCubeDCServo.CreateKCubeDCServo(serialNo);   
            otherwise % Serial number is not correct
                error('Stage not recognised');
        end     
        tzs.deviceNET.ClearDeviceExceptions(); % Clear device exceptions via .NET interface
        tzs.deviceNET.ConnectDevice(serialNo);
        tzs.deviceNET.Connect(serialNo); % Connect to device via .NET interface, 
        tzs.serialnumber = serialNo;
        try
            if ~tzs.deviceNET.IsSettingsInitialized() % Wait for IsSettingsInitialized via .NET interface
                tzs.deviceNET.WaitForSettingsInitialized(tzs.TIMEOUTSETTINGS);
            end
            if ~tzs.deviceNET.IsSettingsInitialized() % Cannot initialise device
                warning(['Unable to initialise device ',char(serialNo)]);
            end
            tzs.deviceNET.StartPolling(tzs.TPOLLING);   % Start polling via .NET interface
            tzs.deviceInfoNET= tzs.deviceNET.GetDeviceInfo();                    % Get deviceInfo via .NET interface
            tzs.motorSettingsNET  = tzs.deviceNET.LoadMotorConfiguration(serialNo); % Get motorSettings via .NET interface

            % MotDir = Thorlabs.MotionControl.GenericMotorCLI.Settings.RotationDirections.Forwards; % MotDir is enumeration for 'forwards'
            % h.currentDeviceSettingsNET.Rotation.RotationDirection=MotDir;   % Set motor direction to be 'forwards#
        catch % Cannot initialise device
            error(['Catch: Unable to initialise device ',char(serialNo)]);
        end
    else % Device is already connected
        error('Device is already connected.')
    end
    %tzs.Update_Status();   % Update status variables from device
end