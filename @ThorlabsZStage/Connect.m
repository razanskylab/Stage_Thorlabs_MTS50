% File: Connect.m @ ThorlabsZStage
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 22.03.2021

% Description: opens up a fucking connection to this disgusting device

function Connect(tzs, serialNo)

    % check if serial number appears valid
    if ~strcmp(serialNo(1:2), '27')
        error('Invalid serial number passed');
    end

	if ~tzs.isConnected
        fprintf("[ThorlabsZStage] Connecting to device %s... ", serialNo);
        tStart = tic();
        tzs.deviceNET= ...
            Thorlabs.MotionControl.KCube.DCServoCLI.KCubeDCServo.CreateKCubeDCServo(serialNo);   
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
        tzs.isConnected = 1;
        fprintf("done after %.1f sec!\n", toc(tStart));
    else % Device is already connected
        error('Device is already connected.')
    end
    %tzs.Update_Status();   % Update status variables from device
end