classdef ThorlabsZStage < handle

	properties (Constant, Hidden)

		% path to DLL files (edit as appropriate)
		MOTORPATHDEFAULT(1, :) char = 'C:\Program Files\Thorlabs\Kinesis\';
		% DLL files to be loaded
		DEVICEMANAGERDLL(1, :) char = 'Thorlabs.MotionControl.DeviceManagerCLI.dll';
		DEVICEMANAGERCLASSNAME(1, :) char = 'Thorlabs.MotionControl.DeviceManagerCLI.DeviceManagerCLI'
		GENERICMOTORDLL(1, :) char = 'Thorlabs.MotionControl.GenericMotorCLI.dll';
		GENERICMOTORCLASSNAME(1, :) char = 'Thorlabs.MotionControl.GenericMotorCLI.GenericMotorCLI';
		BRUSHEDMOTORDLL(1, :) char = 'Thorlabs.MotionControl.KCube.DCServoCLI.dll';  
    BRUSHEDMOTORCLASSNAME(1, :) char ='Thorlabs.MotionControl.KCube.DCServoCLI.KCubeDCServo';
    POS_MAX(1, 1) double = 50;
    POS_MIN(1, 1) double = 0;
    TPOLLING(1, 1) = 250; % Default polling time
    TIMEOUTSETTINGS(1, 1) = 7000;
    TIMEOUTMOVE(1, 1) = 100000;

	end

	properties (SetAccess = private)
		isConnected(1, 1) logical = 0;
		serialnumber(1, :) char;
		deviceNET;
		motorSettingsNET;
		currentDeviceSettingsNET;
		deviceInfoNET;
	end

	properties(Dependent)
		isHomed(1, 1) logical;
	end

	properties
		pos(1, 1) double; % specifies the position of the stage
		controllername;
		stagename;
		controllerdescription;
	end

	methods 
		function ThorlabsZStage=ThorlabsZStage(varargin)
			ThorlabsZStage.Load_DLLs();
			if (nargin == 1)
				fprintf('[ThorlabsZStage] Initialise based on constructor variable.\n');
				if ischar(varargin{1})
					ThorlabsZStage.Connect(varargin{1});
				end
      else
      	serialNumbers = ThorlabsZStage.List_Devices()
      	ThorlabsZStage.Connect(serialNumbers);
      end

      % if stage requires homing, do now
      if ~ThorlabsZStage.isHomed()
      	ThorlabsZStage.Home();
      end
		end

		function delete(tzs)
			if tzs.isConnected
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

		%
		function isHomed = get.isHomed(tzs)
			isHomed = ~tzs.deviceNET.NeedsHoming();
		end

	end



end