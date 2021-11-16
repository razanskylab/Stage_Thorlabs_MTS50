# Stage_Thorlabs_MTS50
Object oriented MATLAB interface for 50 mm motorized linear stage.

Interface used to control motorized stage by Thorlabs [Thorlabs stage](https://www.thorlabs.com/newgrouppage9.cfm?objectgroup_id=3002).

## Requirements

*  [Kinesis software](https://www.thorlabs.com/software_pages/ViewSoftwarePage.cfm?Code=Motion_Control) installed
*  MATLAB installed
*  Corresponding brushed motor controller
*  Connection to computer through USB

## Usage

Before you try starting the stage directly from MATLAB, I would quickly recommend opening the Kinesis software and trying the main functionalities from there. It is very likely that if the control through Kinesis fails that also the control through the MATLAB interface won't work. Also for the first connection it is useful to write down the serial number and pass it to the stage during initialization. Later you can try to automatically detect the stage through the `List_Devices()` function but for the beginning, pass it manually. Dont forget to replace the variable MOTORPATHDEFAULT in the class definition file located in `@ThorlabsZStage/ThorlabsZStage.m` by your installation path of Kinesis.

The software is written in an object oriented way. Please use the example below to get started.

```
T = ThorlabsZStage(serialnumber); // class constructot (will open connection to stage

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
