% File: Move_No_Wait.m @ ThorlabsZStage
% Author: Urs Hofmann
% Mail: hofmannu@biomed.ee.ethz.ch
% Date: 16.06.2020

% Initializes movement of stage without waiting for finish.

function Move_No_Wait(tzs, pos)

	if pos > tzs.POS_MAX
		error('Cannot move to this position');
	elseif pos < tzs.POS_MIN
		error('Cannot move to this position');
	else
		try
      workDone = tzs.deviceNET.InitializeWaitHandler(); % Initialise Waithandler for timeout
      tzs.deviceNET.MoveTo(pos, workDone); % Move device to position via .NET interface
    catch % Device faile to move
    	error(['Unable to Move device ',tzs.serialnumber,' to ',num2str(pos)]);
    end
	end

end