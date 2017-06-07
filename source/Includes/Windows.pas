unit Windows;

interface


function CoCreateGuid(var Guid:TGuid):integer; external 'CoCreateGuid@ole32.dll stdcall';
function WindowsFolder: string;
function Program_FilesFolder: String;
function Program_Filesx86Folder: String;
function IsProcessExists(aFilename: String): boolean;

implementation

function WindowsFolder: string; 
begin
  result := WinAPI.GetSpecialFolder(CSIDL_WINDOWS);
end;

function Program_FilesFolder: String;
begin
  result := WinAPI.GetSpecialFolder(CSIDL_PROGRAM_FILES);
end;

function Program_Filesx86Folder: String;
begin
  result := WinAPI.GetSpecialFolder(CSIDL_PROGRAM_FILESX86);
end;

function IsProcess32Exists(aFilename: String): boolean;
begin
  Result := WinAPI.IsProcess32Exists(aFilename);
end;

end.
