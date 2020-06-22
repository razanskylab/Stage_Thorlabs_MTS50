% File: Wait_Move.m @ ThorlabsZStage
% Author: Urs Hofmann
% Mail: hofmannu@biomed.ee.ethz.ch
% Date: 16.06.2020

% Description: Waits until movement is finished

function Wait_Move(tzs)
	tzs.deviceNET.Wait(tzs.TIMEOUTMOVE);
end