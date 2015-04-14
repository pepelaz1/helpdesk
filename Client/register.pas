unit register;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Spin, DateUtils,user, Buttons, Oracle;

type
  TRegisterForm = class(TForm)
    ApplyButton: TButton;
    CancelButton: TButton;
    RegisterGroupBox: TGroupBox;
    ElementLabel: TLabel;
    BrowseInitiatorButton: TButton;
    InitiatorLabel: TLabel;
    CreationDateLabel: TLabel;
    ClassLabel: TLabel;
    ScaleLabel: TLabel;
    PriorityLabel: TLabel;
    InitiatorEdit: TEdit;
    BrowseElementButton: TButton;
    ElementEdit: TEdit;
    DateEdit: TEdit;
    BrowseDateButton: TButton;
    PriorityEdit: TSpinEdit;
    FixDataLabel: TLabel;
    FixDateEdit: TEdit;
    BrowseFixDateButton: TButton;
    IncidentNumberLabel: TLabel;
    IncidentNumberEdit: TEdit;
    DescMemo: TMemo;
    DescLabel: TLabel;
    ScreenshotLabel: TLabel;
    ScreenListBox: TListBox;
    AddScreenButton: TSpeedButton;
    RemoveScreenButton: TSpeedButton;
    AssignLabel: TLabel;
    AssignComboBox: TComboBox;
    ScaleComboBox: TComboBox;
    NotifyCheckBox: TCheckBox;
    ClassEdit: TEdit;
    ClassButton: TButton;
    IncidentTypeLabel: TLabel;
    TypesComboBox: TComboBox;
    procedure BrowseInitiatorButtonClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure BrowseElementButtonClick(Sender: TObject);
    procedure BrowseDateButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure BrowseFixDateButtonClick(Sender: TObject);
    procedure ScaleComboBoxExit(Sender: TObject);
    procedure AddScreenButtonClick(Sender: TObject);
    procedure ScreenListBoxDblClick(Sender: TObject);
    procedure RemoveScreenButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ClassComboBoxChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScreenListBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AssignComboBoxChange(Sender: TObject);
    procedure ClassButtonClick(Sender: TObject);
    procedure ClassEditChange(Sender: TObject);
    procedure DescMemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PriorityEditChange(Sender: TObject);

  private
    FStrImages : TStringList;
    FStrResponsibilies : TStringList;

    //  Проверяет входные параметры
    function Validate : boolean;

    // Обновляет комбобокс с ответственными
    procedure UpdateResponsibiles;

    // Обновление время устранения инцидента в соответствии с масштабом
    procedure UpdateFixTime;

    // Генерация номера инцидента
    function GenerateIncidentNumber : string;

    // Удаление скриншота из списка
    procedure DeleteScreenListItem;

    procedure UpdateNotifyCheckBox;
    procedure FillScaleCombo;
    procedure FillTypesCombo;
  public
    { Public declarations }
  end;

var
  RegisterForm: TRegisterForm;

implementation

{$R *.dfm}

uses global, initiator_selection, element_selection, date_selection,
  showimage, progress, class_selection, main;


procedure TRegisterForm.BrowseInitiatorButtonClick(Sender: TObject);
begin
  InitiatorSelectionForm.ShowModal;
end;

function TRegisterForm.Validate : boolean;
var b : boolean;
begin
  b := true;
  if IncidentNumberEdit.Text = '' then
  begin
    Application.MessageBox('Поле "Номер инцидента" обязательно для заполнения','Ошибка');
    result := false;
    exit;
  end;

  if InitiatorEdit.Text = '' then
  begin
     Application.MessageBox('Поле "Инициатор" обязательно для заполнения', 'Ошибка');
    result := false;
    exit;
  end;

  if ElementEdit.Text = '' then
  begin
     Application.MessageBox('Поле "Элемент инфраструктуры" обязательно для заполнения', 'Ошибка');
    result := false;
    exit;
  end;

  if FixDateEdit.Text = '' then
  begin
     Application.MessageBox('Поле "Дата устранения" обязательно для заполнения', 'Ошибка');
    result := false;
    exit;
  end;
  result := b;
end;

procedure TRegisterForm.ApplyButtonClick(Sender: TObject);
var s,t : string;
    status : string;
    result : double;
    i : integer;
    LOB : TLOBLocator;
    b : boolean;
begin

 //  Module.SendEmailNotification(StrToInt(IncidentNumberEdit.Text ));

  if Validate then
  begin

    // Создаем запись в таблице INCIDENT_CARD

    Module.OraQuery.SQL.Text :=' begin ' +
      'Incident_card_package.InsertIncident (' +
      IncidentNumberEdit.Text + ',' +
      '''' + Module.InitiatorDataSetID_WORK.AsString  + ''',' +
      '''' + FStrResponsibilies[ AssignComboBox.ItemIndex  ] + ''','+
      '''' + Module.ElementDataSetNUM_DEVICE.AsString + ''','+
//      IntToStr(Integer(ClassComboBox.Items.Objects [ClassComboBox.ItemIndex]))  +','+
      Module.ClassDataSet2NUM_CLASS.AsString  +','+
      '''' + DateEdit.Text + ''','+
      '''' + FixDateEdit.Text + ''','+
      IntToStr(Integer(ScaleComboBox.Items.Objects [ScaleComboBox.ItemIndex]))  +','+
      PriorityEdit.Text  + ','+
      IntToStr(Integer(TypesComboBox.Items.Objects [TypesComboBox.ItemIndex]))  +
      ');'+
      'end;';

     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;



     // Создаем движение текущего инцидента со статусом
     // 'Создан' если ответственный не назначен
     // И 'Назначен' в противном случае
     t :=  Format('%0.2d.%0.2d.%0.2d  %0.2d:%0.2d', [DayOf(Date), MonthOf(Date),YearOf(Date), HourOf(Time),MinuteOf(Time)]);
     if AssignComboBox.Text ='Не назначать' then status := 'Создан' else  status := 'Назначен';

     if (status = 'Назначен') then
       DescMemo.Text := DescMemo.Text + #13#10 + '<< Назначен: ' + AssignComboBox.Text + ' >>';


     Module.OraQuery2.SQL.Text :=' begin ' +
      ' :RES:=Incident_move_card_package.InsertIncidentMove (' +
       IncidentNumberEdit.Text + ',' +
       '''' + status +''',' +
       '''' + NS(DescMemo.Text) + ''','+
       '''' + t + '''' +
      ');' +
     'end;';

     s := Module.OraQuery2.SQL.Text;
   //  ShowMessage(s);
     Module.OraQuery2.Execute;

      //  Получаем id только созданной записи в таблице INCIDENT_MOVE_CARD
      result := Module.OraQuery2.GetVariable('RES');

      // Добавляем скриншоты к созданному движению

      ProgressForm.Show;
      ProgressForm.Gauge.Progress := 1;
      ProgressForm.Gauge.Progress := 0;
      b := (NotifyCheckBox.Checked) and (NotifyCheckBox.Enabled);

      for i := 0 to ScreenListBox.Count - 1 do
      begin
//         ProgressForm.Gauge.Progress := ProgressForm.Gauge.MaxValue * (i+1) div  ScreenListBox.Count;
         ProgressForm.MoveProgress(ProgressForm.Gauge.MaxValue * (i+1) div  (ScreenListBox.Count + integer(b)));
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

           LOB.LoadFromFile( ImageForm.GetLastFileName );
           LOB.Free;

          end;
       end;

      // Коммит
      Module.OraQuery.SQL.Text := 'begin commit; end;';
      Module.OraQuery.Execute;

      if b then
      begin
         Module.SendEmailNotification(StrToInt(IncidentNumberEdit.Text ));
         ProgressForm.MoveProgress(ProgressForm.Gauge.MaxValue * (ScreenListBox.Count+1) div  (ScreenListBox.Count + integer(b)));
      end;
      ProgressForm.Close;

      Close;
      MainForm.RefreshIncidents;

   end;
end;

procedure TRegisterForm.BrowseElementButtonClick(Sender: TObject);
begin
  ElementSelectionForm.ShowModal;
end;

procedure TRegisterForm.BrowseDateButtonClick(Sender: TObject);
var  s: string;
begin
  s := DateEdit.Text;
  CalendarForm.Hours := StrToInt(Copy(s,12,2));
  CalendarForm.Minutes := StrToInt(Copy(s,15,2));
  CalendarForm.Seconds := StrToInt(Copy(s,18,2));

  CalendarForm.ShowModal;
  if CalendarForm.IsSet then
  begin

    DateEdit.Text  := Format('%0.2d.%0.2d.%0.2d %s',[CalendarForm.CalendarControl.Day,
      CalendarForm.CalendarControl.Month,CalendarForm.CalendarControl.Year, CalendarForm.TimeEdit.Text  ]);
  end;
end;

procedure TRegisterForm.BrowseFixDateButtonClick(Sender: TObject);
var s : string;
begin
  s := FixDateEdit.Text;
  CalendarForm.Hours := StrToInt(Copy(s,12,2));
  CalendarForm.Minutes := StrToInt(Copy(s,15,2));
  CalendarForm.Seconds := StrToInt(Copy(s,18,2));

  CalendarForm.ShowModal;
  if CalendarForm.IsSet then
  begin
    FixDateEdit.Text  := Format('%0.2d.%0.2d.%0.2d %s',[CalendarForm.CalendarControl.Day,
      CalendarForm.CalendarControl.Month,CalendarForm.CalendarControl.Year, CalendarForm.TimeEdit.Text  ]);
  end;
end;

procedure TRegisterForm.FormCreate(Sender: TObject);
begin
  FStrImages := TStringList.Create;
  FStrResponsibilies := TStringList.Create;
end;

function  TRegisterForm.GenerateIncidentNumber : string;
var s : string;
begin
//  s := Format('%0.2d%0.2d%0.2d%0.2d%0.2d%0.2d', [DayOf(Date), MonthOf(Date),YearOf(Date), HourOf(Time),MinuteOf(Time), SecondOf(Time)]);
//  Result := StrToInt64(s);
   Module.IncGetIDOraQuery.SQL.Text := 'begin ' +
    ':INCIDENT_ID := INCIDENT_CARD_PACKAGE.GetIncidentNumber(); ' +
    'end;';
   Module.IncGetIDOraQuery.Execute;
   s := Module.IncGetIDOraQuery.GetVariable('INCIDENT_ID');
   Result := s;

end;

procedure TRegisterForm.UpdateResponsibiles;
var s : string;
begin
  if ClassEdit.Text = '' then exit;
  
  FStrResponsibilies.Clear;
  try


   Module.OraQuery.SQL.Text :=
      'select t1.worker, t1.id_work from ' +
      'personnel t1, ' +
      'responsible t2, ' +
      'classifier_view_new t3 where ' +
      't3.num_class = ' + Module.ClassDataSet2NUM_CLASS.AsString + ' and ' +
      't3.num_class = t2.num_class and ' +
      't1.id_work = t2.id_work' +
      ' order by t1.worker';

    s := Module.OraQuery.SQL.Text;
    Module.OraQuery.Execute;
  except
    Application.MessageBox(PChar('Ошибка обновления списка ответственных для класса инцидента ' +  ClassEdit.Text), 'Ошибка');
    exit;
  end;

  AssignComboBox.Clear;
  while not Module.OraQuery.Eof do
  begin
    AssignComboBox.AddItem( Module.OraQuery.Field(0),nil);
    FStrResponsibilies.Add( Module.OraQuery.Field(1));
    Module.OraQuery.Next;
  end;
  AssignComboBox.AddItem('Не назначать',nil);
  FStrResponsibilies.Add('0');
  AssignComboBox.ItemIndex := 0;

  UpdateNotifyCheckBox;
end;

procedure TRegisterForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;


procedure TRegisterForm.ScaleComboBoxExit(Sender: TObject);
begin
  ScaleComboBox.Repaint;
end;

procedure TRegisterForm.AddScreenButtonClick(Sender: TObject);
var s : string;
    i : integer;
begin
  if Module.OpenFileDialog.Execute then
  begin
    for i := 0 to  Module.OpenFileDialog.Files.Count-1 do
    begin
      s := Format('Снимок - %0.2d.%0.2d.%0.2d  %0.2d:%0.2d:%0.2d', [DayOf(Date), MonthOf(Date),YearOf(Date), HourOf(Time),MinuteOf(Time), SecondOf(Time)]);
      FStrImages.Add(Module.OpenFileDialog.Files[i]);
      ScreenListBox.AddItem(s,nil);
    end;
  end;

end;

procedure TRegisterForm.ScreenListBoxDblClick(Sender: TObject);
var s : string;
begin
  s :=  FStrImages[ScreenListBox.ItemIndex];
  if (ImageForm.LoadImage(s )) then
    ImageForm.ShowModal;
end;

procedure TRegisterForm.RemoveScreenButtonClick(Sender: TObject);
begin
  DeleteScreenListItem;
end;

procedure TRegisterForm.DeleteScreenListItem;
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

procedure TRegisterForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FStrImages.Clear;
  FStrResponsibilies.Clear;
end;

procedure TRegisterForm.ClassComboBoxChange(Sender: TObject);
begin
  UpdateResponsibiles;
end;

procedure TRegisterForm.FormShow(Sender: TObject);
var i : integer;
    s : string;
begin
  Module.ClassDataSet2.Active := true;
  Module.ScaleDataSet.Active := true;

  IncidentNumberEdit.Color := Module.EvenColor;
  InitiatorEdit.Color := Module.EvenColor;
  ElementEdit.Color := Module.EvenColor;
  DateEdit.Color := Module.EvenColor;
  FixDateEdit.Color := Module.EvenColor;
  ClassEdit.Color := Module.EvenColor;
  ScaleComboBox.Color := Module.EvenColor;
  PriorityEdit.Color := Module.EvenColor;
  AssignComboBox.Color := Module.EvenColor;
  DescMemo.Color := Module.EvenColor;
  ScreenListBox.Color := Module.EvenColor;
  TypesComboBox.Color := Module.EvenColor;

  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TEdit then TEdit(Components[i]).Text := ''
    else if Components[i] is TMemo then TMemo(Components[i]).Text := '';
  end;

  // Clear images list box
  ScreenListBox.Clear;
  FStrImages.Clear;
  
 // Fill scale combobox
  FillScaleCombo;
  FillTypesCombo;

//  Module.OraQuery.SQL.Text := 'select to_date(creation_date,''DD.MM.YYYY HH24:MI:SS'') from dual';
  Module.OraQuery.SQL.Text := 'select to_char(sysdate, ''DD.MM.YYYY HH24:MI:SS'') from dual';
  Module.OraQuery.Execute;

  s := Module.OraQuery.Field(0);
  DateEdit.Text := s;

  UpdateFixTime;
  UpdateResponsibiles;

  IncidentNumberEdit.Text := GenerateIncidentNumber;
end;

procedure TRegisterForm.FillScaleCombo;
var i: integer;
begin
  Module.OraQuery.SQL.Text := 'select t.num_scale,t.name_scale from incident_scale t order by t.num_scale';
  Module.OraQuery.Execute;

  ScaleComboBox.Clear;
  Module.ScaleDataSet.First;
  i := 0;

  while not Module.OraQuery.Eof do
  begin
    ScaleComboBox.Items.InsertObject( i, Module.OraQuery.Field(1),
      TObject(StrToInt(Module.OraQuery.Field(0))));
    Module.OraQuery.Next;
    Inc(i);
  end;
  ScaleComboBox.ItemIndex := 0;
end;

procedure TRegisterForm.FillTypesCombo;
var i: integer;
begin

  // Заполняем комбобокс с типами инцидентов
  Module.OraQuery.SQL.Text := 'SELECT id_incident_type,name FROM incident_type ORDER BY name';
  Module.OraQuery.Execute;

  TypesComboBox.Clear;
  i := 0;

  while not Module.OraQuery.Eof do
  begin
    TypesComboBox.Items.InsertObject( i, Module.OraQuery.Field(1),
      TObject(StrToInt(Module.OraQuery.Field(0))));
    Module.OraQuery.Next;
    Inc(i);
  end;
  TypesComboBox.ItemIndex := 0;
end;


procedure TRegisterForm.UpdateFixTime;
var   d,m,y,h,mi,se : integer;
      cur_date : TDateTime;
      s : string;
begin

  s := DateEdit.Text;

  d := StrToInt(Copy(s,1,2));
  m := StrToInt(Copy(s,4,2));
  y := StrToInt(Copy(s,7,4));
  h := StrToInt(Copy(s,12,2));
  mi := StrToInt(Copy(s,15,2));
  se := StrToInt(Copy(s,18,2));

  cur_date := EncodeDateTime(y,m,d,h,mi,se,0);

  if PriorityEdit.Text <> '1' then
    cur_date := IncHour(cur_date,4)
  else
    cur_date := IncDay(cur_date,1);

  d := DayOf(cur_date);
  m := MonthOf(cur_date);
  y := YearOf(cur_date);
  h := HourOf(cur_date);
  mi := MinuteOf( cur_date);
  se := SecondOf( cur_date );
  FixDateEdit.Text := Format('%0.2d.%0.2d.%0.2d %0.2d:%0.2d:%0.2d',[d,m,y,h,mi,se]);
end;

procedure TRegisterForm.ScreenListBoxKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 46 then DeleteScreenListItem;
end;

procedure TRegisterForm.UpdateNotifyCheckBox;
begin
  NotifyCheckBox.Enabled := AssignComboBox.Text <> 'Не назначать';
end;

procedure TRegisterForm.AssignComboBoxChange(Sender: TObject);
begin
 UpdateNotifyCheckBox;
end;

procedure TRegisterForm.ClassButtonClick(Sender: TObject);
begin
  ClassSelectionForm.ShowModal;
  UpdateResponsibiles;
end;

procedure TRegisterForm.ClassEditChange(Sender: TObject);
begin
 // UpdateResponsibiles;
end;

procedure TRegisterForm.DescMemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 65) and (ssCtrl in Shift ) then
  begin
    DescMemo.SelectAll;
  end;
end;

procedure TRegisterForm.PriorityEditChange(Sender: TObject);
begin
 UpdateFixTime;
end;

end.
