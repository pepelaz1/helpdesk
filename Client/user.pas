unit user;

interface

uses global ,SysUtils;

type
 TUserRole = (HD_OBSERVER=1, HD_RESPONSIBLE, HD_NOMINATOR, HD_REGISTRATOR, HD_MANAGER, HD_ADMIN);

 TExtraRoles = (HD_REPORTVIEW=1);
 TExtraRolesSet = set of TExtraRoles;

 TUser = class
 protected
   // Главная роль пользователя
   FRole : TUserRole;

   // Дополнительные роли пользователя
   FExtraRoles : TExtraRolesSet;
 public
   constructor Create;

   // Determine if user is allowed to work with application
   function IsCompetent : boolean;

   // Determine if user is ATOMSIB user
   function IsAtomsibUser : boolean;

   // Returun user's role
   function UserRole : TUserRole;

   // Determine if user is incident owner
   function IsOwner( incident_num : int64)  : boolean;

   // Determine if user is incident responsible
   function IsResponsible( incident_num : int64)  : boolean;


   // Return user name
   function UserName : string;

   property ExtraRoles : TExtraRolesSet read FExtraRoles write FExtraRoles;
 end;

var
  GUser : TUser;

implementation

constructor TUser.Create;
var s: string;
    n : integer;
begin
  Inherited Create;

  // Clarification of user role
  n := 0;
  with Module.OraQuery do
  begin
    SQL.Text := 'select granted_role from user_role_privs';
    Execute;

    FRole := TUserRole(0);
    while not Eof do
    begin
      s := Module.OraQuery.Field(0);
      if s = 'HD_OBSERVER' then n := integer(HD_OBSERVER)
      else if s = 'HD_RESPONSIBLE' then n := integer(HD_RESPONSIBLE)
      else if s = 'HD_NOMINATOR' then n := integer(HD_NOMINATOR)
      else if s = 'HD_REGISTRATOR' then n := integer(HD_REGISTRATOR)
      else if s = 'HD_MANAGER' then n := integer(HD_MANAGER)
      else if s = 'HD_ADMIN' then n := integer(HD_ADMIN)

      else if s = 'HD_REPORTVIEW' then  FExtraRoles := FExtraRoles + [HD_REPORTVIEW];
      Next;

      if integer(FRole) < n then FRole := TUserRole(n);
    end;
  end;



end;

function TUser.IsCompetent : boolean;
begin
  Result := integer(FRole) > 0;
end;

function TUser.IsAtomsibUser : boolean;
var s : string;
begin
  try
    Module.OraQuery.SQL.Text := 'select count(1) from personnel t where lower(t.login) = lower(' + QuotedStr(Module.OraSession.LogonUsername) +')';
    Module.OraQuery.Execute;
  except
    Result := false;
    exit;
  end;


  s := Module.OraQuery.Field(0);
  if StrToInt(s) = 0 then
  begin
    Result := false;
    exit;
  end;
  Result := true;
end;

function TUser.UserRole : TUserRole;
begin
  Result := FRole;
end;


function TUser.IsResponsible( incident_num : int64)  : boolean;
var s : string;
begin
  try
   Module.OraQuery.SQL.Text := 'select t1.worker from personnel t1, incident_card t2 where  t1.id_work = t2.responsible_inc ' +
    ' and lower(t1.login) = lower(user) and t2.num_incident = ' + IntToStr( incident_num );
   s := Module.OraQuery.SQL.Text;
   Module.OraQuery.Execute;
  except
    Result := false;
    exit;
  end;
  if  Module.OraQuery.RowsProcessed = 0 then
  begin
    Result := false;
    exit;
  end;

  Result := true;
end;


function TUser.IsOwner( incident_num : int64)  : boolean;
var s : string;
begin
 try
   Module.OraQuery.SQL.Text := 'select t1.worker from personnel t1, incident_card t2 where t1.id_work = t2.owner_inc  ' +
    ' and lower(t1.login) = lower(user) and t2.num_incident = ' + IntToStr( incident_num );
   s := Module.OraQuery.SQL.Text;
   Module.OraQuery.Execute;
  except
    Result := false;
    exit;
  end;
  if  Module.OraQuery.RowsProcessed = 0 then
  begin
    Result := false;
    exit;
  end;

  Result := true;
end;



function TUser.UserName : string;
begin
  Module.OraQuery.SQL.Text := 'select t.worker from personnel t where lower(t.login) = lower(user)';
  Module.OraQuery.Execute;
  Result := Module.OraQuery.Field(0);
end;

end.
