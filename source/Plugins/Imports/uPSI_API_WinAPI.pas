unit uPSI_API_WinAPI;
{
This file has been generated by UnitParser v0.7, written by M. Knight
and updated by NP. v/d Spek and George Birbilis. 
Source Code from Carlo Kok has been used to implement various sections of
UnitParser. Components of ROPS are used in the construction of UnitParser,
code implementing the class wrapper is taken from Carlo Kok's conv utility

}
interface
 

 
uses
   SysUtils
  ,Classes
  ,uPSComponent
  ,uPSRuntime
  ,uPSCompiler
  ;
 
type 
(*----------------------------------------------------------------------------*)
  TPSImport_API_WinAPI = class(TPSPlugin)
  public
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;
 
 
{ compile-time registration functions }
procedure SIRegister_TAPI_WinAPI(CL: TPSPascalCompiler);
procedure SIRegister_API_WinAPI(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_TAPI_WinAPI(CL: TPSRuntimeClassImporter);
procedure RIRegister_API_WinAPI(CL: TPSRuntimeClassImporter);

procedure Register;

implementation


uses
   APIBase
  ,ShlObj
  ,Windows
  ,API_WinAPI
  ;
 
 
procedure Register;
begin
  RegisterComponents('Pascal Script', [TPSImport_API_WinAPI]);
end;

(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_TAPI_WinAPI(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TAPIBase', 'TAPI_WinAPI') do
  with CL.AddClassN(CL.FindClass('TAPIBase'),'TAPI_WinAPI') do
  begin
    RegisterMethod('Function GetSpecialFolder( const CSIDL : integer) : string');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_API_WinAPI(CL: TPSPascalCompiler);
begin
  SIRegister_TAPI_WinAPI(CL);
 CL.AddConstantN('CSIDL_ADMINTOOLS','LongInt').SetInt( 48);
 CL.AddConstantN('CSIDL_ALTSTARTUP','LongInt').SetInt( 29);
 CL.AddConstantN('CSIDL_APPDATA','LongInt').SetInt( 26);
 CL.AddConstantN('CSIDL_BITBUCKET','LongInt').SetInt( 10);
 CL.AddConstantN('CSIDL_CDBURN_AREA','LongInt').SetInt( 59);
 CL.AddConstantN('CSIDL_COMMON_ADMINTOOLS','LongInt').SetInt( 47);
 CL.AddConstantN('CSIDL_COMMON_ALTSTARTUP','LongInt').SetInt( 30);
 CL.AddConstantN('CSIDL_COMMON_APPDATA','LongInt').SetInt( 35);
 CL.AddConstantN('CSIDL_COMMON_DESKTOPDIRECTORY','LongInt').SetInt( 25);
 CL.AddConstantN('CSIDL_COMMON_DOCUMENTS','LongInt').SetInt( 46);
 CL.AddConstantN('CSIDL_COMMON_FAVORITES','LongInt').SetInt( 31);
 CL.AddConstantN('CSIDL_COMMON_MUSIC','LongInt').SetInt( 53);
 CL.AddConstantN('CSIDL_COMMON_PICTURES','LongInt').SetInt( 54);
 CL.AddConstantN('CSIDL_COMMON_PROGRAMS','LongInt').SetInt( 23);
 CL.AddConstantN('CSIDL_COMMON_STARTMENU','LongInt').SetInt( 22);
 CL.AddConstantN('CSIDL_COMMON_STARTUP','LongInt').SetInt( 24);
 CL.AddConstantN('CSIDL_COMMON_TEMPLATES','LongInt').SetInt( 45);
 CL.AddConstantN('CSIDL_COMMON_VIDEO','LongInt').SetInt( 55);
 CL.AddConstantN('CSIDL_COMPUTERSNEARME','LongInt').SetInt( 61);
 CL.AddConstantN('CSIDL_CONNECTIONS','LongInt').SetInt( 49);
 CL.AddConstantN('CSIDL_CONTROLS','LongInt').SetInt( 3);
 CL.AddConstantN('CSIDL_COOKIES','LongInt').SetInt( 33);
 CL.AddConstantN('CSIDL_DESKTOP','LongInt').SetInt( 0);
 CL.AddConstantN('CSIDL_DESKTOPDIRECTORY','LongInt').SetInt( 16);
 CL.AddConstantN('CSIDL_DRIVES','LongInt').SetInt( 17);
 CL.AddConstantN('CSIDL_FAVORITES','LongInt').SetInt( 6);
 CL.AddConstantN('CSIDL_FONTS','LongInt').SetInt( 20);
 CL.AddConstantN('CSIDL_HISTORY','LongInt').SetInt( 34);
 CL.AddConstantN('CSIDL_INTERNET','LongInt').SetInt( 1);
 CL.AddConstantN('CSIDL_INTERNET_CACHE','LongInt').SetInt( 32);
 CL.AddConstantN('CSIDL_LOCAL_APPDATA','LongInt').SetInt( 28);
 CL.AddConstantN('CSIDL_MYDOCUMENTS','LongInt').SetInt( 5);
 CL.AddConstantN('CSIDL_MYMUSIC','LongInt').SetInt( 13);
 CL.AddConstantN('CSIDL_MYPICTURES','LongInt').SetInt( 39);
 CL.AddConstantN('CSIDL_MYVIDEO','LongInt').SetInt( 14);
 CL.AddConstantN('CSIDL_NETHOOD','LongInt').SetInt( 19);
 CL.AddConstantN('CSIDL_NETWORK','LongInt').SetInt( 18);
 CL.AddConstantN('CSIDL_PERSONAL','LongInt').SetInt( 5);
 CL.AddConstantN('CSIDL_PHOTOALBUMS','LongInt').SetInt( 69);
 CL.AddConstantN('CSIDL_PLAYLISTS','LongInt').SetInt( 63);
 CL.AddConstantN('CSIDL_PRINTERS','LongInt').SetInt( 4);
 CL.AddConstantN('CSIDL_PRINTHOOD','LongInt').SetInt( 27);
 CL.AddConstantN('CSIDL_PROFILE','LongInt').SetInt( 40);
 CL.AddConstantN('CSIDL_PROGRAM_FILES','LongInt').SetInt( 38);
 CL.AddConstantN('CSIDL_PROGRAM_FILESX86','LongInt').SetInt( 42);
 CL.AddConstantN('CSIDL_PROGRAM_FILES_COMMON','LongInt').SetInt( 43);
 CL.AddConstantN('CSIDL_PROGRAM_FILES_COMMONX86','LongInt').SetInt( 44);
 CL.AddConstantN('CSIDL_PROGRAMS','LongInt').SetInt( 2);
 CL.AddConstantN('CSIDL_RECENT','LongInt').SetInt( 8);
 CL.AddConstantN('CSIDL_RESOURCES','LongInt').SetInt( 56);
 CL.AddConstantN('CSIDL_RESOURCES_LOCALIZED','LongInt').SetInt( 57);
 CL.AddConstantN('CSIDL_SAMPLE_MUSIC','LongInt').SetInt( 64);
 CL.AddConstantN('CSIDL_SAMPLE_PLAYLISTS','LongInt').SetInt( 65);
 CL.AddConstantN('CSIDL_SAMPLE_PICTURES','LongInt').SetInt( 66);
 CL.AddConstantN('CSIDL_SAMPLE_VIDEOS','LongInt').SetInt( 67);
 CL.AddConstantN('CSIDL_SENDTO','LongInt').SetInt( 9);
 CL.AddConstantN('CSIDL_STARTMENU','LongInt').SetInt( 11);
 CL.AddConstantN('CSIDL_STARTUP','LongInt').SetInt( 7);
 CL.AddConstantN('CSIDL_SYSTEM','LongInt').SetInt( 37);
 CL.AddConstantN('CSIDL_SYSTEMX86','LongInt').SetInt( 41);
 CL.AddConstantN('CSIDL_TEMPLATES','LongInt').SetInt( 21);
 CL.AddConstantN('CSIDL_WINDOWS','LongInt').SetInt( 36);
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure RIRegister_TAPI_WinAPI(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TAPI_WinAPI) do
  begin
    RegisterMethod(@TAPI_WinAPI.GetSpecialFolder, 'GetSpecialFolder');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_API_WinAPI(CL: TPSRuntimeClassImporter);
begin
  RIRegister_TAPI_WinAPI(CL);
end;

 
 
{ TPSImport_API_WinAPI }
(*----------------------------------------------------------------------------*)
procedure TPSImport_API_WinAPI.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_API_WinAPI(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_API_WinAPI.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_API_WinAPI(ri);
end;
(*----------------------------------------------------------------------------*)
 
 
end.