% File: Disconnect.m @ ThorlabsZStage.m
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 20.03.2021 

function Disconnect(tzs)

	fprintf(['[ThorlabsZStage] Disconnecting device ',tzs.serialnumber, '... ']);
    % tzs.isConnected = tzs.deviceNET.IsConnected(); % Update isconnected flag via .NET interface
    if tzs.isConnected
        try
            tzs.deviceNET.StopPolling();  % Stop polling device via .NET interface
            tzs.deviceNET.Disconnect();   % Disconnect device via .NET interface
        catch
            error(['Unable to disconnect device ',tzs.serialnumber]);
        end
        tzs.isConnected = 0;  % Update internal flag to say device is no longer connected
    else % Cannot disconnect because device not connected
        error('Device not connected, so how should I dosconnect it?.')
    end    

    fprintf('done!\n');
end