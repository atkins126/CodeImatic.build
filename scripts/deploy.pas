Uses Xcopy,  Delphi, stringutils, Windows, NSIS;

var 
  BDSCommonDir,
  BDSBPLDir,
  BDSDir: String;
  CompilerVersion: integer;
  PackageVersion: string;
  InitialiseTask,
  CopyingFilesTask,
  BuildNSISProjectTask,
  CheckExistsorCreateFoldersTask: tTask;
  DeploymentDir: string;
  DeploymentBinDir: string;
  DeploymentPluginsDir: string;
  DeploymentIncludesDir: string;
  BuildDir: string;
  PluginsDir: string;
  IncludesDir: string;
  BDSRedistDir: string;
  Platform: String;
  PascalScript_CoreDir: string;
  
  function GetPackageFilename(aPartFilename: String): string;
  begin
    result := format('%s%s.bpl', [aPartFilename, PackageVersion]);
  end;

  procedure CheckExistsorCreateFolders;
  begin
   Output.log('Check Exists or Create Folders ...');
    
    If not Folder.Exists(DeploymentDir +  'bin') then 
     if Folder.CreateFolder(DeploymentDir +  'bin') then
        Output.log('Create Folder: ' + DeploymentDir +  'bin')
     else    
        RaiseException(erCustomError, format('Failed creating folder [%s]', [DeploymentDir +  'bin'] )); 
    
    If not Folder.Exists(DeploymentDir +  'bin\plugins\') then 
      if Folder.CreateFolder(DeploymentDir +  'bin\plugins') then
        Output.log('Create Folder: ' + DeploymentDir +  'bin\plugins')
     else    
        RaiseException(erCustomError, format('Failed creating folder [%s]', [DeploymentDir +  'bin\plugins'] )); 

     If not Folder.Exists(DeploymentDir +  'Includes') then 
      if Folder.CreateFolder(DeploymentDir +  'Includes') then
        Output.log('Create Folder: ' + DeploymentDir +  'Includes')
     else    
        RaiseException(erCustomError, format('Failed creating folder [%s]', [DeploymentDir +  'Includes'] )); 

    if File.Exists(DeploymentDir + 'ZautomaticSetup.exe') then 
      if not File.Delete(DeploymentDir + 'ZautomaticSetup.exe') then
        RaiseException(erCustomError, SysErrorMessage()); 
           
        
  end;

  procedure CopyingFiles;
  begin
    Output.log('Copying Files ...');

    // Bin Directory

    if not Xcopy(BuildDir +'ZAutoCore.bpl', DeploymentBinDir) then
     RaiseException(erCustomError, 'Failed copying ' + BuildDir + 'ZAutoCore.bpl'); 

    if not Xcopy(BuildDir +'Zautomatic.config', DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BuildDir + 'Zautomatic.config'); 

     if not Xcopy(BuildDir +'Zautomatic.exe', DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BuildDir + 'Zautomatic.exe');    

    if not Xcopy(BDSBPLDir + GetPackageFilename('jvCore'), DeploymentBinDir) then
     RaiseException(erCustomError, 'Failed copying ' + BDSBPLDir + GetPackageFilename('jvCore')); 

    if not Xcopy(BDSBPLDir + GetPackageFilename('NovusCodeLibrary_Core'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSBPLDir + GetPackageFilename('NovusCodeLibrary_Core')); 

   if not Xcopy(BDSBPLDir + GetPackageFilename('NovusCodeLibrary_Env'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSBPLDir + GetPackageFilename('NovusCodeLibrary_Env')); 

   if not Xcopy(BDSBPLDir + GetPackageFilename('NovusCodeLibrary_Parser'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSBPLDir + GetPackageFilename('NovusCodeLibrary_Parser')); 

    if not Xcopy(BDSRedistDir + GetPackageFilename('rtl'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSRedistDir + GetPackageFilename('rtl'));

    if not Xcopy(BDSRedistDir + GetPackageFilename('vclimg'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSRedistDir + GetPackageFilename('vclimg'));

    if not Xcopy(BDSRedistDir + GetPackageFilename('dbrtl'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSRedistDir + GetPackageFilename('dbrtl'));

    if not Xcopy(BDSRedistDir + GetPackageFilename('xmlrtl'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSRedistDir + GetPackageFilename('xmlrtl'));

    if not Xcopy(BDSRedistDir + GetPackageFilename('dbrtl'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSRedistDir + GetPackageFilename('dbrtl'));

    if not Xcopy(BDSRedistDir + GetPackageFilename('inet'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSRedistDir + GetPackageFilename('inet'));        

    if not Xcopy(BDSRedistDir + GetPackageFilename('DBXCommonDriver'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSRedistDir + GetPackageFilename('DBXCommonDriver'));    

    if not Xcopy(BDSRedistDir + GetPackageFilename('vcl'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSRedistDir + GetPackageFilename('vcl'));   

    if not Xcopy(BDSRedistDir + GetPackageFilename('soaprtl'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSRedistDir + GetPackageFilename('soaprtl'));

    if not Xcopy(BDSRedistDir + GetPackageFilename('vclx'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSRedistDir + GetPackageFilename('vclx'));      

    if not Xcopy(BDSBPLDir + GetPackageFilename('jvSystem'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSBPLDir + GetPackageFilename('jvSystem'));           
   
    if not Xcopy(BDSBPLDir + GetPackageFilename('jclvcl'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSBPLDir + GetPackageFilename('jclvcl'));  

    if not Xcopy(BDSBPLDir + GetPackageFilename('NovusCodeLibrary_XML'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSBPLDir + GetPackageFilename('NovusCodeLibrary_XML'));     

    if not Xcopy(BDSBPLDir + GetPackageFilename('NovusCodeLibrary_log'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSBPLDir + GetPackageFilename('NovusCodeLibrary_log'));    

    if not Xcopy(BDSBPLDir + GetPackageFilename('NovusCodeLibrary_plugin'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSBPLDir + GetPackageFilename('NovusCodeLibrary_plugin'));  

    if not Xcopy(BDSBPLDir + GetPackageFilename('jcl'), DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSBPLDir + GetPackageFilename('jcl'));   

    if not Xcopy(PascalScript_CoreDir + 'PascalScript_Core_D22.bpl', DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + PascalScript_CoreDir + 'PascalScript_Core_D22.bpl');     
     
    if not Xcopy( BDSDir + 'bin\borlndmm.dll', DeploymentBinDir) then
      RaiseException(erCustomError, 'Failed copying ' + BDSDir + 'bin\borlndmm.dll'); 

   // Plugins Directory
   if not Xcopy(PluginsDir +'Task.dll', DeploymentPluginsDir) then
      RaiseException(erCustomError, 'Failed copying ' + PluginsDir +'Task.dll'); 
   
   if not Xcopy(PluginsDir +'Zip.dll', DeploymentPluginsDir) then
      RaiseException(erCustomError, 'Failed copying ' + PluginsDir +'Zip.dll');
      

    // Includes Directory
 
    if not Xcopy(IncludesDir +'AWS.zas', DeploymentIncludesDir) then
      RaiseException(erCustomError, 'Failed copying ' +IncludesDir +'AWS.zas');

    if not Xcopy(IncludesDir +'NSIS.zas', DeploymentIncludesDir) then
      RaiseException(erCustomError, 'Failed copying ' +IncludesDir +'NSIS.zas');  

    if not Xcopy(IncludesDir +'cmd.zas', DeploymentIncludesDir) then
      RaiseException(erCustomError, 'Failed copying ' +IncludesDir +'cmd.zas');  

    if not Xcopy(IncludesDir +'delphi.zas', DeploymentIncludesDir) then
      RaiseException(erCustomError, 'Failed copying ' +IncludesDir +'delphi.zas');  
  
    if not Xcopy(IncludesDir +'dotNET.zas', DeploymentIncludesDir) then
      RaiseException(erCustomError, 'Failed copying ' +IncludesDir +'dotNET.zas'); 

    if not Xcopy(IncludesDir +'msbuild.zas', DeploymentIncludesDir) then
      RaiseException(erCustomError, 'Failed copying ' +IncludesDir +'msbuild.zas');   

   if not Xcopy(IncludesDir +'numutils.zas', DeploymentIncludesDir) then
      RaiseException(erCustomError, 'Failed copying ' +IncludesDir +'numutils.zas');    

   if not Xcopy(IncludesDir +'stringutils.zas', DeploymentIncludesDir) then
      RaiseException(erCustomError, 'Failed copying ' +IncludesDir +'stringutils.zas');        

   if not Xcopy(IncludesDir +'powershell.zas', DeploymentIncludesDir) then
      RaiseException(erCustomError, 'Failed copying ' +IncludesDir +'powershell.zas');    

   if not Xcopy(IncludesDir +'Windows.zas', DeploymentIncludesDir) then
      RaiseException(erCustomError, 'Failed copying ' +IncludesDir +'Windows.zas');     

   if not Xcopy(IncludesDir +'Xcopy.zas', DeploymentIncludesDir) then
      RaiseException(erCustomError, 'Failed copying ' +IncludesDir +'Xcopy.zas');     
      
    
      
  end;

  
  procedure Initialise;
  begin
    Output.log('Initialise ...');

    CompilerVersion := DELPHIXE8 ;

    Platform := ProjectConfig.Getproperty('Platform');
   

    BDSDir :=  GetBDSDIR(CompilerVersion );
    Output.log('BDS Directory:' + BDSDir );

    BDSCommonDir := GetBDSCommonDir(CompilerVersion );
    Output.log('BDS Common Directory:' + BDSCommonDir );
    
    PackageVersion := GetDelphiPackageVersion(CompilerVersion);
    Output.log('Delphi Package Version:' + PackageVersion );

    BDSBPLDir := BDSCommonDir + 'bpl\';
    Output.log('BDS BPL Directory:' + BDSBPLDir );

    DeploymentDir := File.IncludeTrailingPathDelimiter(ProjectConfig.Getproperty('DeploymentDir'));
    Output.log('Depoyment Directory:' +DeploymentDir );

    PascalScript_CoreDir := File.IncludeTrailingPathDelimiter(ProjectConfig.Getproperty('PascalScript_CoreDir'));
    Output.log('PascalScript_Core Directory:' +PascalScript_CoreDir); 

    DeploymentBinDir := DeploymentDir +  'bin\';
    Output.log('Deployment Bin Directory:' +DeploymentBinDir );

    DeploymentPluginsDir := DeploymentBinDir + 'plugins\';
    Output.log('Deployment Plugins Directory:' +DeploymentPluginsDir  );

    DeploymentIncludesDir := DeploymentDir + 'Includes\';
    Output.log('Deployment Includes Directory:' +DeploymentIncludesDir  );


    BDSRedistDir := BDSDir + 'Redist\'+ Platform + '\';
    Output.log('Depoyment Bin Directory:' +DeploymentBinDir );

    BuildDir := ProjectConfig.Getproperty('BuildDir'); 
    Output.log('Build Directory:' +BuildDir);

    
    PluginsDir := File.IncludeTrailingPathDelimiter(ProjectConfig.Getproperty('PluginsDir'));
    Output.log('Plugins Directory:' +PluginsDir);

    IncludesDir :=File.IncludeTrailingPathDelimiter(ProjectConfig.Getproperty('IncludesDir'));
    Output.log('Includes Directory:' +IncludesDir);

 end;

procedure BuildNSISProject;
begin
  Output.log('Build NSIS Project...');
    
  if MakeNSIS(DeploymentDir + 'ZutomaticSetup.nsi', '') <> 0 then
    RaiseException(erCustomError, 'Failed to build NSIS: ' +SysErrorMessage); 
end;

begin
  Output.log('Building ...');
  
  InitialiseTask := Task.AddTask('Initialise');
  if Not Assigned(InitialiseTask) then
    RaiseException(erCustomError, 'not assigned InitialiseTask'); 
  InitialiseTask.Criteria.Failed.Abort := True;

  CheckExistsorCreateFoldersTask := Task.AddTask('CheckExistsorCreateFolders');
  if Not Assigned(CheckExistsorCreateFoldersTask) then
    RaiseException(erCustomError, 'not assigned CheckExistsorCreateFoldersTask'); 
  CheckExistsorCreateFoldersTask.Criteria.Failed.Abort := True;

  CopyingFilesTask := Task.AddTask('CopyingFiles');
  if Not Assigned(CopyingFilesTask) then
    RaiseException(erCustomError, 'not assigned CopyingFilesTask'); 
  CopyingFilesTask.Criteria.Failed.Abort := True;

  BuildNSISProjectTask := Task.AddTask('BuildNSISProject');
  if Not Assigned(BuildNSISProjectTask) then
    RaiseException(erCustomError, 'not assigned BuildNSISProject'); 
  BuildNSISProjectTask.Criteria.Failed.Abort := True;


  if not Task.RunTargets(['Initialise', 'CheckExistsorCreateFolders', 'CopyingFiles', 'BuildNSISProject']) then 
    RaiseException(erCustomError, 'missing procedure.'); 
   

  
end.