unit uPSI_API_RESTClient;
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
  TPSImport_API_RESTClient = class(TPSPlugin)
  public
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;
 
 
{ compile-time registration functions }
procedure SIRegister_TAPI_RESTClient(CL: TPSPascalCompiler);
procedure SIRegister_TRESTClient(CL: TPSPascalCompiler);
procedure SIRegister_API_RESTClient(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_TAPI_RESTClient(CL: TPSRuntimeClassImporter);
procedure RIRegister_TRESTClient(CL: TPSRuntimeClassImporter);
procedure RIRegister_API_RESTClient(CL: TPSRuntimeClassImporter);

procedure Register;

implementation


uses
   APIBase
  ,API_Output
  ,IdSSLOpenSSL
  ,IdHttp
  ,IdStack
  ,IdGlobal
  ,IdURI
  ,API_RESTClient
  ;
 
 
procedure Register;
begin
  RegisterComponents('Pascal Script', [TPSImport_API_RESTClient]);
end;

(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_TAPI_RESTClient(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TAPIBase', 'TAPI_RESTClient') do
  with CL.AddClassN(CL.FindClass('TAPIBase'),'TAPI_RESTClient') do
  begin
    RegisterMethod('Constructor Create( aAPI_Output : tAPI_Output)');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TRESTClient(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TPersistent', 'TRESTClient') do
  with CL.AddClassN(CL.FindClass('TPersistent'),'TRESTClient') do
  begin
    RegisterMethod('Constructor Create');
    RegisterMethod('Procedure AddHeader( aName, aValue : UTF8String)');
    RegisterMethod('Procedure AddQueryString( aName, aValue : UTF8String)');
    RegisterProperty('Content_type', 'String', iptrw);
    RegisterProperty('ResponseCode', 'Integer', iptr);
    RegisterProperty('ResponseText', 'string', iptr);
    RegisterProperty('ErrorCode', 'Integer', iptr);
    RegisterProperty('ErrorMessage', 'String', iptr);
    RegisterProperty('UserAgent', 'string', iptrw);
    RegisterProperty('AcceptCharset', 'string', iptrw);
    RegisterProperty('Accept', 'string', iptrw);
    RegisterMethod('Function Post( aUrl : string; aSource : UTF8String; var aResponseContent : UTF8String) : boolean');
    RegisterMethod('Function Get( aUrl : string; var aResponseContent : UTF8String) : boolean');
    RegisterMethod('Function Delete( aUrl : string; var aResponseContent : UTF8String) : boolean');
    RegisterMethod('Function Put( aUrl : string; aSource : UTF8String) : boolean');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_API_RESTClient(CL: TPSPascalCompiler);
begin
  CL.AddTypeS('THTTPMethods', '( httpGET, httpPOST, httpPUT, httpDELETE, httpPA'
   +'THCH )');
  SIRegister_TRESTClient(CL);
  SIRegister_TAPI_RESTClient(CL);
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure TRESTClientAccept_W(Self: TRESTClient; const T: string);
begin Self.Accept := T; end;

(*----------------------------------------------------------------------------*)
procedure TRESTClientAccept_R(Self: TRESTClient; var T: string);
begin T := Self.Accept; end;

(*----------------------------------------------------------------------------*)
procedure TRESTClientAcceptCharset_W(Self: TRESTClient; const T: string);
begin Self.AcceptCharset := T; end;

(*----------------------------------------------------------------------------*)
procedure TRESTClientAcceptCharset_R(Self: TRESTClient; var T: string);
begin T := Self.AcceptCharset; end;

(*----------------------------------------------------------------------------*)
procedure TRESTClientUserAgent_W(Self: TRESTClient; const T: string);
begin Self.UserAgent := T; end;

(*----------------------------------------------------------------------------*)
procedure TRESTClientUserAgent_R(Self: TRESTClient; var T: string);
begin T := Self.UserAgent; end;

(*----------------------------------------------------------------------------*)
procedure TRESTClientErrorMessage_R(Self: TRESTClient; var T: String);
begin T := Self.ErrorMessage; end;

(*----------------------------------------------------------------------------*)
procedure TRESTClientErrorCode_R(Self: TRESTClient; var T: Integer);
begin T := Self.ErrorCode; end;

(*----------------------------------------------------------------------------*)
procedure TRESTClientResponseText_R(Self: TRESTClient; var T: string);
begin T := Self.ResponseText; end;

(*----------------------------------------------------------------------------*)
procedure TRESTClientResponseCode_R(Self: TRESTClient; var T: Integer);
begin T := Self.ResponseCode; end;

(*----------------------------------------------------------------------------*)
procedure TRESTClientContent_type_W(Self: TRESTClient; const T: String);
begin Self.Content_type := T; end;

(*----------------------------------------------------------------------------*)
procedure TRESTClientContent_type_R(Self: TRESTClient; var T: String);
begin T := Self.Content_type; end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TAPI_RESTClient(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TAPI_RESTClient) do
  begin
    RegisterConstructor(@TAPI_RESTClient.Create, 'Create');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TRESTClient(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TRESTClient) do
  begin
    RegisterVirtualConstructor(@TRESTClient.Create, 'Create');
    RegisterMethod(@TRESTClient.AddHeader, 'AddHeader');
    RegisterMethod(@TRESTClient.AddQueryString, 'AddQueryString');
    RegisterPropertyHelper(@TRESTClientContent_type_R,@TRESTClientContent_type_W,'Content_type');
    RegisterPropertyHelper(@TRESTClientResponseCode_R,nil,'ResponseCode');
    RegisterPropertyHelper(@TRESTClientResponseText_R,nil,'ResponseText');
    RegisterPropertyHelper(@TRESTClientErrorCode_R,nil,'ErrorCode');
    RegisterPropertyHelper(@TRESTClientErrorMessage_R,nil,'ErrorMessage');
    RegisterPropertyHelper(@TRESTClientUserAgent_R,@TRESTClientUserAgent_W,'UserAgent');
    RegisterPropertyHelper(@TRESTClientAcceptCharset_R,@TRESTClientAcceptCharset_W,'AcceptCharset');
    RegisterPropertyHelper(@TRESTClientAccept_R,@TRESTClientAccept_W,'Accept');
    RegisterMethod(@TRESTClient.Post, 'Post');
    RegisterMethod(@TRESTClient.Get, 'Get');
    RegisterMethod(@TRESTClient.Delete, 'Delete');
    RegisterMethod(@TRESTClient.Put, 'Put');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_API_RESTClient(CL: TPSRuntimeClassImporter);
begin
  RIRegister_TRESTClient(CL);
  RIRegister_TAPI_RESTClient(CL);
end;

 
 
{ TPSImport_API_RESTClient }
(*----------------------------------------------------------------------------*)
procedure TPSImport_API_RESTClient.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_API_RESTClient(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_API_RESTClient.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_API_RESTClient(ri);
end;
(*----------------------------------------------------------------------------*)
 
 
end.