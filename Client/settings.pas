unit settings;

interface

uses inifiles, sysutils, global, Classes;

type
   TSettings = class
     protected
        // Settings file
        FStrIniFile : string;
        FIniFile : TIniFile;
     public

        constructor Create( strFile : string );

        procedure Load; virtual; abstract;
        procedure Save; virtual; abstract;

        property IniFile : string read FStrIniFile write FStrIniFile;

   end;

   TCommonSettings = class ( TSettings )
     protected
       // Main settings
       FLastLogin : string;
       FrLastDB : string;

     public

        procedure Load; override;
        procedure Save; override;

        property LastLogin : string read FLastLogin write FLastLogin;
        property LastDB : string read FrLastDB write FrLastDB;
   end;


   TGeneralSettings = class ( TSettings )
     protected
        // ?????????? ??????? ?? ??????? ?????????????? ?????????
        FIncidentMonths : integer;

        // Count of filters for main form
        FMainFiltersCount : integer;
        FMainFiltersCurrent : integer;
        FMainFilters : array [0..100] of string;

        // Main form columns
        FColumns : array [1..COLUMNS_COUNT] of integer;

        // Main form filter settings
        FNumIncident : string;
        FNumIncidentOp : integer;
        FStatus : integer;
        FStatusOp : integer;
        FInitiator : string;
        FInitiatorOp : integer;
        FOwner : string;
        FOwnerOp : integer;
        FResponsible : string;
        FResponsibleOp : integer;
        FElement : string;
        FElementOp : integer;
        FCreationDate : string;
        FCreationDateOp : integer;
        FFixDate : string;
        FFixDateOp : integer;
        FClassIncident : string;
        FClassIncidentOp : integer;
        FTypeClass0 : string;
        FTypeClass0Op : integer;
        FScale : integer;
        FScaleOp : integer;
        FPriority : string;
        FPriorityOp : integer;
        FCustom : string;
        FIncType : integer;
        FIncTypeOp : integer;


        // Initiator form filter
        FInitiator2 : string;
        FInitiator2Op : integer;
        FDescr : string;
        FDescrOp : integer;
        FLogin : string;
        FLoginOp : integer;
        FEmail : string;
        FEmailOp : integer;
        FPhone : string;
        FPhoneOp : integer;
        FAddress : string;
        FAddressOp : integer;

        // Element form filter
        FElement2 : string;
        FElement2Op : integer;
        FRoom : string;
        FRoomOp : integer;
        FPhone2 : string;
        FPhone2Op : integer;

        // Responsible form filter
        FClassIncident2 : string;
        FClassIncident2Op : integer;
        FResponsible2 : string;
        FResponsible2Op : integer;

        // Class incident form filter
        FTypeClass : string;
        FTypeClassOp : integer;
        FClassIncident3 : string;
        FClassIncident3Op : integer;
        FClassDesc : string;
        FClassDescOp : integer;
        FCategory : string;
        FCategoryOp : integer;

        FClassSortedBy : string;
        FClassSortOrder : integer;

        procedure SetColumns(i,value : integer);
        function GetColumns(i : integer) : integer;
        procedure SetMainFilters(i : integer; value : string);
        function GetMainFilters(i : integer) : string;

     public

        procedure Load; override;
        procedure Save; override;
        procedure LoadMain( name : string );
        procedure SaveMain( name : string );
        procedure DeleteMain( name : string );

        property IncidentMonths : integer read FIncidentMonths write FIncidentMonths;

        property MainFiltersCount : integer read FMainFiltersCount write FMainFiltersCount;
        property MainFiltersCurrent : integer read FMainFiltersCurrent write FMainFiltersCurrent;
        property Columns[i : integer] : integer read GetColumns write SetColumns;
        property MainFilters[i : integer] : string read GetMainFilters write SetMainFilters;

        property NumIncident : string read FNumIncident write FNumIncident;
        property NumIncidentOp : integer read FNumIncidentOp write FNumIncidentOp;
        property Status : integer read FStatus write FStatus;
        property StatusOp : integer read FStatusOp write FStatusOp;
        property Initiator : string read FInitiator write FInitiator;
        property InitiatorOp : integer read FInitiatorOp write FInitiatorOp;
        property Owner : string read FOwner write FOwner;
        property OwnerOp : integer read FOwnerOp write FOwnerOp;
        property Responsible : string read FResponsible write FResponsible;
        property ResponsibleOp : integer read FResponsibleOp write FResponsibleOp;
        property Element : string read FElement write FElement;
        property ElementOp : integer read FElementOp write FElementOp;
        property CreationDate : string read FCreationDate write FCreationDate;
        property CreationDateOp : integer read FCreationDateOp write FCreationDateOp;
        property FixDate : string read FFixDate write FFixDate;
        property FixDateOp : integer read FFixDateOp write FFixDateOp;
        property ClassIncident : string read FClassIncident write FClassIncident;
        property ClassIncidentOp : integer read FClassIncidentOp write FClassIncidentOp;
        property TypeClass0 : string read FTypeClass0 write FTypeClass0;
        property TypeClass0Op : integer read FTypeClass0Op write FTypeClass0Op;
        property Scale : integer read FScale write FScale;
        property ScaleOp : integer read FScaleOp write FScaleOp;
        property Priority : string read FPriority write FPriority;
        property PriorityOp : integer read FPriorityOp write FPriorityOp;
        property IncType : integer read FIncType write FIncType;
        property IncTypeOp : integer read FIncTypeOp write FIncTypeOp;
        property Custom : string read FCustom write FCustom;

        property Initiator2 : string read FInitiator2 write FInitiator2;
        property Initiator2Op : integer read FInitiator2Op write FInitiator2Op;
        property Descr : string read FDescr write FDescr;
        property DescrOp : integer read FDescrOp write FDescrOp;
        property Login : string read  FLogin write FLogin;
        property LoginOp : integer read FLoginOp write FLoginOp;
        property Email : string read FEmail write FEmail;
        property EmailOp : integer read FEmailOp write FEmailOp;
        property Phone : string read FPhone write FPhone;
        property PhoneOp : integer read FPhoneOp write FPhoneOp;
        property Address : string read FAddress write FAddress;
        property AddressOp : integer read FAddressOp write FAddressOp;


        property Element2 : string read FElement2 write FElement2;
        property Element2Op : integer read FElement2Op write FElement2Op;
        property Room : string read FRoom write FRoom;
        property RoomOp : integer read FRoomOp write FRoomOp;
        property Phone2 : string read FPhone2 write FPhone2;
        property Phone2Op : integer read FPhone2Op write FPhone2Op;

        property ClassIncident2 : string read FClassIncident2 write FClassIncident2;
        property ClassIncident2Op : integer read FClassIncident2Op write FClassIncident2Op;
        property Responsible2 : string read FResponsible2 write FResponsible2;
        property Responsible2Op : integer read FResponsible2Op write FResponsible2Op;


        property TypeClass : string read FTypeClass write FTypeClass;
        property TypeClassOp : integer read FTypeClassOp write FTypeClassOp;
        property ClassIncident3 : string read FClassIncident3 write FClassIncident3;
        property ClassIncident3Op : integer read FClassIncident3Op write FClassIncident3Op;
        property ClassDesc : string read FClassDesc write FClassDesc;
        property ClassDescOp : integer read FClassDescOp write FClassDescOp;
        property Category : string read FCategory write FCategory;
        property CategoryOp : integer read FCategoryOp write FCategoryOp;

        property ClassSortedBy : string read FClassSortedBy write FClassSortedBy;
        property ClassSortOrder : integer read FClassSortOrder write FClassSortOrder;
   end;
var
  GSettings : TGeneralSettings;
  GCommonSettings : TCommonSettings;

implementation


constructor TSettings.Create( strFile : string );
begin
  IniFile := GetCurrentDir + '\' +  strFile;//helpdesk.ini';
end;

procedure TGeneralSettings.SetColumns(i,value : integer);
begin
  FColumns[i] := value;
end;

function TGeneralSettings.GetColumns(i : integer) : integer;
begin
  Result := FColumns[i];
end;

procedure TGeneralSettings.SetMainFilters(i : integer; value : string);
begin
  FMainFilters[i] := value;
end;

function TGeneralSettings.GetMainFilters(i : integer) : string;
begin
  Result := FMainFilters[i];
end;


procedure TGeneralSettings.Load;
var i : integer;
begin
  FIniFile := TIniFile.Create( IniFile );

  //LastLogin := FIniFile.ReadString('general','lastlogin','');

  IncidentMonths := FIniFile.ReadInteger('misc','incident_months',3);

  for i := 1 to COLUMNS_COUNT do
    Columns[i] := FIniFile.ReadInteger('main_columns','column' + IntToStr(i),1);

  MainFiltersCount := FIniFile.ReadInteger('main_filters','count',0);
  MainFiltersCurrent := FIniFile.ReadInteger('main_filters','current',0);
  for i := 0 to MainFiltersCount-1 do
    MainFilters[i] := FIniFile.ReadString('main_filters','filter' + IntToStr(i),'');

  NumIncident := FIniFile.ReadString('main_filter','num_incident','');
  NumIncidentOp := FIniFile.ReadInteger('main_filter','num_incident_op',0);
  Status := FIniFile.ReadInteger('main_filter','status',0);
  StatusOp := FIniFile.ReadInteger('main_filter','status_op',0);
  Initiator := FIniFile.ReadString('main_filter','initiator','');
  InitiatorOp := FIniFile.ReadInteger('main_filter','initiator_op',0);
  Owner := FIniFile.ReadString('main_filter','owner','');
  OwnerOp := FIniFile.ReadInteger('main_filter','owner_op',0);
  Responsible := FIniFile.ReadString('main_filter','responsible','');
  ResponsibleOp := FIniFile.ReadInteger('main_filter','responsible_op',0);
  Element := FIniFile.ReadString('main_filter','element','');
  ElementOp := FIniFile.ReadInteger('main_filter','element_op',0);
  CreationDate  := FIniFile.ReadString('main_filter','creation_date','');
  CreationDateOp  := FIniFile.ReadInteger('main_filter','creation_date_op',0);
  FixDate  := FIniFile.ReadString('main_filter','fix_date','');
  FixDateOp  := FIniFile.ReadInteger('main_filter','fix_date_op',0);
  ClassIncident  := FIniFile.ReadString('main_filter','class_incident','');
  ClassIncidentOp  := FIniFile.ReadInteger('main_filter','class_incident_op',0);
  TypeClass0  := FIniFile.ReadString('main_filter','type_class','');
  TypeClass0Op := FIniFile.ReadInteger('main_filter','type_class_op',0);
  Scale := FIniFile.ReadInteger('main_filter','scale',0);
  ScaleOp := FIniFile.ReadInteger('main_filter','scale_op',0);
  IncType := FIniFile.ReadInteger('main_filter','incident_type',0);
  IncTypeOp := FIniFile.ReadInteger('main_filter','incident_type_op',0);
  Priority  := FIniFile.ReadString('main_filter','priority','');
  PriorityOp  := FIniFile.ReadInteger('main_filter','priority_op',0);
  Custom := FIniFile.ReadString('main_filter','custom','');


  Initiator2  := FIniFile.ReadString('initiator_filter','initiator','');
  Initiator2Op  := FIniFile.ReadInteger('initiator_filter','initiator_op',0);
  Descr  := FIniFile.ReadString('initiator_filter','descr','');
  DescrOp  := FIniFile.ReadInteger('initiator_filter','descr_op',0);
  Login  := FIniFile.ReadString('initiator_filter','login','');
  LoginOp  := FIniFile.ReadInteger('initiator_filter','login_op',0);
  Email  := FIniFile.ReadString('initiator_filter','email','');
  EmailOp  := FIniFile.ReadInteger('initiator_filter','email_op',0);
  Phone  := FIniFile.ReadString('initiator_filter','phone','');
  PhoneOp  := FIniFile.ReadInteger('initiator_filter','phone_op',0);
  Address  := FIniFile.ReadString('initiator_filter','address','');
  AddressOp  := FIniFile.ReadInteger('initiator_filter','address_op',0);

  Element2  := FIniFile.ReadString('element_filter','element','');
  Element2Op := FIniFile.ReadInteger('element_filter','element_op',0);
  Room  := FIniFile.ReadString('element_filter','room','');
  RoomOp := FIniFile.ReadInteger('element_filter','room_op',0);
  Phone2  := FIniFile.ReadString('element_filter','phone','');
  Phone2Op := FIniFile.ReadInteger('element_filter','phone_op',0);

  ClassIncident2  := FIniFile.ReadString('responsible_filter','class_incident','');
  ClassIncident2Op := FIniFile.ReadInteger('responsible_filter','class_incident_op',0);
  Responsible2  := FIniFile.ReadString('responsible_filter','responsible','');
  Responsible2Op := FIniFile.ReadInteger('responsible_filter','responsible_op',0);

  TypeClass  := FIniFile.ReadString('class_filter','type_class','');
  TypeClassOp := FIniFile.ReadInteger('class_filter','type_class_op',0);
  ClassIncident3  := FIniFile.ReadString('class_filter','class_incident','');
  ClassIncident3Op := FIniFile.ReadInteger('class_filter','class_incident_op',0);
  ClassDesc  := FIniFile.ReadString('class_filter','description','');
  ClassDescOp := FIniFile.ReadInteger('class_filter','description_op',0);
  Category  := FIniFile.ReadString('class_filter','category','');
  CategoryOp := FIniFile.ReadInteger('class_filter','category_op',0);
  ClassSortedBy := FIniFile.ReadString('class_filter','sortedby','');
  ClassSortOrder := FIniFile.ReadInteger('class_filter','sortorder',0);

end;

procedure TGeneralSettings.Save;
var i : integer;
begin
 if FIniFile <> nil then
 begin
  //  FIniFile.WriteString('general','lastlogin',LastLogin);

    FIniFile.WriteInteger('misc','incident_months',IncidentMonths);

    for i := 1 to COLUMNS_COUNT do
       FIniFile.WriteInteger('main_columns','column' + IntToStr(i),Columns[i]);

    FIniFile.WriteInteger('main_filters','count',MainFiltersCount);
    FIniFile.WriteInteger('main_filters','current',MainFiltersCurrent);

    for i := 0 to MainFiltersCount-1 do
       FIniFile.WriteString('main_filters','filter' + IntToStr(i), MainFilters[i]);


    FIniFile.WriteString('main_filter','num_incident', NumIncident);
    FIniFile.WriteInteger('main_filter','num_incident_op', NumIncidentOp);
    FIniFile.WriteInteger('main_filter','status',Status);
    FIniFile.WriteInteger('main_filter','status_op',StatusOp);
    FIniFile.WriteString('main_filter','initiator',Initiator);
    FIniFile.WriteInteger('main_filter','initiator_op',InitiatorOp);
    FIniFile.WriteString('main_filter','owner',Owner);
    FIniFile.WriteInteger('main_filter','owner_op',OwnerOp);
    FIniFile.WriteString('main_filter','responsible',Responsible);
    FIniFile.WriteInteger('main_filter','responsible_op',ResponsibleOp);
    FIniFile.WriteString('main_filter','element',Element);
    FIniFile.WriteInteger('main_filter','element_op',ElementOp);
    FIniFile.WriteString('main_filter','creation_date',CreationDate);
    FIniFile.WriteInteger('main_filter','creation_date_op',CreationDateOp);
    FIniFile.WriteString('main_filter','fix_date',FixDate);
    FIniFile.WriteInteger('main_filter','fix_date_op',FixDateOp);
    FIniFile.WriteString('main_filter','class_incident',ClassIncident);
    FIniFile.WriteInteger('main_filter','class_incident_op',ClassIncidentOp);
    FIniFile.WriteString('main_filter','type_class',TypeClass0);
    FIniFile.WriteInteger('main_filter','type_class_op',TypeClass0Op);
    FIniFile.WriteInteger('main_filter','scale',Scale);
    FIniFile.WriteInteger('main_filter','scale_op',ScaleOp);
    FIniFile.WriteInteger('main_filter','incident_type',IncType);
    FIniFile.WriteInteger('main_filter','incident_type_op',IncTypeOp);
    FIniFile.WriteString('main_filter','priority',Priority);
    FIniFile.WriteInteger('main_filter','priority_op',PriorityOp);
    FIniFile.WriteString('main_filter','custom',Custom);

    FIniFile.WriteString('initiator_filter','initiator',Initiator2);
    FIniFile.WriteInteger('initiator_filter','initiator_op',Initiator2Op);
    FIniFile.WriteString('initiator_filter','descr',Descr);
    FIniFile.WriteInteger('initiator_filter','descr_op',DescrOp);
    FIniFile.WriteString('initiator_filter','login',Login);
    FIniFile.WriteInteger('initiator_filter','login_op',LoginOp);
    FIniFile.WriteString('initiator_filter','email',Email);
    FIniFile.WriteInteger('initiator_filter','email_op',EmailOp);
    FIniFile.WriteString('initiator_filter','phone',Phone);
    FIniFile.WriteInteger('initiator_filter','phone_op',PhoneOp);
    FIniFile.WriteString('initiator_filter','address',Address);
    FIniFile.WriteInteger('initiator_filter','address_op',AddressOp);

    FIniFile.WriteString('element_filter','element',Element2);
    FIniFile.WriteInteger('element_filter','element_op',Element2Op);
    FIniFile.WriteString('element_filter','room',Room);
    FIniFile.WriteInteger('element_filter','room_op',RoomOp);
    FIniFile.WriteString('element_filter','phone',Phone2);
    FIniFile.WriteInteger('element_filter','phone_op',Phone2Op);

    FIniFile.WriteString('responsible_filter','class_incident',ClassIncident2);
    FIniFile.WriteInteger('responsible_filter','class_incident_op',ClassIncident2Op);
    FIniFile.WriteString('responsible_filter','responsible',Responsible2);
    FIniFile.WriteInteger('responsible_filter','responsible_op',Responsible2Op);

    FIniFile.WriteString('class_filter','type_class',TypeClass);
    FIniFile.WriteInteger('class_filter','type_class_op',TypeClassOp);
    FIniFile.WriteString('class_filter','class_incident',ClassIncident3);
    FIniFile.WriteInteger('class_filter','class_incident_op',ClassIncident3Op);
    FIniFile.WriteString('class_filter','description',ClassDesc);
    FIniFile.WriteInteger('class_filter','description_op',ClassDescOp);
    FIniFile.WriteString('class_filter','category',Category);
    FIniFile.WriteInteger('class_filter','category_op',CategoryOp);
    FIniFile.WriteString('class_filter','sortedby',ClassSortedBy);
    FIniFile.WriteInteger('class_filter','sortorder',ClassSortOrder);

 end;
end;

procedure TGeneralSettings.LoadMain( name : string );
begin
 if FIniFile <> nil then
 begin
  name := name + '_main_filter';
  NumIncident := FIniFile.ReadString(name,'num_incident','');
  NumIncidentOp := FIniFile.ReadInteger(name,'num_incident_op',0);
  Status := FIniFile.ReadInteger(name,'status',0);
  StatusOp := FIniFile.ReadInteger(name,'status_op',0);
  Initiator := FIniFile.ReadString(name,'initiator','');
  InitiatorOp := FIniFile.ReadInteger(name,'initiator_op',0);
  Owner := FIniFile.ReadString(name,'owner','');
  OwnerOp := FIniFile.ReadInteger(name,'owner_op',0);
  Responsible := FIniFile.ReadString(name,'responsible','');
  ResponsibleOp := FIniFile.ReadInteger(name,'responsible_op',0);
  Element := FIniFile.ReadString(name,'element','');
  ElementOp := FIniFile.ReadInteger(name,'element_op',0);
  CreationDate  := FIniFile.ReadString(name,'creation_date','');
  CreationDateOp  := FIniFile.ReadInteger(name,'creation_date_op',0);
  FixDate  := FIniFile.ReadString(name,'fix_date','');
  FixDateOp  := FIniFile.ReadInteger(name,'fix_date_op',0);
  ClassIncident  := FIniFile.ReadString(name,'class_incident','');
  ClassIncidentOp  := FIniFile.ReadInteger(name,'class_incident_op',0);
  TypeClass0  := FIniFile.ReadString(name,'type_class','');
  TypeClass0Op := FIniFile.ReadInteger(name,'type_class_op',0);
  Scale := FIniFile.ReadInteger(name,'scale',0);
  ScaleOp := FIniFile.ReadInteger(name,'scale_op',0);
  Priority  := FIniFile.ReadString(name,'priority','');
  PriorityOp  := FIniFile.ReadInteger(name,'priority_op',0);
  Custom := FIniFile.ReadString(name,'custom','');
 end;
end;

procedure TGeneralSettings.SaveMain( name : string );
begin
 if FIniFile <> nil then
 begin
    name := name +'_main_filter';
    FIniFile.WriteString(name,'num_incident', NumIncident);
    FIniFile.WriteInteger(name,'num_incident_op', NumIncidentOp);
    FIniFile.WriteInteger(name,'status',Status);
    FIniFile.WriteInteger(name,'status_op',StatusOp);
    FIniFile.WriteString(name,'initiator',Initiator);
    FIniFile.WriteInteger(name,'initiator_op',InitiatorOp);
    FIniFile.WriteString(name,'owner',Owner);
    FIniFile.WriteInteger(name,'owner_op',OwnerOp);
    FIniFile.WriteString(name,'responsible',Responsible);
    FIniFile.WriteInteger(name,'responsible_op',ResponsibleOp);
    FIniFile.WriteString(name,'element',Element);
    FIniFile.WriteInteger(name,'element_op',ElementOp);
    FIniFile.WriteString(name,'creation_date',CreationDate);
    FIniFile.WriteInteger(name,'creation_date_op',CreationDateOp);
    FIniFile.WriteString(name,'fix_date',FixDate);
    FIniFile.WriteInteger(name,'fix_date_op',FixDateOp);
    FIniFile.WriteString(name,'class_incident',ClassIncident);
    FIniFile.WriteInteger(name,'class_incident_op',ClassIncidentOp);
    FIniFile.WriteString(name,'type_class',TypeClass0);
    FIniFile.WriteInteger(name,'type_class_op',TypeClass0Op);
    FIniFile.WriteInteger(name,'scale',Scale);
    FIniFile.WriteInteger(name,'scale_op',ScaleOp);
    FIniFile.WriteString(name,'priority',Priority);
    FIniFile.WriteInteger(name,'priority_op',PriorityOp);
    FIniFile.WriteString(name,'custom',Custom);
 end;
end;

procedure TGeneralSettings.DeleteMain( name : string );
var filters : TStringList;
    i,n : integer;

begin
  // ?????? ?????? ? ??????? ???????
  filters := TStringList.Create;
  if FIniFile <> nil then
  begin
    FIniFile.EraseSection(name + '_main_filter');

    FIniFile.ReadSection('main_filters',filters);
    for i := 0 to filters.Count - 1 do
    begin
      if FIniFile.ReadString('main_filters',filters[i],'') = name then
        FIniFile.DeleteKey('main_filters',filters[i]);
      if filters[i] = 'count' then
      begin
        n := FIniFile.ReadInteger('main_filters','count',0);
        FIniFile.WriteInteger('main_filters','count',n-1);
      end;
    end;
  end;


end;

procedure TCommonSettings.Load;
begin
  FIniFile := TIniFile.Create( IniFile );
  LastLogin := FIniFile.ReadString('general','lastlogin','');
  LastDB := FIniFile.ReadString('general','lastdb','LIN');
end;

procedure TCommonSettings.Save;
begin
 if FIniFile <> nil then
 begin
    FIniFile.WriteString('general','lastlogin',LastLogin);
    FIniFile.WriteString('general','lastdb',LastDB);
 end;
end;

end.
