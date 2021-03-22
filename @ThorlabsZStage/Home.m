% File: Home.m @ ThorlabsZStage
% Author: Urs Hofmann
% Mail: hofmannu@biomed.ee.ethz.ch
% Date: 26 Feb 2019
% Version: 0.1

% Description: Home stage, required at startup.

function Home(tzs)
	fprintf('[ThorlabsZStage] Homing device... ');
	 	
	tzs.deviceNET.Home(600000);

	fprintf('done!\n');

 	if ~tzs.deviceNET.NeedsHoming
 		fprintf('[ThorlabsZStage] Successfully homed.\n');
 	else
 		error('Could not home device');
 	end

end