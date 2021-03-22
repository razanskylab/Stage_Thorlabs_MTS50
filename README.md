# Stage_Thorlabs_MTS50
Object oriented MATLAB interface for 50 mm motorized linear stage.

Interface used to control motorized stage by Thorlabs [Thorlabs stage](https://www.thorlabs.com/newgrouppage9.cfm?objectgroup_id=3002).

## Requirements
*  Kinesis software installed
*  MATLAB installed
*  Corresponding Brushed motor controller
*  Connection to computer through USB

## Usage

*  Pass serial number of your stage initialization of class, if you don't, the software will try to automatically find the device
*  Replace MOTORPATHDEFAULT by your installation path of Kinesis

```
T = ThorlabsZStage(serialnumber);

% move stage to a position
T.pos = 25; % 0 ... 50 mm

% read current stage position
currPos = T.pos; % mm

% home stage
T.Home();

% identify controller by letting display blink
T.Identify();

% manually connect or disconnect device using
T.Connect(serialnumber);
T.Disconnect();
% but this is usually handled by class constructor and desctructor
```


## Support

If you need other features implemented feel free to contract me: hofmannu@ethz.ch