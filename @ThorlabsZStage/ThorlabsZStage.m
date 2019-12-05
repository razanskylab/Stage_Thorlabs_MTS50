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

      	POS_MAX = 42;
      	POS_MIN = 0;

      	TPOLLING=250;            % Default polling time
      	TIMEOUTSETTINGS = 7000;
      	TIMEOUTMOVE = 100000;

	end

	properties (SetAccess = private)
		isConnected = 0;
		isHomed = 0;
		serialnumber;
		deviceNET;
		motorSettingsNET;
		currentDeviceSettingsNET;
		deviceInfoNET;
	end

	properties
		pos; % specifies the position of the stage
		controllername;
		stagename;
		controllerdescription;
	end

	methods 
		function ThorlabsZStage=ThorlabsZStage(varargin)
			ThorlabsZStage.Load_DLLs;
			if (nargin == 1)
				fprintf('[ThorlabsZStage] Initialise based on constructor variable.\n');
				if ischar(varargin{1})
					ThorlabsZStage.Connect(varargin{1});
				end
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

		% Moves to position and waits until target positon is reached
		function set.pos(tzs, pos)
			
			if pos > tzs.POS_MAX
				error('Cannot move to this position');
			elseif pos < tzs.POS_MIN
				error('Cannot move to this position');
			else
				try
	            	workDone=tzs.deviceNET.InitializeWaitHandler(); % Initialise Waithandler for timeout
	            	tzs.deviceNET.MoveTo(pos, workDone); % Move device to position via .NET interface
	            	tzs.deviceNET.Wait(tzs.TIMEOUTMOVE);              % Wait for move to finish
          		catch % Device faile to move
              		error(['Unable to Move device ',tzs.serialnumber,' to ',num2str(pos)]);
          		end
			end
					
		end

		function pos = get.pos(tzs)
			 pos=System.Decimal.ToDouble(tzs.deviceNET.Position);
		end

	end



end