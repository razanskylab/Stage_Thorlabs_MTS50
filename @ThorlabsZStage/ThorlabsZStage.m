% File: ThorlabsZStage.m @ ThorlabsZStage
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 02.02.2021

% Dscription: An interface to the small z stage.

classdef ThorlabsZStage < handle

	properties (Constant, Hidden)

		% path to DLL files (edit as appropriate)
		MOTORPATHDEFAULT='C:\Program Files\Thorlabs\Kinesis\';
		% DLL files to be loaded
		DEVICEMANAGERDLL='Thorlabs.MotionControl.DeviceManagerCLI.dll';
		DEVICEMANAGERCLASSNAME='Thorlabs.MotionControl.DeviceManagerCLI.DeviceManagerCLI'
		GENERICMOTORDLL='Thorlabs.MotionControl.GenericMotorCLI.dll';
		GENERICMOTORCLASSNAME='Thorlabs.MotionControl.GenericMotorCLI.GenericMotorCLI';
		BRUSHEDMOTORDLL='Thorlabs.MotionControl.KCube.DCServoCLI.dll';  
    BRUSHEDMOTORCLASSNAME='Thorlabs.MotionControl.KCube.DCServoCLI.KCubeDCServo';
    POS_MAX(1, 1) double = 50; % describes the hardware limit of the stage [mm]
    POS_MIN(1, 1) double = 0; % describes the hardware limit of the stage
    TPOLLING(1, 1) = 250; % Default polling time
    TIMEOUTSETTINGS(1, 1) = 7000;
    TIMEOUTMOVE(1, 1) = 100000;

	end

	properties (SetAccess = private)
		isConnected(1, 1) logical = 0;
		isHomed(1, 1) logical = 0;
		serialnumber;
		deviceNET;
		motorSettingsNET;
		currentDeviceSettingsNET;
		deviceInfoNET;
		SERIAL_START = '27'; % all devices of this type start their serial number like this
	end

	properties
		pos(1, 1) double; % specifies the position of the stage
		controllername;
		stagename;
		controllerdescription;
		soft_max(1, 1) = 50; % adaptable software limit of movement range [mm]
		soft_min(1, 1) = 0; % adaptable software limit of movement range [mm]
	end

	methods 
		function ThorlabsZStage = ThorlabsZStage(varargin)
			ThorlabsZStage.Load_DLLs;
			if (nargin == 1)
				fprintf('[ThorlabsZStage] Initialise based on constructor variable.\n');
				if ischar(varargin{1})
					ThorlabsZStage.Connect(varargin{1});
				else
					error('Manually passed serial number should be a char string');					
				end
			elseif (nargin == 0)
				% try to automatically find stage
				serialNumber = ThorlabsZStage.List_Devices();
				if ~isempty(serialNumber)
					ThorlabsZStage.Connect(serialNumber{1});
				else
					error('Could not autoconnect to any device');
				end	
			else
				error('Invalid number of input arguments passed');				
			end
      
      ThorlabsZStage.Home();
		end

		function delete(tzs)
			if tzs.deviceNET.IsConnected
				tzs.Disconnect;
			end
		end

		Load_DLLs(tzs);
		Connect(tzs, serialNo);
		serialNumbers = List_Devices(tzs);
		Enable(tzs);
		Identify(tzs);
		Home(tzs);
		Move_No_Wait(tzs, pos);
		Wait_Move(tzs);

		% Moves to position and waits until target positon is reached
		function set.pos(tzs, pos)
	    tzs.Move_No_Wait(pos); % Initialize movement
	    tzs.Wait_Move(); % Wait for move to finish
		end

		% read stage position from device
		function pos = get.pos(tzs)
			 pos = System.Decimal.ToDouble(tzs.deviceNET.Position);
		end

		function set.soft_max(tzs, soft_max)
			if (tzs.soft_max > tzs.POS_MAX)
				warning('Max. software limit defined beyond stage movement range');
			end
			tzs.soft_max = soft_max;
		end

		function set.soft_min(tzs, soft_min)
			if (tzs.soft_min < soft_min)
				warning('Min. software limit defined beyond stage movement range');
			end
			tzs.soft_min = soft_min;
		end

	end



end