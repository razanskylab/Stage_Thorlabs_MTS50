% File: Load_DLLs @ ThorlabsZStage
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 27.03.2021

function Load_DLLs(tzs)

	if ~exist(tzs.DEVICEMANAGERCLASSNAME, 'class')
        try   % Load in DLLs if not already loaded
            fprintf('[ThorlabsZStage] Loading general DLLs... ');
            NET.addAssembly([tzs.MOTORPATHDEFAULT, tzs.DEVICEMANAGERDLL]);
            NET.addAssembly([tzs.MOTORPATHDEFAULT, tzs.GENERICMOTORDLL]);
            fprintf('done!\n');
        catch % DLLs did not load
            error('Unable to load .NET assemblies')
        end
    else
        fprintf('[ThorlabsZStage] General DLLs already loaded, using existing ones.\n');
    end    

    if ~exist(tzs.BRUSHEDMOTORCLASSNAME, 'class')
        try   % Load in DLLs if not already loaded
            fprintf('[ThorlabsZStage] Loading DLLs for specific motor... ');
            NET.addAssembly([tzs.MOTORPATHDEFAULT, tzs.BRUSHEDMOTORDLL]); 
            fprintf('done!\n');
        catch % DLLs did not load
            error('Unable to load .NET assemblies')
        end
    else
        fprintf('[ThorlabsZStage] Motor specific DLLs already loaded, using existing ones.\n');
    end

end