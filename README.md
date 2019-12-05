# Stage_Thorlabs_MTS50
Object oriented MATLAB interface for 50 mm motorized linear stage.

Interface used to control motorized stage by Thorlabs [Thorlabs stage](https://www.thorlabs.com/newgrouppage9.cfm?objectgroup_id=3002).

# Requirements
*  Kinesis software installed
*  MATLAB installed
*  Corresponding Brushed motor controller
*  Connection to computer through USB

# Usage

*  pass serial number of your stage initialization of class
`
T = ThorlabsZStage(serialnumber);

% move stage to a position
T.pos = 25; % 0 ... 50 mm

% read current stage position
currPos = T.pos; % mm

% Set velocity of stage during movement (this command does not induce movement)
T.vel = 10; % mm / s

% read velocity (not currently but the one used when moving)
currVel = T.vel;

% home stage
T.Home();

% identify controller by letting display blink
T.Identify();
`



