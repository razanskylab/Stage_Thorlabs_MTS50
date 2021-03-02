% File Load_DLLs.m @ ThorLabsZStage
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 03.02.2021

% Description: Loads all required DLLs

function Load_DLLs(tzs)

	if ~exist(tzs.DEVICEMANAGERCLASSNAME, 'class')
        try   % Load in DLLs if not already loaded
            fprintf('[ThorlabsZStage] Loading general DLLs...\n');
            NET.addAssembly([tzs.MOTORPATHDEFAULT, tzs.DEVICEMANAGERDLL]);
            NET.addAssembly([tzs.MOTORPATHDEFAULT, tzs.GENERICMOTORDLL]);
        catch % DLLs did not load
            error('Unable to load .NET assemblies')
        end
    else
        fprintf('[ThorlabsZStage] General DLLs already loaded, using existing ones.\n');
    end    

    if ~exist(tzs.BRUSHEDMOTORCLASSNAME, 'class')
        try   % Load in DLLs if not already loaded
            fprintf('[ThorlabsZStage] Loading DLLs for specific motor...\n');
            NET.addAssembly([tzs.MOTORPATHDEFAULT, tzs.BRUSHEDMOTORDLL]); 
        catch % DLLs did not load
            error('Unable to load .NET assemblies')
        end
    else
        fprintf('[ThorlabsZStage] Motor specific DLLs already loaded, using existing ones.\n');
    end

end