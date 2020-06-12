dim filesys

set filesys=CreateObject("Scripting.FileSystemObject")

If filesys.FileExists("C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\EngineConfig.json") Then

  filesys.CopyFile "C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\EngineConfig.json", "C:\Siemens\ARM\Bin\Configuration\",TRUE
End If

If filesys.FileExists("C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\PrimingConfiguration.json") Then

  filesys.CopyFile "C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\PrimingConfiguration.json", "C:\Siemens\ARM\Bin\Configuration\",TRUE
End If
  
If filesys.FileExists("C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\SimulatorSettings.json") Then

  filesys.CopyFile "C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\SimulatorSettings.json", "C:\Siemens\ARM\Bin\Configuration\",TRUE
End If
  
 If filesys.FileExists("C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\MechanismAlignmentConfig.json") Then

  filesys.CopyFile "C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\MechanismAlignmentConfig.json", "F:\SystemSpecificConfigs\",TRUE
End If
  
If filesys.FileExists("C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\PhotometerDarkRead.json") Then

  filesys.CopyFile "C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\PhotometerDarkRead.json", "F:\SystemSpecificConfigs\",TRUE
End If
  
If filesys.FileExists("C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\MechanismCalibrationData.json") Then
  filesys.CopyFile "C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\MechanismCalibrationData.json", "F:\SystemSpecificConfigs\",TRUE
  
End If


filesys.CopyFile "C:\Siemens\ARM\Bin\Configuration\Overwrite for Test Fixture\Sequences\*.*", "C:\Siemens\ARM\Bin\Configuration\Sequences\",TRUE
strFilename = "C:\Siemens\ARM\Bin\Configuration\StateManagerConfiguration.json"
strFind = "EnterDiagnosticsOnInstallation" &Chr(34) &": true"
strReplace = "EnterDiagnosticsOnInstallation" &Chr(34) &": false"
FindAndReplace strFilename,strFind,strReplace

strFind = "EnterDiagnosticsOnInitialization" &Chr(34) &": true"
strReplace = "EnterDiagnosticsOnInitialization" &Chr(34) &": false"
FindAndReplace strFilename,strFind,strReplace

strFind = "EnterDiagnosticsOnInstallation" &Chr(34) &": true"
strReplace = "EnterDiagnosticsOnInstallation" &Chr(34) &": false"
FindAndReplace strFilename,strFind,strReplace

function FindAndReplace(strFilename, strFind, strReplace)
    Set inputFile = CreateObject("Scripting.FileSystemObject").OpenTextFile(strFilename, 1)
    strInputFile = inputFile.ReadAll
    inputFile.Close
    Set inputFile = Nothing
    Set outputFile = CreateObject("Scripting.FileSystemObject").OpenTextFile(strFilename,2,true)
    outputFile.Write Replace(strInputFile, strFind, strReplace)
    outputFile.Close
    Set outputFile = Nothing
end function 

strFilename = "C:\Siemens\ARM\Bin\Configuration\StateManagerConfiguration.json"

dim x
x=msgbox("Configuration Complete" ,0, "Copy Files")
set x = nothing