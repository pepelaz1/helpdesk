unit incident_move;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls,user, oracle, Buttons, showimage,dateutils,
  Grids, DBGrids, SxkDBGrid,settings, jpeg, ExtCtrls;
                                                                  
type
  TIncidentState = ( Created = 0, Assigned, Processing, Refused, Processed, Closed, OpenedAgain );

  TMoveRec = record
     num : string;
     date : string;
     desc : string;
     num_state : string;
     creator : string;
  end;

  TIncidentMoveForm = class(TForm)
    IncidentMoveGroupBox: TGroupBox;
    InitiatorLabel: TLabel;
    OwnerLabel: TLabel;
    ResponsibleLabel: TLabel;
    OwnerEdit: TEdit;
    InitiatorEdit: TEdit;
    Edit1: TEdit;
    ResponsibleEdit: TEdit;
    MovementsGroupBox: TGroupBox;
    MovementsGrid: TSxkDBGrid;
    CreationDateLabel: TLabel;
    CreationDateEdit: TEdit;
    CreatorEdit: TEdit;
    CreatorLabel: TLabel;
    StateLabel: TLabel;
    StateEdit: TEdit;
    ScreenshotLabel: TLabel;
    DescLabel: TLabel;
    DescMemo: TMemo;
    PrevButton: TSpeedButton;
    NextButton: TSpeedButton;
    CreateMovementButton: TSpeedButton;
    ApplyButton: TSpeedButton;
    AssignComboBox: TComboBox;
    NewStateLabel: TLabel;
    AssignResponsibleButton: TSpeedButton;
    AddScreenButton: TSpeedButton;
    RemoveScreenButton: TSpeedButton;
    ScreenListBox: TListBox;
    NumberLabel: TLabel;
    IncidentClassLabel: TLabel;
    IncidentClassEdit: TEdit;
    IncCreationDateLabel: TLabel;
    IncCreationDateEdit: TEdit;
    IncFixDateEdit: TEdit;
    IncFixDateLabel: TLabel;
    ScaleLabel: TLabel;
    ScaleEdit: TEdit;
    PriorityLabel: TLabel;
    PriorityEdit: TEdit;
    GenerateWordButton: TButton;
    InfrastructureLabel: TLabel;
    InfrastructureEdit: TEdit;
    ClassChangeButton: TSpeedButton;
    ReasonLabel: TLabel;
    ReasonEdit: TEdit;
    ScaleChangeButton: TSpeedButton;
    InitiatorButton: TSpeedButton;
    OwnerButton: TSpeedButton;
    RespButton: TSpeedButton;
    UITiSImage: TImage;
    TypeLabel: TLabel;
    TypeEdit: TEdit;
    EditButton: TBitBtn;
    BaseButton: TBitBtn;
    ApplyEditButton: TBitBtn;
    CloseButton: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScreenListBoxDblClick(Sender: TObject);
    procedure CreateMovementButtonClick(Sender: TObject);
    procedure AddScreenButtonClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure RemoveScreenButtonClick(Sender: TObject);
    procedure ScreenListBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AssignResponsibleButtonClick(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
    procedure PrevButtonClick(Sender: TObject);
    procedure MovementsGridDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure MovementsGridCellClick(Column: TColumn);
    procedure GenerateWordButtonClick(Sender: TObject);
    procedure MovementsGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AssignComboBoxChange(Sender: TObject);
    procedure DescMemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ClassChangeButtonClick(Sender: TObject);
    procedure ScaleChangeButtonClick(Sender: TObject);
    procedure BaseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure InitiatorButtonClick(Sender: TObject);
    procedure OwnerButtonClick(Sender: TObject);
    procedure RespButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure ApplyEditButtonClick(Sender: TObject);

  private
     FIncidentNum : int64;
     FCurrRecord : integer;
     FCount : integer;
     FStrImages : TStringList;
     FAdding : boolean;
     FIncidentState : TIncidentState;
     FNeedUpdateResponsible : boolean;

     FReady : boolean;
     FMovs : array [0..50] of TMoveRec;

       // ????????? ???? ???????? ?? ??????? ????????? ?? ????
     procedure GetIncidentMovements;

     // ?????????? ?????????? ?? ????????
     procedure UpdateMovements;

     // ?????????? ?????????? ?? ??????????????
     procedure SetResponsible;

     // ???????? ?????? ????????
     procedure CreateNewMovement;

     // ???????? ?????????? ??? ???????? ?????? ????????
     function Validate : boolean;

     // ???????? ?????? ?? ?????? ??????????
     procedure DeleteScreenListItem;


     // ?????????? ????????? ???????
     procedure AssignIncidentState;

     // ?????????? ???? ????? ????????????? ??????? ?????? ?????????
     procedure UpdateStateEdit;

     // ???????? / ????????? ??????????? ????????? ??? ?????????? ?????? ????????
     procedure EnableMovementControls( bEnable : boolean );

     // ?????????? ??????? ?????????
     procedure UpdateIncidentStatus;

     // ?????????? ????? ? ??????????
     procedure UpdateMovementsGrid;

     // ????????/?????????? ?????? ??? ?????????? ??????????????
     procedure UpdateAssignButton;

     // ?????????? ???? ????? ? ???????? ?????????
     procedure UpdateReasonEdit;

     // ????????/?????????? ?????? ??? ????? ????? ?????????
     procedure UpdateChangeClassButton;

     // ????????/?????????? ?????? ??? ????? ???????? ?????????
     procedure  UpdateChangeScaleButton;


     // ????????/?????????? ?????? ??? ?????????????? ???????? ?????????
     procedure UpdateEditButton;

       // ?????????? ???????? ??????????????
     property NeedUpdateResponsible : boolean read FNeedUpdateResponsible write FNeedUpdateResponsible;

  public

    property IncidentState : TIncidentState read FIncidentState write FIncidentState ;
    property IncidentNum : int64 read FIncidentNum write FIncidentNum;

    procedure OnMovementsGridScroll;
  end;

var
  IncidentMoveForm: TIncidentMoveForm;

implementation

uses global, assign, progress, main, class_selection, reason,
  scale_selection, main_filter, user_info;
{$R *.dfm}


procedure TIncidentMoveForm.FormShow(Sender: TObject);
var s : string;
    i : integer;
begin

   Module.MoveDataSet.Active := false;
   Module.MoveDataSet.SetVariable('INCIDENT_NUM', IncidentNum);
   Module.MoveDataSet.Active := true;


   for i := 0 to ComponentCount-1 do
   begin
     if Components[i] is TEdit then  TEdit(Components[i]).Color := Module.EvenColor
     else if Components[i] is TMemo then  TMemo(Components[i]).Color := Module.EvenColor
     else if Components[i] is TListBox then TListBox(Components[i]).Color := Module.EvenColor;
   end;


   IncidentMoveGroupBox.Caption := '?????? ????????? ' + Module.OraDataSetINCIDENT_STRING.AsString;

   // ???
   try
     Module.OraQuery.SQL.Text := 'SELECT incident_type FROM common_view WHERE num_incident = ' + IntToStr(FIncidentNum);
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
     TypeEdit.Text := Module.OraQuery.Field(0);
   finally
   end;

   // ??????????
   try
     Module.OraQuery.SQL.Text := 'SELECT t1.worker FROM personnel t1, incident_card t2 WHERE t2.num_incident = ' + IntToStr(IncidentNum) + ' AND t2.id_work = t1.id_work';
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
     InitiatorEdit.Text := Module.OraQuery.Field(0);
   finally
   end;

   // ????????
   try
     Module.OraQuery.SQL.Text := 'SELECT t1.worker FROM personnel t1, incident_card t2 WHERE t2.num_incident = ' + IntToStr(IncidentNum) + ' AND t2.owner_inc = t1.id_work';
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
     OwnerEdit.Text := Module.OraQuery.Field(0);
   finally
   end;

   // ?????????????
   SetResponsible;

   // ????? ??????????
   try
     Module.OraQuery.SQL.Text := 'select name_class from classifier_view_new t1, incident_card t2 where t2.num_incident = ' + IntToStr(IncidentNum) + ' and t2.num_class = t1.num_class';
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
     IncidentClassEdit.Text := Module.OraQuery.Field(0);
   finally
   end;

   // ???? ? ????? ????????
   try
     Module.OraQuery.SQL.Text := 'select to_char(t.date_create, ''DD.MM.YYYY HH24:MI:SS'') from incident_card t where t.num_incident = ' + IntToStr(FIncidentNum);
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
     IncCreationDateEdit.Text := Module.OraQuery.Field(0);
   finally
   end;

   // ???? ? ????? ??????????
   try
     Module.OraQuery.SQL.Text := 'select to_char(t.date_resolution, ''DD.MM.YYYY HH24:MI:SS'') from incident_card t where t.num_incident = ' + IntToStr(FIncidentNum);
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
     IncFixDateEdit.Text := Module.OraQuery.Field(0);
   finally
   end;

   // ???????
   try
     Module.OraQuery.SQL.Text := 'select t1.name_scale from incident_scale t1, incident_card t2 where t2.num_incident = ' + IntToStr(FIncidentNum) + ' and t1.num_scale = t2.num_scale';
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
     ScaleEdit.Text := Module.OraQuery.Field(0);
   finally
   end;

   // ?????????
   try
     Module.OraQuery.SQL.Text := 'select t.priority from incident_card t where t.num_incident = ' + IntToStr(FIncidentNum);
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
     PriorityEdit.Text := Module.OraQuery.Field(0);
     ///////////
   finally
   end;

   // ??????? ??????????????
   try
     Module.OraQuery.SQL.Text := 'select t.name_device from infrastructure t, incident_card t1 where t.num_device = t1.num_device and t1.num_incident = ' + IntToStr(FIncidentNum);
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
     InfrastructureEdit.Text := Module.OraQuery.Field(0);
   finally
   end;

   GetIncidentMovements;
   UpdateMovements;
   UpdateReasonEdit;

   EnableMovementControls(false);

   FAdding := false;
   NeedUpdateResponsible := false;

   FReady := true;
end;

procedure TIncidentMoveForm.EnableMovementControls( bEnable : boolean );
begin
   DescMemo.ReadOnly := not bEnable;
   AddScreenButton.Enabled := bEnable;
   RemoveScreenButton.Enabled := bEnable;
   ApplyButton.Enabled := bEnable;
   AssignComboBox.Enabled := bEnable;
   ClassChangeButton.Enabled := GUser.UserRole >= HD_REGISTRATOR;
   ScaleChangeButton.Enabled := GUser.UserRole >= HD_REGISTRATOR;

   AssignResponsibleButton.Enabled := bEnable;
end;

procedure TIncidentMoveForm.SetResponsible;
var s : string;
begin
   try
     Module.OraQuery.SQL.Text :='SELECT t1.worker FROM personnel t1, incident_card t2 WHERE t2.num_incident = ' + IntToStr(IncidentNum) + ' AND t2.responsible_inc = t1.id_work';
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
     ResponsibleEdit.Text := Module.OraQuery.Field(0);
   except
     ResponsibleEdit.Text :='?? ????????';
   end;
   UpdateStateEdit;
end;

procedure TIncidentMoveForm.UpdateStateEdit;
begin
  case IncidentState of
    Created : StateEdit.Text := '??????';
    Assigned : StateEdit.Text := '????????';
    Processing : StateEdit.Text := '? ??????';
    Refused : StateEdit.Text := '????????';
    Processed : StateEdit.Text := '????????';
    Closed : StateEdit.Text := '??????';
    OpenedAgain : StateEdit.Text := '?????? ??????';
  end;

end;

procedure TIncidentMoveForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TIncidentMoveForm.FormCreate(Sender: TObject);
begin
  //Check out user privileges
//  if (GUser.UserRole < HD_REGISTRATOR) then
 //    AssignButton.Enabled := false;

   FStrImages := TStringList.Create;
   FReady := false;


end;

procedure TIncidentMoveForm.GetIncidentMovements;
var s : string;
begin


   // ???????? ??? ???????? ?? ??????? ?????????,
   // ??????????????? ?? ????

   FCount := 0;
   FCurrRecord := 0;

   try
     Module.MovementsOraQuery.SQL.Text :=
      'select t.num_move, to_char(t.date_move,''DD.MM.YYYY HH24:MI:SS'') , t.description, t.num_state, t.creator_move from incident_move_card t where t.num_incident = '+
       IntToStr(FIncidentNum) +
      ' order by t.date_move';
     s:= Module.MovementsOraQuery.SQL.Text;
     Module.MovementsOraQuery.Execute;
   finally
   end;

   with Module.MovementsOraQuery do
   begin
     while not Eof do
     begin
       FMovs [ FCurrRecord ].num := Field(0);
       FMovs [ FCurrRecord ].date := Field(1);
       FMovs [ FCurrRecord ].desc := Field(2);
       FMovs [ FCurrRecord ].num_state := Field(3);
       FMovs [ FCurrRecord ].creator := Field(4);
       Inc(FCurrRecord);
       Inc(FCount);
       Next;
     end;
   end;

  FCurrRecord := FCount-1;
  UpdateIncidentStatus;
  UpdateMovementsGrid;
end;



procedure TIncidentMoveForm.UpdateMovementsGrid;
begin
  Module.MoveDataSet.Refresh;
  Module.MoveDataSet.RecNo :=  FCurrRecord+1;
end;

procedure TIncidentMoveForm.UpdateIncidentStatus;
var b1, b2,b3, b4 : boolean;
    s: string;
begin
   Module.OraQuery.SQL.Text := 'select t.name_state from incident_state t where t.num_state = ' + FMovs[FCurrRecord].num_state + '';
   Module.OraQuery.Execute;

   s :=  Module.OraQuery.Field(0);

   if (s = '??????') then
   begin
     IncidentState := Created;
   end
   else if (s = '????????') then
   begin
     IncidentState := Assigned;
   end
   else if (s = '? ??????') then
   begin
     IncidentState := Processing;
   end
   else if (s = '????????') then
   begin
     IncidentState := Refused;
   end
   else if (s = '????????') then
   begin
     IncidentState := Processed;
   end
   else if (s = '??????') then
   begin
     IncidentState := Closed;
   end
   else if (s = '?????? ????????') then
   begin
     IncidentState := OpenedAgain;
   end;


   b1 := GUser.IsOwner(IncidentNum) and ((IncidentState = OpenedAgain) or (IncidentState = Assigned) or ( IncidentState = Created) or (IncidentState = Refused) or (IncidentState = Processed) or ( IncidentState = Closed));
   b2 := GUser.IsResponsible(IncidentNum) and ((IncidentState = Assigned) or (IncidentState = Processing)  or ( IncidentState = OpenedAgain));
   b3 := (GUser.UserRole = HD_NOMINATOR) and ((IncidentState = OpenedAgain) or (IncidentState = Assigned) or ( IncidentState = Created) or (IncidentState = Refused) or (IncidentState = Processed));
   b4 := GUser.UserRole >= HD_RESPONSIBLE;

   CreateMovementButton.Enabled := (b1 or b2 or  b3) and b4;
end;

procedure TIncidentMoveForm.UpdateMovements;
var s : string;
begin

  try

    CreationDateEdit.Text := FMovs[ FCurrRecord ].date;
    DescMemo.Text := FMovs[ FCurrRecord ].desc;
    Module.OraQuery.SQL.Text := 'select t.worker from personnel t where t.id_work = ''' + FMovs[ FCurrRecord ].creator + '''';
    Module.OraQuery.Execute;
    CreatorEdit.Text := Module.OraQuery.Field(0);
    s := FMovs[ FCurrRecord ].num_state;
    Module.OraQuery.SQL.Text := 'select t.name_state from incident_state t where t.num_state = ' + s + '';
    Module.OraQuery.Execute;
    s := Module.OraQuery.SQL.Text;
    StateEdit.Text := Module.OraQuery.Field(0);

    // ????????? ?????? ??????????
    ScreenListBox.Clear;
    try
      s := FMovs[FCurrRecord].num;
      Module.OraQuery.SQL.Text := 'SELECT t.screen_num, to_char(t.date_ins,''DD.MM.YYYY HH24:MI:SS'') FROM addition t WHERE t.num_move = ' + s + ' ORDER BY t.date_ins';
      Module.OraQuery.Execute;
      while not Module.OraQuery.Eof do
      begin
        ScreenListBox.AddItem( Module.OraQuery.Field(1),TObject(StrToInt(Module.OraQuery.Field(0))));
        Module.OraQuery.Next;
      end;

    finally
    end;


    if (FCurrRecord >= FCount - 1)  then
      NextButton.Enabled := false
    else
      NextButton.Enabled := true;

    if (FCurrRecord <= 0)  then
      PrevButton.Enabled := false
    else
      PrevButton.Enabled := true;


    NumberLabel.Caption := '( ' + IntToStr(FCurrRecord+1) + ' ?? ' + IntToStr(FCount) +' )';
    UpdateEditButton;
  finally
  end
end;

procedure TIncidentMoveForm.ScreenListBoxDblClick(Sender: TObject);
var s: string;
    n : integer;
    LOB : TLOBLocator;
begin
  n := Integer(ScreenListBox.Items.Objects[ ScreenListBox.ItemIndex ]);

  if FAdding then
  begin
    s :=  FStrImages[ScreenListBox.ItemIndex];
    if (ImageForm.LoadImage(s )) then
      ImageForm.ShowModal;
  end
  else
  begin

    // ?????? ???????? ?? ???? ? ????????? ?? ????????? ????
    Module.OraQuery.SQL.Text := 'select t.screen from addition t where t.screen_num = ' + IntToStr(n) +'';
    Module.OraQuery.Execute;
    LOB := Module.OraQuery.LOBField('screen');

    if not LOB.IsNull then
       LOB.SaveToFile('tmp');

    // ?????????? ImageForm form ? ??????? ????????? ????
    if (ImageForm.LoadImage('tmp')) then
    begin
      DeleteFile('tmp');
      ImageForm.ShowModal;
    end;

  end;
end;

procedure TIncidentMoveForm.CreateMovementButtonClick(Sender: TObject);
begin
  EditButton.Enabled := false;
  CreateNewMovement;
end;



procedure TIncidentMoveForm.CreateNewMovement;
var s : string;
begin
  FAdding := true;

  // ??????? ?????????? ? ?????????
  DescMemo.Text := '';
  //CreationDateEdit.Text :=  Format('%0.2d.%0.2d.%0.2d %0.2d:%0.2d:%0.2d', [DayOf(Date), MonthOf(Date),YearOf(Date), HourOf(Time),MinuteOf(Time), SecondOf(Time)]);
//  Module.OraQuery.SQL.Text :='select sysdate from dual';
  Module.OraQuery.SQL.Text := 'select to_char(sysdate, ''DD.MM.YYYY HH24:MI:SS'') from dual';
  Module.OraQuery.Execute;

  s := Module.OraQuery.Field(0);
  CreationDateEdit.Text := s;

  StateEdit.Text := '';
  ScreenListBox.Clear;
  FStrImages.Clear;

  CreateMovementButton.Enabled := false;
  NextButton.Enabled := false;
  PrevButton.Enabled := false;

  MovementsGrid.Enabled := false;
  
  EnableMovementControls( true );

  Module.OraQuery.SQL.Text := 'select t.worker from personnel t where lower(t.login) = lower(user)';
  Module.OraQuery.Execute;
  CreatorEdit.Text := Module.OraQuery.Field(0);

  // ????????? AssignComboBox
  AssignIncidentState;
end;

procedure TIncidentMoveForm.UpdateChangeClassButton;
begin
   ClassChangeButton.Enabled := GUser.IsOwner( IncidentNum ) and  (
     (AssignComboBox.Text = '????????') or
     (AssignComboBox.Text = '?????? ????????')
    );
end;

procedure TIncidentMoveForm.UpdateChangeScaleButton;
begin
   ScaleChangeButton.Enabled := GUser.IsOwner( IncidentNum ) and  (
     (AssignComboBox.Text = '????????') or
     (AssignComboBox.Text = '?????? ????????')
    );
end;

procedure TIncidentMoveForm.UpdateEditButton;
var LMoveCreator : String;
begin
  LMoveCreator := Module.MoveDataSet.FieldByName('worker').AsString;
  EditButton.Enabled := (GUser.UserName = LMoveCreator) or (GUser.UserRole >= HD_REGISTRATOR);
end;

procedure  TIncidentMoveForm.UpdateAssignButton;
begin
   AssignResponsibleButton.Enabled := ((GUser.IsOwner( IncidentNum )) or (GUser.UserRole = HD_NOMINATOR)) and  (
     (AssignComboBox.Text = '????????') or
     (AssignComboBox.Text = '?????? ????????')
    );
end;

procedure TIncidentMoveForm.AssignIncidentState;
var bResponsible, bOwner, bNominator : boolean;
    s0,s : string;
begin
   bResponsible :=  GUser.IsResponsible( IncidentNum );
   bOwner := GUser.IsOwner( IncidentNum );
   bNominator := GUser.UserRole = HD_NOMINATOR;

   Module.OraQuery.SQL.Text := 'select t.num_state, t.name_state from incident_state t';
   Module.OraQuery.Execute;

//   AssignResponsibleButton.Enabled := bOwner and  ((IncidentState = Created) or (IncidentState = Closed));
  // UpdateAssignButton;
   AssignComboBox.Clear;

   while not Module.OraQuery.Eof do
   begin

     s0 := Module.OraQuery.Field(0);
     s := Module.OraQuery.Field(1);

     if (s = '??????') then
     begin
       if bResponsible and not bOwner then
       begin
    //     CreateMovementButton.Enabled := false;
       end
       else if bOwner then
       begin
         
       end;
     end
     else if (s = '????????') then
     begin
       if (IncidentState = Created) or (IncidentState = Processed) or (IncidentState = Processing)
         or (IncidentState = Refused)    or ( IncidentState = Assigned ) or ( IncidentState = OpenedAgain ) then
       begin
         if (bOwner) or (bNominator)  then
           AssignComboBox.AddItem(s,TObject(StrToInt(s0)));
       end;
     end
     else if (s = '? ??????') then
     begin
       if (IncidentState = Assigned) or ( IncidentState = Processing ) or (IncidentState = OpenedAgain) then
       begin
         if bResponsible then
           AssignComboBox.AddItem(s,TObject(StrToInt(s0)));
       end;
     end
     else if (s = '????????') then
     begin
       if (IncidentState = Assigned) or ( IncidentState = Processing ) or (IncidentState = OpenedAgain) then
       begin
         if bResponsible then
           AssignComboBox.AddItem(s,TObject(StrToInt(s0)));
       end;
     end
     else if (s = '??????') then
     begin
       if ( IncidentState = Refused) or (IncidentState = Processed) or
        (IncidentState = Assigned) or ( IncidentState = Created ) or ( IncidentState = OpenedAgain )
         then
       begin
         if bOwner then
            AssignComboBox.AddItem(s,TObject(StrToInt(s0)));
       end;
     end
     else if (s = '????????') then
     begin
       if (IncidentState = Assigned) or ( IncidentState = Processing) or (IncidentState = OpenedAgain) then
       begin
         if bResponsible then
            AssignComboBox.AddItem(s,TObject(StrToInt(s0)));
       end;
     end
     else if (s = '?????? ????????') then
     begin
       if (IncidentState = Closed)  then
       begin
         if bOwner then
            AssignComboBox.AddItem(s,TObject(StrToInt(s0)));

       end;
     end;

     Module.OraQuery.Next;
   end;

   AssignComboBox.ItemIndex := 0;
   AssignComboBox.Repaint;

   UpdateAssignButton;
   UpdateChangeClassButton;
   UpdateChangeScaleButton;
end;



function TIncidentMoveForm.Validate : boolean;
begin
//  if (AssignComboBox.Text = '????????') and
//   (ResponsibleEdit.Text = '?? ????????') then
//  begin
//    Application.MessageBox('????????????? ??? ??????? ????????? ?? ????????','??????');
//    Result := false;
//    exit;
//  end;

  Result := true;
end;

procedure TIncidentMoveForm.AddScreenButtonClick(Sender: TObject);
var s : string;
    i : integer;
begin
  if Module.OpenFileDialog.Execute then
  begin
    for i := 0 to  Module.OpenFileDialog.Files.Count-1 do
    begin
      s := Format('?????? - %0.2d.%0.2d.%0.2d %0.2d:%0.2d:%0.2d', [DayOf(Date), MonthOf(Date),YearOf(Date), HourOf(Time),MinuteOf(Time), SecondOf(Time)]);
      FStrImages.Add(Module.OpenFileDialog.Files[i]);
      ScreenListBox.AddItem(s,nil);
    end;
  end;
end;

procedure TIncidentMoveForm.ApplyButtonClick(Sender: TObject);
var s, strState : string;
    result,i  : integer;
    LOB : TLOBLocator;
    LNeedSendNotification : boolean;
begin
  FAdding := false;

  if Validate then
  begin

     LNeedSendNotification := false;
     if (IncidentState = Created) or ( IncidentState = Closed)
       // ???! ????????!
       or (AssignComboBox.Text = '????????')
       then  // ?????????? ??????
     begin

        // ???? ????? ???????? ??????????????
        if NeedUpdateResponsible then
        begin
          s := Module.AssignDataSetID_WORK.AsString;
          if s <>'' then
          begin
            Module.OraQuery.SQL.Text := 'update incident_card t set t.responsible_inc = ' + QuotedStr(s) + ' where t.num_incident = ' + IntToStr(IncidentNum);
            Module.OraQuery.Execute;
            ResponsibleEdit.Text := Module.AssignDataSetWORKER.AsString;
          end;
          NeedUpdateResponsible := false;
        end;

        LNeedSendNotification := true;
     end;

     strState := AssignComboBox.Text;
     if (AssignComboBox.Text = '?????????????') then
       strState := '????????';


     if (strState = '????????') or (strState = '?????? ????????') then
     begin
       Module.OraQuery.SQL.Text := 'Select t1.worker from personnel t1, incident_card t2 where t1.id_work = t2.responsible_inc and t2.num_incident = ' + IntToStr(IncidentNum);
       Module.OraQuery.Execute;
       DescMemo.Text := DescMemo.Text + #13#10 + '<< ????????: ' + Module.OraQuery.Field(0) + ' >>';
    end;

    if (strState = '??????' ) then
    begin
      ReasonForm.IncidentNum := IncidentNum;
      ReasonForm.ShowModal;
    end;

     // ??????? ????????? ???????? ???????? ?????????
     Module.OraQuery2.SQL.Text :=' begin ' +
      ' :RES:=Incident_move_card_package.InsertIncidentMove (' +
       IntToStr(IncidentNum) + ',' +
       '''' + AssignComboBox.Text +''',' +
       '''' + NS(DescMemo.Text) + ''','+
       '''' + CreationDateEdit.Text + '''' +
      ');' +
     'end;';
     s := Module.OraQuery2.SQL.Text;
     Module.OraQuery2.Execute;

     //  ???????? id ?????? ????????? ?????? ? ??????? INCIDENT_MOVE_CARD
     result := Module.OraQuery2.GetVariable('RES');

      // ????????? ????????? ? ?????????? ????????

      ProgressForm.Show;
      ProgressForm.Gauge.Progress := 0;


      for i := 0 to ScreenListBox.Count - 1 do
      begin
         ProgressForm.Gauge.Progress := ProgressForm.Gauge.MaxValue * (i+1) div  ScreenListBox.Count;
         s :=  FStrImages[i];
         if (ImageForm.LoadImage(s )) then
         begin

           LOB := TLOBLocator.Create( Module.OraSession,otBLOB );
           Module.OraQuery3.SetComplexVariable('PIC',LOB);
           Module.OraQuery3.SQL.Text := 'begin ' +
             ' :PIC := Addition_package.InsertAddition (' +
             FloatToStr(result) +',' +
             '''' + copy(ScreenListBox.Items[i],10, length(s)-10) + '''' +
             ');' +
             'end;';
           Module.OraQuery3.Execute;


           LOB.LoadFromFile(s);
           LOB.Free;

          end;
       end;
     ProgressForm.Close;

     // ??????
     Module.OraQuery.SQL.Text := 'begin commit; end;';
     Module.OraQuery.Execute;

     // ???? ????? - ???????? ??????????? ??????????????
     if LNeedSendNotification and AssignForm.NotifyCheckBox.Checked then
         Module.SendEmailNotification( IncidentNum );



     GetIncidentMovements;
     UpdateMovements;
     UpdateReasonEdit;

     EnableMovementControls( false );
     UpdateMovementsGrid;

     MovementsGrid.Enabled := true;
     MainForm.RefreshIncidents;
  end;

  EditButton.Enabled := true;
end;

procedure TIncidentMoveForm.RemoveScreenButtonClick(Sender: TObject);
begin
  DeleteScreenListItem;
end;

procedure TIncidentMoveForm.ScreenListBoxKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 46 then DeleteScreenListItem;
end;

procedure TIncidentMoveForm.DeleteScreenListItem;
var n : integer;
begin
  n := ScreenListBox.ItemIndex;
  ScreenListBox.Items.Delete( ScreenListBox.ItemIndex );
  if ScreenListBox.Items.Count > 0 then
  begin
    if n > 0 then ScreenListBox.Selected[n-1] := true
     else ScreenListBox.Selected[0] := true;
  end;
end;

procedure TIncidentMoveForm.AssignResponsibleButtonClick(Sender: TObject);
begin
  Module.AssignDataSet.SetVariable('INCIDENT_CLASS',IncidentClassEdit.Text);
  AssignForm.ShowModal;
  if AssignForm.Selected  then NeedUpdateResponsible := true;
end;

procedure TIncidentMoveForm.NextButtonClick(Sender: TObject);
begin
  Inc(FCurrRecord);
  Module.MoveDataSet.RecNo :=  Module.MoveDataSet.RecNo + 1;
  UpdateMovements;
end;

procedure TIncidentMoveForm.PrevButtonClick(Sender: TObject);
begin
  Dec(FCurrRecord);
  Module.MoveDataSet.RecNo :=  Module.MoveDataSet.RecNo - 1;
  UpdateMovements;
end;

procedure TIncidentMoveForm.MovementsGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  Module.PaintGrid(MovementsGrid, Module.MoveDataSet,Rect, DataCol, Column, State);
end;

procedure TIncidentMoveForm.MovementsGridCellClick(Column: TColumn);
begin
  FCurrRecord := Module.MoveDataSet.RecNo-1;
  UpdateMovements;
end;

procedure TIncidentMoveForm.GenerateWordButtonClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  Module.CreateWordDocument( IncidentNum, true );
  Screen.Cursor := crDefault;
end;

procedure TIncidentMoveForm.MovementsGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//  FCurrRecord := Module.MoveDataSet.RecNo-1;

  if (Key = 40) and (FCurrRecord+1 < FCount) then
    Inc(FCurrRecord)
  else if (Key = 38) and (FCurrRecord > 0) then
    Dec(FCurrRecord);


//  FCurrRecord := Module.MoveDataSet.RecNo-1;
  UpdateMovements;
end;

procedure TIncidentMoveForm.AssignComboBoxChange(Sender: TObject);
begin
  UpdateAssignButton;
  UpdateChangeClassButton;
  UpdateChangeScaleButton;
end;

procedure TIncidentMoveForm.DescMemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 65) and (ssCtrl in Shift ) then
  begin
    DescMemo.SelectAll;
  end;
end;

procedure TIncidentMoveForm.ScaleChangeButtonClick(Sender: TObject);
var s : string;
begin
  ScaleSelectionForm.ShowModal;
  if (ScaleSelectionForm.Selected) then
  begin
    s := Module.ScaleDataSetNUM_SCALE.AsString;
    if s <> '' then
    begin
      Module.OraQuery.SQL.Text := 'update incident_card t set t.num_scale = ' + QuotedStr(s) + ' where t.num_incident = ' + IntToStr(IncidentNum);
      Module.OraQuery.Execute;
      ScaleEdit.Text := Module.ScaleDataSetNAME_SCALE.AsString;;
    end;
  end;
end;


procedure TIncidentMoveForm.ClassChangeButtonClick(Sender: TObject);
var s : string;
    LResult : integer;
begin
  ClassSelectionForm.ShowModal;
  if ( ClassSelectionForm.Selected ) then
  begin


     Module.AssignDataSet.SetVariable('INCIDENT_CLASS', Module.ClassDataSet2NAME_CLASS.AsString );

     LResult := MessageDlg('??????? ???????????????', mtConfirmation, [mbYes,mbNo], 0);
     if (LResult = mrYes)  then
     begin
       AssignForm.ShowModal;
       if AssignForm.Selected then
       begin
         // ??? ????? ?????? ????????? ??????????????
         s := Module.AssignDataSetID_WORK.AsString;
         if s <>'' then
         begin
           Module.OraQuery.SQL.Text := 'update incident_card t set t.responsible_inc = ' + QuotedStr(s) + ' where t.num_incident = ' + IntToStr(IncidentNum);
           Module.OraQuery.Execute;
           ResponsibleEdit.Text := Module.AssignDataSetWORKER.AsString;
         end;

         Module.OraQuery.SQL.Text := 'Select t1.worker from personnel t1, incident_card t2 where t1.id_work = t2.responsible_inc and t2.num_incident = ' + IntToStr(IncidentNum);
         Module.OraQuery.Execute;
         DescMemo.Text := DescMemo.Text + #13#10 + '<< ????????: ' + Module.OraQuery.Field(0) + ' >>';

        // ??????? ????????? ???????? ???????? ????????? ?? ???????? '????????'
         Module.OraQuery2.SQL.Text :=' begin ' +
          ' :RES:=Incident_move_card_package.InsertIncidentMove (' +
           IntToStr(IncidentNum) + ',' +
           '''' + '????????' +''',' +
           '''' + NS(DescMemo.Text) + ''','+
           '''' + CreationDateEdit.Text + '''' +
          ');' +
         'end;';
         s := Module.OraQuery2.SQL.Text;
         Module.OraQuery2.Execute;
       end;
     end;






       s := Module.ClassDataSet2NUM_CLASS.AsString;
       if s <> '' then
       begin
         Module.OraQuery.SQL.Text := 'update incident_card t set t.num_class = ' + QuotedStr(s) + ' where t.num_incident = ' + IntToStr(IncidentNum);
         Module.OraQuery.Execute;
         IncidentClassEdit.Text := Module.ClassDataSet2NAME_CLASS.AsString;
       end;


     // ??????
     Module.OraQuery.SQL.Text := 'begin commit; end;';
     Module.OraQuery.Execute;

   // ???? ????? - ???????? ??????????? ??????????????
     if (AssignForm.NotifyCheckBox.Checked) and (LResult = mrYes) then
       Module.SendEmailNotification( IncidentNum );



     GetIncidentMovements;
     UpdateMovements;
     UpdateReasonEdit;

     EnableMovementControls( false );
     UpdateMovementsGrid;

     MovementsGrid.Enabled := true;
     MainForm.RefreshIncidents;



  end;
end;

procedure TIncidentMoveForm.UpdateReasonEdit;
var s : string;
begin
  try
    Module.OraQuery.SQL.Text := 'select t1.name_source from incident_source t1, incident_card t2 where t1.num_source = t2.num_source and t2.num_incident = ' + IntToStr(IncidentNum);
    Module.OraQuery.Execute;
    if ( Module.OraQuery.RowCount > 0) then
    s := Module.OraQuery.Field(0);
  except
   // if s = '' then s := '?? ???????????';
  end;
  ReasonEdit.Text := s;
end;


procedure TIncidentMoveForm.BaseButtonClick(Sender: TObject);
begin
   Module.ResetFilter(MainFormFilter);
    MainFormFilter.ClassValueEdit.Text := IncidentClassEdit.Text;
   Close;
   GSettings.ClassIncident := IncidentClassEdit.Text;
   MainForm.ApplyFilter;
end;

                                          

procedure TIncidentMoveForm.OnMovementsGridScroll;
begin
  if FReady then
  begin
    FCurrRecord :=  Module.MoveDataSet.RecNo-1;
    if (FCurrRecord < FCount) and (FCurrRecord >= 0) then
      UpdateMovements;
  end;
end;

procedure TIncidentMoveForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  MovementsGrid.Enabled := true;
end;

procedure TIncidentMoveForm.InitiatorButtonClick(Sender: TObject);
var s : String;
begin
  try
     Module.OraQuery.SQL.Text := 'SELECT id_work FROM incident_card WHERE num_incident = ' + IntToStr(FIncidentNum) ;
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
  except
    Application.MessageBox('?????? ????????? ????????? ?????????? ? ?????????? ?????????','??????',MB_ICONERROR);
  end;

  UserInfoForm.UserID := Module.OraQuery.Field(0);
  UserInfoForm.ShowModal;
end;

procedure TIncidentMoveForm.OwnerButtonClick(Sender: TObject);
var s : String;
begin
  try
     Module.OraQuery.SQL.Text := 'SELECT owner_inc FROM incident_card WHERE num_incident = ' + IntToStr(FIncidentNum) ;
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
  except
    Application.MessageBox('?????? ????????? ????????? ?????????? ? ????????? ?????????','??????',MB_ICONERROR);
  end;

  UserInfoForm.UserID := Module.OraQuery.Field(0);
  UserInfoForm.ShowModal;
end;

procedure TIncidentMoveForm.RespButtonClick(Sender: TObject);
var s : String;
begin
  try
     Module.OraQuery.SQL.Text := 'SELECT responsible_inc FROM incident_card WHERE num_incident = ' + IntToStr(FIncidentNum) ;
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
  except
    Application.MessageBox('?????? ????????? ????????? ?????????? ?? ????????????? ?? ?????????','??????',MB_ICONERROR);
  end;

  UserInfoForm.UserID := Module.OraQuery.Field(0);
  UserInfoForm.ShowModal;
end;



procedure TIncidentMoveForm.EditButtonClick(Sender: TObject);
begin
  EditButton.Visible := false;
  ApplyEditButton.Visible := true;
  DescMemo.ReadOnly := false;
end;


procedure TIncidentMoveForm.ApplyEditButtonClick(Sender: TObject);
var
  LCurrent : integer;
begin
  ApplyEditButton.Visible := false;
  EditButton.Visible := true;

  try
    Module.MoveDataSet.Edit;
    Module.MoveDataSet.Fields[4].AsString := NS(DescMemo.Text);
    Module.MoveDataSet.Post;

    LCurrent := Module.MoveDataSet.RecNo;
    GetIncidentMovements;
    UpdateMovements;
    Module.MoveDataSet.RecNo := LCurrent;

 except
    Application.MessageBox('?????? ?????????? ???????? ?????????','??????',MB_ICONERROR);
  end;
  DescMemo.ReadOnly :=  true;
end;


end.


