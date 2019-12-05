function Disconnect(tzs)

	fprintf(['[ThorlabsZStage] Disconnecting device ',tzs.serialnumber, '.\n']);
    tzs.isConnected = tzs.deviceNET.IsConnected(); % Update isconnected flag via .NET interface
    if tzs.isConnected
        try
            tzs.deviceNET.StopPolling();  % Stop polling device via .NET interface
            tzs.deviceNET.Disconnect();   % Disconnect device via .NET interface
        catch
            error(['Unable to disconnect device ',tzs.serialnumber]);
        end
        tzs.isConnected=false;  % Update internal flag to say device is no longer connected
    else % Cannot disconnect because device not connected
        error('Device not connected, so how should I dosconnect it?.')
    end    

end