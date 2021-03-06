; Script generated by the ?????? ?????? Inno Setup.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=Helpdesk client
AppVerName=Helpdesk client 1.5
AppPublisher=SXK
DefaultDirName=c:\program files\Helpdesk client
DefaultGroupName=Helpdesk client
AllowNoIcons=yes
OutputDir=D:\Work\HD\Install
OutputBaseFilename=helpdesk
SetupIconFile=D:\Work\HD\Client\hd.ico
Compression=lzma
SolidCompression=yes
UsePreviousAppDir=no


[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Dirs]
Name: "{app}";  Permissions: users-modify;


[Files]
Source: "D:\Work\HD\Client\hdclient.exe"; DestDir: "{app}";   Flags: ignoreversion
Source: "D:\Work\HD\Client\FreeImage.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Work\HD\Client\FreeImagePlus.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Work\HD\Client\hd.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Work\HD\Client\readme.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Work\HD\Client\msvcr71.dll"; DestDir: "{sys}"; Flags:  ignoreversion onlyifdoesntexist
Source: "D:\Work\HD\Client\SyncAD.dll"; DestDir: "{app}"; Flags:  ignoreversion
Source: "D:\Work\HD\Client\SyncAD.xml"; DestDir: "{app}"; Flags:  ignoreversion


[Icons]
Name: "{group}\Helpdesk client"; Filename: "{app}\hdclient.exe"
Name: "{group}\{cm:UninstallProgram,Helpdesk client}"; Filename: "{uninstallexe}"
Name: "{userdesktop}\Helpdesk client"; Filename: "{app}\hdclient.exe"; Tasks: desktopicon; WorkingDir: "{app}"
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Helpdesk client"; Filename: "{app}\hdclient.exe"; Tasks: quicklaunchicon ;WorkingDir: "{app}"

[Run]
Filename: "{app}\hdclient.exe"; WorkingDir: "{app}"; Description: "{cm:LaunchProgram,Helpdesk client}"; Flags: nowait postinstall skipifsilent

