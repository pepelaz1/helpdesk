unit ADSLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 18.01.2006 9:26:40 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Work\HP\ADS\ads.dll (1)
// LIBID: {6B2422C1-0BD3-4A85-A4BC-B16828AC3B7D}
// LCID: 0
// Helpfile: 
// HelpString: ADS 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
// Errors:
//   Error creating palette bitmap of (TAdsObj) : Server d:\Work\Hp\Ads\ads.dll contains no icons
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  ADSLibMajorVersion = 1;
  ADSLibMinorVersion = 0;

  LIBID_ADSLib: TGUID = '{6B2422C1-0BD3-4A85-A4BC-B16828AC3B7D}';

  IID_IAdsObj: TGUID = '{A355B8B1-ED3C-4C43-B996-90ABD8DB4417}';
  CLASS_AdsObj: TGUID = '{C7AA3A3D-BE5D-4A1C-B257-A1002B7A6176}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IAdsObj = interface;
  IAdsObjDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  AdsObj = IAdsObj;


// *********************************************************************//
// Interface: IAdsObj
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A355B8B1-ED3C-4C43-B996-90ABD8DB4417}
// *********************************************************************//
  IAdsObj = interface(IDispatch)
    ['{A355B8B1-ED3C-4C43-B996-90ABD8DB4417}']
    procedure SyncronizeUsersAndGroups; safecall;
    procedure SetCredentials(const strUserName: WideString; const strPassword: WideString; 
                             const strDB: WideString); safecall;
    procedure SyncronizeInfrastructure; safecall;
  end;

// *********************************************************************//
// DispIntf:  IAdsObjDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A355B8B1-ED3C-4C43-B996-90ABD8DB4417}
// *********************************************************************//
  IAdsObjDisp = dispinterface
    ['{A355B8B1-ED3C-4C43-B996-90ABD8DB4417}']
    procedure SyncronizeUsersAndGroups; dispid 1;
    procedure SetCredentials(const strUserName: WideString; const strPassword: WideString; 
                             const strDB: WideString); dispid 2;
    procedure SyncronizeInfrastructure; dispid 3;
  end;

// *********************************************************************//
// The Class CoAdsObj provides a Create and CreateRemote method to          
// create instances of the default interface IAdsObj exposed by              
// the CoClass AdsObj. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAdsObj = class
    class function Create: IAdsObj;
    class function CreateRemote(const MachineName: string): IAdsObj;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TAdsObj
// Help String      : AdsObj Class
// Default Interface: IAdsObj
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TAdsObjProperties= class;
{$ENDIF}
  TAdsObj = class(TOleServer)
  private
    FIntf:        IAdsObj;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TAdsObjProperties;
    function      GetServerProperties: TAdsObjProperties;
{$ENDIF}
    function      GetDefaultInterface: IAdsObj;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IAdsObj);
    procedure Disconnect; override;
    procedure SyncronizeUsersAndGroups;
    procedure SetCredentials(const strUserName: WideString; const strPassword: WideString; 
                             const strDB: WideString);
    procedure SyncronizeInfrastructure;
    property DefaultInterface: IAdsObj read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TAdsObjProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TAdsObj
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TAdsObjProperties = class(TPersistent)
  private
    FServer:    TAdsObj;
    function    GetDefaultInterface: IAdsObj;
    constructor Create(AServer: TAdsObj);
  protected
  public
    property DefaultInterface: IAdsObj read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoAdsObj.Create: IAdsObj;
begin
  Result := CreateComObject(CLASS_AdsObj) as IAdsObj;
end;

class function CoAdsObj.CreateRemote(const MachineName: string): IAdsObj;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AdsObj) as IAdsObj;
end;

procedure TAdsObj.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C7AA3A3D-BE5D-4A1C-B257-A1002B7A6176}';
    IntfIID:   '{A355B8B1-ED3C-4C43-B996-90ABD8DB4417}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TAdsObj.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IAdsObj;
  end;
end;

procedure TAdsObj.ConnectTo(svrIntf: IAdsObj);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TAdsObj.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TAdsObj.GetDefaultInterface: IAdsObj;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TAdsObj.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TAdsObjProperties.Create(Self);
{$ENDIF}
end;

destructor TAdsObj.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TAdsObj.GetServerProperties: TAdsObjProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TAdsObj.SyncronizeUsersAndGroups;
begin
  DefaultInterface.SyncronizeUsersAndGroups;
end;

procedure TAdsObj.SetCredentials(const strUserName: WideString; const strPassword: WideString; 
                                 const strDB: WideString);
begin
  DefaultInterface.SetCredentials(strUserName, strPassword, strDB);
end;

procedure TAdsObj.SyncronizeInfrastructure;
begin
  DefaultInterface.SyncronizeInfrastructure;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TAdsObjProperties.Create(AServer: TAdsObj);
begin
  inherited Create;
  FServer := AServer;
end;

function TAdsObjProperties.GetDefaultInterface: IAdsObj;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TAdsObj]);
end;

end.
