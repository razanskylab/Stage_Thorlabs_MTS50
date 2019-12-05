function Update_Status(tzs)

	tzs.isConnected=boolean(tzs.deviceNET.IsConnected());   % update isconncted flag
	tzs.serialnumber=char(tzs.deviceNET.DeviceID);          % update serial number
	tzs.controllername=char(tzs.deviceInfoNET.Name);        % update controleller name          
	tzs.controllerdescription=char(tzs.deviceInfoNET.Description);  % update controller description
	tzs.stagename=char(tzs.motorSettingsNET.DeviceSettingsName);    % update stagename
	% thorlabsstage.pos=System.Decimal.ToDouble(thorlabsstage.deviceNET.Position);   % Read current device position

end