unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Oracle, Grids, StdCtrls, Buttons, DBGrids,user,db, SxkDBGrid,OracleData,
  ComCtrls, global, settings, ExtCtrls;

type
  TMainForm = class(TForm)
    IncidentGroupBox: TGroupBox;
    ResponsibleButton: TSpeedButton;
    SearchNumberLabel: TLabel;
    SearchNumberEdit: TEdit;
    IncidentGrid: TSxkDBGrid;
    FilterButton: TSpeedButton;
    FilterStatusBar: TStatusBar;
    OptionsButton: TSpeedButton;
    IncidentAmountLabel1: TLabel;
    IncidentAmountLabel2: TLabel;
    IncidentMonthMemo: TMemo;
    RequestButton: TSpeedButton;
    ReportButton: TSpeedButton;
    CloseButton: TBitBtn;
    RefreshButton: TBitBtn;
    SearchNumberButton: TBitBtn;
    RegisterButton: TBitBtn;
    DataButton: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure IncidentGrid1DblClick(Sender: TObject);
    procedure RegisterButtonClick(Sender: TObject);
    procedure ResponsibleButtonClick(Sender: TObject);
    procedure DataButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure IncidentGrid1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure RefreshButtonClick(Sender: TObject);
    procedure SearchNumberButtonClick(Sender: TObject);
    procedure SearchNumberEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure IncidentGridDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure IncidentGridDblClick(Sender: TObject);
    procedure FilterButtonClick(Sender: TObject);
    procedure OptionsButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IncidentGridKeyPress(Sender: TObject; var Key: Char);
    procedure IncidentGridCellClick(Column: TColumn);
    procedure IncidentGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure IncidentMonthMemoKeyPress(Sender: TObject; var Key: Char);
    procedure IncidentMonthMemoChange(Sender: TObject);
    procedure IncidentMonthMemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RequestButtonClick(Sender: TObject);
    procedure ReportButtonClick(Sender: TObject);
  private

    FOldWidth, FOldHeight : integer;
    FMainQuery : string;
    FFastFiltered : boolean;

    FColumns : array [1..COLUMNS_COUNT] of integer;
    FColumnsCount : integer;

    //
    procedure SetColumn(i, value : integer);
    function GetColumn(i : integer) : integer;

    procedure LoadColumns;
    procedure SaveColumns;

    // Процедура регистрации инцидента
    procedure RegisterIncident;

    //  Показать данные инцидента
    procedure ShowIncidentData;

    // Поиск инцидента по номеру
    procedure SearchByNumber;

      // Обновление filter label
    procedure UpdateFilterBar;

    // Обновление видимости столбцов
    procedure UpdateVisibility;

   // Применение ограничения по месяцам
    function AppendMonthRestriction( strQuery : string ) : string;

    procedure MultiLineMemoToSingleLine;

  public
    procedure RefreshIncidents;

    // Предназначена для иннициации фильтрацции из другой формы
    procedure ApplyFilter;


    property MainQuery : string read FMainQuery write FMainQuery;
    property Columns[i: Integer] : integer read GetColumn write SetColumn;
    property ColumnsCount : integer read FColumnsCount write FColumnsCount;



  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses register, incident_move, responsible, main_filter, options,
  fast_filter, request, reports;

procedure TMainForm.SetColumn(i,value : integer);
begin
  FColumns[i] := value;
end;


function TMainForm.GetColumn(i : integer) : integer;
begin
  Result := FColumns[i];
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  
   // Check out user privileges
   if (GUser.UserRole < HD_REGISTRATOR) then
   begin
     RegisterButton.Visible := false;
     RequestButton.Visible := false;
   end;

   if (GUser.UserRole < HD_MANAGER) then
   begin
     ResponsibleButton.Visible := false;
   end;

   if (not (HD_REPORTVIEW in GUser.ExtraRoles)) and
     (GUser.UserRole <> HD_ADMIN ) then
   begin
//     ResponsibleButton.Visible := false;
     ReportButton.Visible := false;
   end;

   LoadColumns;
   Application.BringToFront;
end;

procedure TMainForm.LoadColumns;
var i : integer;
begin
   ColumnsCount := COLUMNS_COUNT;

   for i := 1 to ColumnsCount do
     Columns[i] := GSettings.Columns[i];
     
end;

procedure TMainForm.SaveColumns;
var i : integer;
begin
  for i := 1 to ColumnsCount do
     GSettings.Columns[i] := Columns[i];
end;


procedure TMainForm.RegisterIncident;
begin
   RegisterForm.Show;
   RegisterForm.BringToFront;
end;

procedure TMainForm.IncidentGrid1DblClick(Sender: TObject);
begin
  ShowIncidentData;
end;                                      

procedure TMainForm.RegisterButtonClick(Sender: TObject);
begin
  RegisterIncident;
end;

procedure TMainForm.ResponsibleButtonClick(Sender: TObject);
begin
  ResponsibleForm.ShowModal;
end;

procedure TMainForm.ShowIncidentData;
begin
  IncidentMoveForm.IncidentNum := StrToInt64(IncidentGrid.Fields[0].AsString);
  IncidentMoveForm.ShowModal;

end;

procedure TMainForm.DataButtonClick(Sender: TObject);
begin
   ShowIncidentData;
end;

procedure TMainForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.IncidentGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  Module.PaintGrid(IncidentGrid, Module.OraDataSet,Rect, DataCol, Column, State);
end;

procedure TMainForm.FormShow(Sender: TObject);

begin
  FOldWidth := Width;
  FOldHeight := Height;

  Caption := Caption + Module.Version + ' - пользователь ' + GUser.UserName;
  MainQuery := Module.OraDataSet.SQL.Text;
  MainFormFilter.Apply;
  UpdateFilterBar;
  FilterStatusBar.Color := Module.EvenColor;

  Module.UpdateColumnTitle(FilterStatusBar, IncidentGrid);
  UpdateVisibility;



  IncidentMonthMemo.Text := IntToStr(GSettings.IncidentMonths);
  RefreshIncidents;
end;

procedure TMainForm.ApplyFilter;
begin
  MainFormFilter.Apply;
  UpdateFilterBar;
  FilterStatusBar.Color := Module.EvenColor;

  Module.UpdateColumnTitle(FilterStatusBar, IncidentGrid);
  UpdateVisibility;
  RefreshIncidents;
end;

procedure TMainForm.FormResize(Sender: TObject);

begin
  FOldWidth := Width;
  FOldHeight := Height;
end;

procedure TMainForm.RefreshButtonClick(Sender: TObject);
begin
  RefreshIncidents;
end;

procedure TMainForm.MultiLineMemoToSingleLine;
var
  t: string;
begin
  t := IncidentMonthMemo.Text;
  if Pos(#13, t) > 0 then
  begin
    while Pos(#13, t) > 0 do
      delete(t, Pos(#13, t), 1);
    while Pos(#10, t) > 0 do
      delete(t, Pos(#10, t), 1);
    IncidentMonthMemo.Text := t;
  end;
end;


function TMainForm.AppendMonthRestriction( strQuery : string ) : string;
var s,s1,s2 : string;
    d : TDateTime;
    n : integer;
begin

  n := GSettings.IncidentMonths;
  try
    GSettings.IncidentMonths := StrToInt(IncidentMonthMemo.Text);
  except
    Application.MessageBox('Вы указали неккоректное число месяцев для ограничения списка инцидентов',
      'Ошибка', MB_ICONERROR);
    GSettings.IncidentMonths := n;
    IncidentMonthMemo.Text := IntToStr(n);
  end;

  // Берем с сервера текущую дату
  Module.DateTimeOraQuery.SQL.Text :=' begin ' +
     ' :DATETIME:=Misc_package.GetCurrentDateTime; ' +
     ' end; ';
  Module.DateTimeOraQuery.Execute;
  s :=  Module.DateTimeOraQuery.GetVariable('DATETIME');

  s1 := Copy(s,1, 10);
  d := IncMonth(StrToDate(s1),-GSettings.IncidentMonths);
  s2 := DateToStr(d);
  n := Pos('order', strQuery);
  s := StringReplace(s,s1,s2, [rfReplaceAll]);
  Insert( ' and t2.date_create > to_date(' + QuotedStr(s) +',''DD.MM.YYYY HH24:MI:SS'') ', strQuery, n);
  result := strQuery;
end;

procedure TMainForm.RefreshIncidents;
var n : integer;
    s : string;
    strQuery : string;
begin

    Screen.Cursor := crSqlWait;


    MainForm.ActiveControl := IncidentGrid;
    strQuery := Module.OraDataSet.SQL.Text;
    Module.OraDataSet.SQL.Text :=  AppendMonthRestriction(  Module.OraDataSet.SQL.Text );


    if not Module.OraDataSet.Active then Module.OraDataSet.Active := true;
 //   Application.BringToFront;

    if  Module.OraDataSet.Active then
    begin
     try
       Module.OraDataSet.Filtered := false;
       FFastFiltered := false;

     // пользователь с ролью <= HD_RESPONSIBLE должен видеть только свои инциденты
  //   if (GUser.UserRole <= HD_RESPONSIBLE )then
  //   begin
  //      s :=  Module.OraDataSet.SQL.Text;
  //      n := Pos('order', s);
  //      Module.OraDataSet.SQL.Text := Copy(s,0,n-1) + ' and t2.responsible_inc = ' + QuotedStr(GUser.UserName) + Copy(s,n-1, length(s) - n+2);
  //   end;

       n := Module.OraDataSet.RecNo;
       Module.OraDataSet.Refresh;
     except
       FilterStatusBar.Panels[0].Text := ' Некорректные данные';
       Application.MessageBox('Невозможно обновить список инцидентов. Возможно неправильно построен фильтр','Ошибка',MB_ICONERROR);
       Screen.Cursor := crDefault;
       exit;
     end;
     Module.OraDataSet.RecNo := n;

     // Определение сколько всего инцидентов
     Module.OraQuery.SQL.Text := 'select total_count from incident_count';
     Module.OraQuery.Execute;

     s := Module.OraQuery.Field(0);
     FilterStatusBar.Panels[2].Text := ' Всего инцидентов : ' +  s + ' / Отображается : ' +  IntToStr(Module.OraDataSet.RecordCount);

     UpdateFilterBar;
    end;

    Module.OraDataSet.SQL.Text :=  strQuery;
    Screen.Cursor := crDefault;
end;

procedure TMainForm.SearchNumberButtonClick(Sender: TObject);
begin
  SearchByNumber;
end;



procedure TMainForm.SearchNumberEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then SearchByNumber;
end;

procedure TMainForm.SearchByNumber;
var n  : integer;
    bFound : boolean;
begin
  MainForm.ActiveControl := IncidentGrid;
  try
    n := StrToInt(SearchNumberEdit.Text);
  except
    Application.MessageBox(PChar('Неправильный номер инцидента'),'Ошибка');
    exit;
  end;

  if n > 9300000 then
  begin
    Application.MessageBox(PChar('Неправильный номер инцидента'),'Ошибка');
    exit;
  end;

  bFound := Module.OraDataSet.SearchRecord('num_incident',n,[srFromBeginning ]);

  if not bFound then
  begin
    Application.MessageBox(PChar('Инцидент № ' + SearchNumberEdit.Text + ' не найден'),'Ошибка');
    exit;
  end;
end;


procedure TMainForm.IncidentGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   Module.PaintGrid(IncidentGrid, Module.OraDataSet,Rect, DataCol, Column, State);
end;

procedure TMainForm.IncidentGridDblClick(Sender: TObject);
begin
   ShowIncidentData;
end;

procedure TMainForm.FilterButtonClick(Sender: TObject);
begin
  MainFormFilter.ShowModal;
  RefreshIncidents;
end;

procedure TMainForm.UpdateFilterBar;
begin
  if (MainFormFilter.Filtered) or FFastFiltered then
    FilterStatusBar.Panels[0].Text := ' Данные отфильтрованы'
  else
    FilterStatusBar.Panels[0].Text := ' Данные не отфильтрованы';
end;


procedure TMainForm.OptionsButtonClick(Sender: TObject);
begin
  OptionsForm.ShowModal;
  UpdateVisibility;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveColumns;
end;

procedure TMainForm.UpdateVisibility;
var i : integer;
begin
  for i := 1 to ColumnsCount do
    if Columns[i] = VISIBLE_COLUMN then
      IncidentGrid.Columns[i-1].Visible := true else IncidentGrid.Columns[i-1].Visible := false;
end;

procedure TMainForm.IncidentGridKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key <> #13) and (Key <> #27) then
  begin
    Module.FastFilter(Key,self, Module.OraDataSet, IncidentGrid, FFastFiltered);
    UpdateFilterBar;
  end;
end;

procedure TMainForm.IncidentGridCellClick(Column: TColumn);
begin
  Module.UpdateColumnTitle( FilterStatusBar, IncidentGrid);
end;


procedure TMainForm.IncidentGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var r : integer;
    num : int64;
begin
  if (Key = 46) and (GUser.UserRole = HD_ADMIN) then
  begin
     num := StrToInt64(IncidentGrid.Fields[0].AsString);
     r := MessageDlg('Вы действительно хотите удалить инцидент ' + IntToStr(num) + ' ?', mtConfirmation, [mbYes, mbNo],0);
     if r = mrYes then
     begin
    // Удаляем инцидент
      with Module.OraQuery2 do
      begin
        SetVariable('RES', num);
        SQL.Text :=
         'begin ' +
         ' INCIDENT_CARD_PACKAGE.TerminateIncident( :RES ); ' +
         'end;';
         Execute;
         RefreshIncidents;
      end;
    end;
  end
  else if Key = 116 then RefreshIncidents;
end;

procedure TMainForm.IncidentMonthMemoKeyPress(Sender: TObject;
  var Key: Char);
begin
  MultiLineMemoToSingleLine;
end;

procedure TMainForm.IncidentMonthMemoChange(Sender: TObject);
begin
  MultiLineMemoToSingleLine;
end;

procedure TMainForm.IncidentMonthMemoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if (Key = 13) then
     RefreshIncidents;
end;

procedure TMainForm.RequestButtonClick(Sender: TObject);
begin
  RequestForm.Show;
end;

procedure TMainForm.ReportButtonClick(Sender: TObject);
begin
  ReportForm.ShowModal;
end;

end.
