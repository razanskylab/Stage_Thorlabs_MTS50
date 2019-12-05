% File: Home.m @ ThorlabsZStage
% Author: Urs Hofmann
% Mail: hofmannu@biomed.ee.ethz.ch
% Date: 26 Feb 2019
% Version: 0.1

% Description: Home stage, required at startup.

function Home(tzs)
	if tzs.deviceNET.NeedsHoming
		fprintf('[ThorlabsZStage] Homing device.\n');
	 	
		tzs.deviceNET.Home(600000);

	 	if ~tzs.deviceNET.NeedsHoming
	 		fprintf('[ThorlabsZStage] Successfully homed.\n');
	 	else
	 		error('Could not home device');
	 	end

	 	tzs.isHomed = 1;
	 else
	 	fprintf('[ThorlabsZStage] Homing not required.\n');
	 	tzs.isHomed = 1;
	 end

end