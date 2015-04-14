unit global;


///////////////////


interface


uses
  SysUtils, Classes, Oracle, DB, OracleData, OleServer, ActiveDs_TLB,
  ActnMan, ActnColorMaps, Dialogs, ExtDlgs, Graphics, Windows, DBGrids, Grids,
  ExtCtrls, forms, stdctrls, OutlookXP,  IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, IdMessage,IdEMailAddress,
   WordXP, comobj, word_tlb, office_tlb, comctrls, strutils, controls,
  frxClass, frxDOAComponents, frxDesgn, frxDCtrl, frxCross, frxChart;

const

  INVISIBLE_COLUMN = 0;
  VISIBLE_COLUMN = 1;
  TMP_VISIBILITY = 2;
  COLUMNS_COUNT = 13;

type
  TModule = class(TDataModule)
    OraSession: TOracleSession;
    OraQuery: TOracleQuery;
    DataSource: TDataSource;
    OraDataSet: TOracleDataSet;
    InitiatorDataSet: TOracleDataSet;
    InitiatorDataSource: TDataSource;
    ElementDataSource: TDataSource;
    ElementDataSet: TOracleDataSet;
    ScaleDataSource: TDataSource;
    ScaleDataSet: TOracleDataSet;
    ScaleDataSetNUM_SCALE: TFloatField;
    ScaleDataSetNAME_SCALE: TStringField;
    InitiatorDataSetWORKER: TStringField;
    InitiatorDataSetLOGIN: TStringField;
    InitiatorDataSetEMAIL: TStringField;
    InitiatorDataSetPHONE: TStringField;
    OraDataSetWORKER: TStringField;
    OraDataSetNAME_DEVICE: TStringField;
    OraDataSetNAME_CLASS: TStringField;
    OraDataSetNAME_SCALE: TStringField;
    OraDataSetPRIORITY: TIntegerField;
    OraDataSetNUM_INCIDENT: TFloatField;
    InitiatorDataSetID_GROUP: TStringField;
    InitiatorDataSetACTIVE: TFloatField;
    InitiatorDataSetID_WORK: TStringField;
    OraLogon: TOracleLogon;
    OpenFileDialog: TOpenDialog;
    OraDataSetOWNER_INC: TStringField;
    ResponsibleDataSource: TDataSource;
    ResponsibleDataSet: TOracleDataSet;
    ResponsibleDataSetNAME_CLASS: TStringField;
    ResponsibleDataSetWORKER: TStringField;
    ResponsibleDataSetNUM_CLASS: TFloatField;
    ResponsibleDataSetID_WORK: TStringField;
    OraQuery2: TOracleQuery;
    OraQuery3: TOracleQuery;
    IncGetIDOraQuery: TOracleQuery;
    AssignDataSet: TOracleDataSet;
    AssignDataSource: TDataSource;
    AssignDataSetWORKER: TStringField;
    AssignDataSetID_WORK: TStringField;
    MovementsOraQuery: TOracleQuery;
    Timer: TTimer;
    ProgressTimer: TTimer;
    OraDataSetNAME_STATE: TStringField;
    MoveDataSource: TDataSource;
    MoveDataSet: TOracleDataSet;
    MoveDataSetNAME_STATE: TStringField;
    MoveDataSetWORKER: TStringField;
    OraDataSetRESPONSIBLE_INC: TStringField;
    Smtp: TIdSMTP;
    OraDataSetINCIDENT_STRING: TStringField;
    MoveDataSetMOVE_DATE: TDateTimeField;
    OraDataSetDATE_CREATE: TDateTimeField;
    OraDataSetDATE_RESOLUTION: TDateTimeField;
    ClassDataSource2: TDataSource;
    ClassDataSet2: TOracleDataSet;
    ClassDataSet2NUM_CLASS: TFloatField;
    ClassDataSet2NAME_CLASS: TStringField;
    ClassDataSet2DESCRIPTION: TStringField;
    ClassDataSet2CATEGORY: TStringField;
    ClassDataSet2ID_TYPE: TFloatField;
    ClassDataSet2NAME_TYPE: TStringField;
    OraDataSetNAME_TYPE: TStringField;
    ReasonDataSet: TOracleDataSet;
    ReasonDataSource: TDataSource;
    ReasonDataSetNUM_SOURCE: TFloatField;
    ReasonDataSetNAME_SOURCE: TStringField;
    ElementDataSetROOM: TStringField;
    ElementDataSetPHONE: TStringField;
    ElementDataSetNUM_DEVICE: TStringField;
    ElementDataSetNAME_DEV: TStringField;
    DateTimeOraQuery: TOracleQuery;
    frxReport: TfrxReport;
    frxDesigner: TfrxDesigner;
    ReportsDataSource: TDataSource;
    ReportsDataSet: TOracleDataSet;
    QryCreateReportAsCopy: TOracleQuery;
    BlobDataSet: TOracleDataSet;
    InitiatorDataSetADDRESS: TStringField;
    frxDialogControls: TfrxDialogControls;
    UserInfoDataSource: TDataSource;
    UserInfoDataSet: TOracleDataSet;
    UserInfoDataSetWORKER: TStringField;
    UserInfoDataSetPHONE: TStringField;
    UserInfoDataSetEMAIL: TStringField;
    UserInfoDataSetADDRESS: TStringField;
    UserInfoDataSetDEPT: TStringField;
    InitiatorDataSetDESCR: TStringField;
    UserInfoDataSetDESCR: TStringField;
    frxChartObject: TfrxChartObject;
    OraDataSetINCIDENT_TYPE: TStringField;
    MoveDataSetNUM_MOVE: TFloatField;
    MoveDataSetDESCRIPTION: TStringField;


    procedure OraSessionAfterLogOn(Sender: TOracleSession);
    procedure DataModuleCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure ProgressTimerTimer(Sender: TObject);
    procedure MoveDataSetAfterScroll(DataSet: TDataSet);
    function frxDesignerSaveReport(Report: TfrxReport;
      SaveAs: Boolean): Boolean;

  private
    FOddColor : TColor;
    FEvenColor : TColor;
    FSelectedColor : TColor;

    FFilterColor : TColor;

    FCreatedColor : TColor;
    FAssignedColor : TColor;
    FProcessingColor : TColor;
    FProcessedColor : TColor;
    FRefusedColor : TColor;
    FClosedColor : TColor;
    FOpenedAgainColor : TColor;

    FUrgentColor : TColor;
    FProblemColor : TColor;


    FVersion : real;
    FStrVersion : string;
  public


    property OddColor : TColor read FOddColor write FOddColor;
    property EvenColor : TColor read FEvenColor write FEvenColor;
    property SelectedColor : TColor read FSelectedColor write FSelectedColor;

    property FilterColor : TColor read FFilterColor write FFilterColor;

    property CreatedColor : TColor read FCreatedColor write FCreatedColor;
    property AssignedColor : TColor read FAssignedColor write FAssignedColor;
    property ProcessingColor : TColor read FProcessingColor write FProcessingColor;
    property ProcessedColor : TColor read FProcessedColor write FProcessedColor;
    property RefusedColor : TColor read FRefusedColor write FRefusedColor;
    property ClosedColor : TColor read FClosedColor write FClosedColor;
    property OpenedAgainColor : TColor read FOpenedAgainColor write FOpenedAgainColor;

    property UrgentColor : TColor read FUrgentColor write FUrgentColor;
    property ProblemColor : TColor read FProblemColor write FProblemColor;

    property Version : string read FStrVersion;


    procedure PaintGrid(Grid : TDBGrid; DataSet : TOracleDataSet;  const Rect: TRect; DataCol: Integer; Column: TColumn;
        State: TGridDrawState; upper : boolean = false);

    procedure ResetFilter( form : TForm );
    procedure PaintFilter( form : TForm );

    procedure UpdateColumnTitle( bar : TStatusBar; grid : TDBGrid );
    procedure FastFilter( key : char; form : TForm;
      ds : TOracleDataSet; grid : TDBGrid; var ff : boolean);

    procedure SendEmailNotification ( incident_num : integer );
    function CreateWordDocument ( incident_num  : integer; noclose : boolean = false) : string;

    // Проверка актуальности версии
    function CheckActualVersion : boolean;
  end;

  function NS( s : string ) : string;
var
  Module: TModule;


implementation

uses progress, main, fast_filter, incident_move, reports;

{$R *.dfm}


function NS( s : string ) : string;
var i : integer;
begin
  for i := 1 to length(s) do
  begin
    if s[i] = '''' then Result := Result + '''''' else Result := Result + s[i];
  end;
end;

procedure TModule.OraSessionAfterLogOn(Sender: TOracleSession);
begin
  // Изменяем схему на helpdesk
  OraQuery.SQL.Text := 'alter session set current_schema=helpdesk';
  OraQuery.Execute;
end;

procedure TModule.DataModuleCreate(Sender: TObject);
begin
  FVersion := 1.45;
  FStrVersion :=' (версия ' + (*FloatToStr(FVersion) + ')';*) Format('%4.2f',[FVersion]) + ')';
//  FloatToStr(FVersion) + ')';
  OddColor := RGB(220,220,255);
  EvenColor := RGB(240,240,255);
  SelectedColor := RGB(170,170,255);

  CreatedColor := clWhite;
  AssignedColor := RGB(115,248,124);
  ClosedColor := RGB(200,150,150);

  UrgentColor := RGB(255,130,130);
  FilterColor := clRed;

  ProblemColor := RGB(230,230,230);
end;

procedure TModule.PaintGrid(Grid : TDBGrid; DataSet : TOracleDataSet;  const Rect: TRect; DataCol: Integer; Column: TColumn;
        State: TGridDrawState; upper : boolean);
begin
try
 if odd(DataSet.RecNo) then
   begin
     if gdSelected in State then
     begin
       with Grid.Canvas do
       begin
          Brush.Color := Module.SelectedColor;
          Font.Color := clBlack;
          FillRect(Rect);
          if upper then TextOut(Rect.Left + 2, Rect.Top + 2, UpperCase(PChar(Column.Field.Text)))
           else TextOut(Rect.Left + 2, Rect.Top + 2, Column.Field.Text);
        end
     end else
     begin
       with Grid.Canvas do
       begin
          Brush.Color := Module.OddColor;

         (* if Column.Field.AsString = 'Создан' then
            Brush.Color := Module.CreatedColor
          else if Column.Field.AsString = 'Назначен' then
             Brush.Color := Module.AssignedColor
          else if Column.Field.AsString = 'В работе' then
            Brush.Color := Module.ProcessingColor
          else if Column.Field.AsString = 'Отклонен' then
             Brush.Color := Module.RefusedColor
          else if Column.Field.AsString = 'Обслужен' then
             Brush.Color := Module.ProcessedColor
          else if Column.Field.AsString = 'Закрыт' then
            Brush.Color := Module.ClosedColor
          else if Column.Field.AsString = 'Открыт повторно' then
            Brush.Color := Module.OpenedAgainColor;    *)

         if (DataSet.Name = 'OraDataSet') and (DataSet.FieldByName('INCIDENT_TYPE').AsString = 'Проблема') then
         begin
           Brush.Color := Module.ProblemColor;
         end;

         if (DataSet.Name = 'OraDataSet') and (DataSet.FieldByName('PRIORITY').AsInteger > 1) then
         begin
           Brush.Color := Module.UrgentColor;
         end;


         Font.Color := clBlack;
         Pen.Color := clBlack;
         FillRect(Rect);

         if upper then TextOut(Rect.Left + 2, Rect.Top + 2, UpperCase(Pchar(Column.Field.Text)))
         else TextOut(Rect.Left + 2, Rect.Top + 2, Column.Field.Text);

       end;
     end;
   end
   else
   begin
     if gdSelected in State then
     begin
       with Grid.Canvas do
       begin
         Brush.Color := Module.SelectedColor;
         Font.Color := clBlack;
         FillRect(Rect);
         if upper then TextOut(Rect.Left + 2, Rect.Top + 2, UpperCase(PChar(Column.Field.Text)))
         else TextOut(Rect.Left + 2, Rect.Top + 2, Column.Field.Text);
       end
     end else
     begin
       with Grid.Canvas do
       begin
         Brush.Color := Module.EvenColor;

        (* if Column.Field.AsString = 'Создан' then
            Brush.Color := Module.CreatedColor
          else if Column.Field.AsString = 'Назначен' then
             Brush.Color := Module.AssignedColor
          else if Column.Field.AsString = 'В работе' then
            Brush.Color := Module.ProcessingColor
          else if Column.Field.AsString = 'Отклонен' then
             Brush.Color := Module.RefusedColor
          else if Column.Field.AsString = 'Обслужен' then
             Brush.Color := Module.ProcessedColor
          else if Column.Field.AsString = 'Закрыт' then
            Brush.Color := Module.ClosedColor
          else if Column.Field.AsString = 'Открыт повторно' then
             Brush.Color := Module.OpenedAgainColor;  *)

         if (DataSet.Name = 'OraDataSet') and (DataSet.FieldByName('INCIDENT_TYPE').AsString = 'Проблема') then
         begin
           Brush.Color := Module.ProblemColor;
         end;

         if (DataSet.Name = 'OraDataSet') and (DataSet.FieldByName('PRIORITY').AsInteger > 1) then
         begin
           Brush.Color := Module.UrgentColor;
         end;

         Pen.Color := clBlack;
         Font.Color := clBlack;
         FillRect(Rect);


         if upper then TextOut(Rect.Left + 2, Rect.Top + 2, UpperCase(Pchar(Column.Field.Text)))
         else TextOut(Rect.Left + 2, Rect.Top + 2, Column.Field.Text);
       end
     end
   end
  except
  end;
end;

procedure TModule.TimerTimer(Sender: TObject);
begin
  MainForm.RefreshIncidents;
end;

procedure TModule.ProgressTimerTimer(Sender: TObject);
begin
  ProgressForm.OnTimer;
end;

procedure TModule.ResetFilter( form : TForm );
var i : integer;
begin
  for i := 0 to form.ComponentCount-1 do
  begin
    if form.Components[i] is TEdit then
       if strpos( PChar(TEdit(form.Components[i]).Name), PChar('ValueEdit')) <> nil then
        TEdit(form.Components[i]).Text := '';
    if form.Components[i] is TComboBox then
    begin
      TComboBox(form.Components[i]).ItemIndex := 0;
      TComboBox(form.Components[i]).Repaint;
    end;
  end;
end;

procedure TModule.PaintFilter( form : TForm );
var i : integer;
begin
 for i := 0 to form.ComponentCount-1 do
   begin
     if (form.Components[i] is TEdit) then
       TEdit(form.Components[i]).Color := Module.EvenColor
     else if (form.Components[i] is TComboBox) then
       TComboBox(form.Components[i]).Color := Module.EvenColor;
   end;
end;


procedure TModule.SendEmailNotification ( incident_num : integer );
var m : TIdMessage;
    s : string;
    strAttach : string;
begin

  try
    Smtp.Host := 'mail.sxk.ru';
    Smtp.Port := 25;
    Smtp.Connect;
  except
    Application.MessageBox('Невозможно подлючиться к почтовому серверу','Ошибка');
    Smtp.Disconnect;
    exit;
  end;

  // Определяем адрес электронной почты ответственного по инциденту
  OraQuery.SQL.Text := 'select t1.email from personnel t1, incident_card t2 where t1.id_work = t2.responsible_inc and t2.num_incident = ' + IntToStr(incident_num);
  OraQuery.Execute;

  s := OraQuery.Field(0);
  m := TIdMessage.Create( self );
  m.Recipients.EMailAddresses := OraQuery.Field(0);

  m.Sender.Address := 'helpdesk@sxk.ru';
  m.From.Address := 'helpdesk@sxk.ru';
  s := Format('%.7d',[incident_num]);

  m.Subject := 'Incident ' + s;

  // Создание аттачмента
  try
    Screen.Cursor := crHourGlass;
    strAttach := CreateWordDocument( incident_num ) ;
  except
    Application.MessageBox('Ошибка создания уведомительного документа', 'Ошибка');
    Smtp.Disconnect;
    Screen.Cursor := crDefault;
    exit;
  end;
  Screen.Cursor := crDefault;

  TIdAttachment.Create(m.MessageParts,strAttach);


  try
    Smtp.Send(m);

  except
    Application.MessageBox('Ошибка при отправке уведомления','Ошибка');
  end;

  // Удаление файла аттачмента
  DeleteFile(PChar(strAttach));
  Smtp.Disconnect;
end;

function TModule.CreateWordDocument( incident_num : integer; noclose : boolean) : string;
var  s : OleVariant;
     desc : WideString;
     dir, tmp : string;
     EmptyParam, Par1, Par2 : OleVariant;
     EmptyString : OleVariant;
     OleFalse : OleVariant;
     OleTrue : OleVariant;
     t : Table;
     doc : TWordDocument;
     word : TWordApplication;
     c : Cell;
     p : Paragraph;
     LOB : TLOBLocator;
     n : integer;
     q,q1 : TOracleQuery;
begin


  q := TOracleQuery.Create(self);
  q.Session := Module.OraSession;

  q1 := TOracleQuery.Create(self);
  q1.Session := Module.OraSession;

  dir := GetCurrentDir;
  s := dir + '\Incident ' + Format('%.7d',[incident_num]) +'.doc';

  EmptyParam := 0;
  EmptyString := '';
  OleFalse := false;
  OleTrue := true;

  doc := TWordDocument.Create(self);
  with doc do
  begin

    t := Tables.Add(Range,21,2,EmptyParam, EmptyParam);

    with t do
    begin
        with Borders.Item(wdBorderLeft) do
        begin
            LineStyle := wdLineStyleSingle;
            LineWidth := wdLineWidth025pt;
            Color := wdColorAutomatic;
        end;
        with Borders.Item(wdBorderRight) do
        begin
            LineStyle := wdLineStyleSingle;
            LineWidth := wdLineWidth025pt;
            Color := wdColorAutomatic;
        end;
        with Borders.Item(wdBorderTop) do
        begin
            LineStyle := wdLineStyleSingle;
            LineWidth := wdLineWidth025pt;
            Color := wdColorAutomatic;
        end;
        with Borders.Item(wdBorderBottom) do
        begin
            LineStyle := wdLineStyleSingle;
            LineWidth := wdLineWidth025pt;
            Color := wdColorAutomatic;
        end;
        with Borders.Item(wdBorderHorizontal) do
        begin
            LineStyle := wdLineStyleSingle;
            LineWidth := wdLineWidth025pt;
            Color := wdColorAutomatic;
        end;
        with Borders.Item(wdBorderVertical) do
        begin
            LineStyle := wdLineStyleSingle;
            LineWidth := wdLineWidth025pt;
            Color := wdColorAutomatic;
        end;
        Borders.Item(wdBorderDiagonalDown).LineStyle := wdLineStyleNone;
        Borders.Item(wdBorderDiagonalUp).LineStyle := wdLineStyleNone;
        Borders.Shadow := False;
    end;

    t.Columns.Item(1).PreferredWidthType := wdPreferredWidthPoints;
    t.Columns.Item(1).PreferredWidth := 150;



    t.Cell(1,1).Range.Shading.BackgroundPatternColor := wdColorGray25;
    t.Cell(1,1).Range.Font.Size := 16;
    t.Cell(1,1).Range.Font.Bold := 1;
    t.Cell(1,1).Range.Text := 'Номер инцидента';

    // Разбиваем ячейку (1,2) на три
    Par1 := 1;
    Par2 := 3;
    t.Cell(1,2).Split(Par1,Par2);

    with t.Cell(1,2).Range do
    begin
      Shading.BackgroundPatternColor := wdColorGray25;
      Font.Size := 16;
      Font.Bold := 1;
      Text := Format('%.7d',[incident_num]);
      t.Cell(1,2).Width := 70;
    end;

    with t.Cell(1,3).Range do
    begin
      ParagraphFormat.Alignment := wdAlignParagraphRight;
      Shading.BackgroundPatternColor := wdColorGray25;
      Font.Size := 16;
      Font.Bold := 1;
      Text := 'Статус*';
      t.Cell(1,3).Width := 80;
    end;

    with t.Cell(1,4).Range do
    begin
      Shading.BackgroundPatternColor := wdColorGray25;
      Font.Size := 16;
      Font.Bold := 1;

      // Сhange here!
      Module.OraQuery.SQL.Text := 'select t3.name_state from ' +
  	   'incident_state t3,' +
  	   'incident_move_card t4,' +
	     '(select t1.num_incident, max(t1.date_move) max_date from incident_move_card t1 group by t1.num_incident) t2 ' +
        'where ' +
    	  't3.num_state = t4.num_state and ' +
    	  't4.date_move = t2.max_date and ' +
    	  't2.num_incident = ' + IntToStr(incident_num);
      Module.OraQuery.Execute;
      Text := Module.OraQuery.Field(0);
      t.Cell(1,4).Width := 170;
    end;

    n := 2;

    with t.Cell(n,1).Range do
    begin
      ParagraphFormat.Alignment := wdAlignParagraphRight;
      Shading.BackgroundPatternColor := wdColorGray25;
      Font.Size := 12;
      Font.Bold := 1;
      Text := 'Этап 1';
      t.Cell(n,1).Width := 150;
    end;

    with t.Cell(n,2).Range do
    begin
      Shading.BackgroundPatternColor := wdColorGray25;
      Font.Size := 12;
      Font.Bold := 1;
      Text := 'Создание инцидента (заполняет владелец инцидента)';
      t.Cell(n,2).Width := 320;
    end;

    // Запрос необходимых данных
    q1.SQL.Text := 'select t.date_create, t.worker, t.name_device, ' +
    ' t.name_scale, t.date_resolution, t.owner_inc, t.priority, s.name_source, '+
    ' t.name_type, t.name_class, t.incident_type ' +
    ' FROM common_view t, incident_card i, incident_source s WHERE i.num_incident = t.num_incident ' +
    ' AND s.num_source (+)= i.num_source AND t.num_incident = ' + IntToStr(incident_num);
    q1.Execute;


    Inc(n);

    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := 'Дата и время создания';
    end;

    with t.Cell(n,2).Range do
    begin
       Font.Size := 12;
       Text := q1.Field(0);
        t.Cell(n,2).Width := 320;
    end;

    ////

    Inc(n);

    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := 'ФИО инициатора';
    end;

    with t.Cell(n,2).Range do
    begin
      Font.Size := 12;
      Text := q1.Field(1);
      t.Cell(n,2).Width := 320;
    end;

    Inc(n);

    //
    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := '№ телефона';
    end;

    try
      q.SQL.Text := 'select t1.phone, t1.address from personnel t1, incident_card t2 where  t2.id_work = t1.id_work and t2.num_incident = '+ IntToStr(incident_num);
      q.Execute;

      with t.Cell(n,2).Range do
      begin
        Font.Size := 12;
        Text := q.Field(0);
        t.Cell(n,2).Width := 320;
      end;
    finally
    end;

    Inc(n);

    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := 'Адрес (здание/комната)';
    end;


    with t.Cell(n,2).Range do
    begin
      Font.Size := 12;
      Text := q.Field(1);
      t.Cell(n,2).Width := 320;
    end;
    //

    Inc(n);

    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := 'Элемент инфраструктуры';
    end;

    with t.Cell(n,2).Range do
    begin
      Font.Size := 12;
      Text := q1.Field(2);
      t.Cell(n,2).Width := 320;
    end;


    Inc(n);
    // Описание
    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := 'Описание';
    end;

    try

      q.SQL.Text :=
      'SELECT ' +
        't1.date_move, p.worker, t1.description, p.phone, p.email ' +
      'FROM ' +
        'incident_move_card t1, ' +
        'personnel p, ' +
        '(SELECT t1.num_incident, min(t1.date_move) min_date FROM incident_move_card t1 group by t1.num_incident) t2 ' +
      'WHERE ' +
        'p.id_work = t1.creator_move and ' +
        't1.date_move = t2.min_date and ' +
        't1.num_incident = t2.num_incident and ' +
        't1.num_incident = ' + IntToStr(incident_num) + ' ' +
       'ORDER BY t1.date_move desc';

     q.Execute;

      with t.Cell(n,2).Range do
      begin
        Font.Size := 10;
        t.Cell(n,2).Width := 320;
        c := t.Cell(n,2);
        while not q.Eof do
        begin

          desc:= WideString(q.Field(2));
          if desc = '' then desc := 'Нет описания';
          desc := desc +  #13#10#13#10;

          par1 := c.Range;
          p := c.Range.Paragraphs.Add( par1 );
          p.Range.Font.Bold := 0;
          p.Range.Text := desc;


          par1 := c.Range;
          p := c.Range.Paragraphs.Add( par1 );
          p.Range.Font.Bold := 1;
          p.Range.Text := WideString(q.Field(0)) + ' - ' + WideString(q.Field(1)) +
            ' (тел. ' + WideString(q.Field(3)) +', ' + 'email: ' + WideString(q.Field(4))+ ')' + #13#10#13#10;
            q.Next;
        end
      end;

    // Масштаб
    Inc(n);
    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := 'Масштаб';
    end;
    with t.Cell(n,2).Range do
    begin
      Font.Size := 12;
      Text := q1.Field(3);
      t.Cell(n,2).Width := 320;
    end;


    // Приоритет
    Inc(n);
    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := 'Приоритет';
    end;
    with t.Cell(n,2).Range do
    begin
      Font.Size := 12;
      Text := q1.Field(6);
      t.Cell(n,2).Width := 320;
    end;

    // Источник
    Inc(n);
    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := 'Источник инцидента';
    end;
    with t.Cell(n,2).Range do
    begin
      Font.Size := 12;
      tmp := q1.Field(7);
      if (tmp='') then tmp := 'Не определен';
      Text := tmp;
      t.Cell(n,2).Width := 320;
    end;

   // Группа ИТ-услуг
   Inc(n);
   with t.Cell(n,1).Range do
   begin
     Font.Size := 12;
     Text := 'Группа ИТ услуг';
   end;
   with t.Cell(n,2).Range do
   begin
      Font.Size := 12;
      Text := q1.Field(8);
      t.Cell(n,2).Width := 320;
   end;



   Inc(n);
   with t.Cell(n,1).Range do
   begin
     Font.Size := 12;
     Text := 'ИТ-услуга';
   end;
   with t.Cell(n,2).Range do
   begin
      Font.Size := 12;
      Text := q1.Field(9);
      t.Cell(n,2).Width := 320;
   end;

    // Тип инцидента
   Inc(n);
   with t.Cell(n,1).Range do
   begin
     Font.Size := 12;
     Text := 'Тип';
   end;
   with t.Cell(n,2).Range do
   begin
      Font.Size := 12;
      Text := q1.Field(10);
      t.Cell(n,2).Width := 320;
   end;

    Inc(n);
    // Снимки экрана
    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := 'Копия экрана( если возможно )';
      t.Cell(n,1).Height := 450;
    end;

     Module.OraQuery.SQL.Text :=
    'SELECT ' +
      'i.date_move, p.worker, i.description, a.screen ' +
    'FROM ' +
      'incident_move_card i, ' +
      'personnel_view p, ' +
      'addition a, ' +
      '(select m.num_incident, min(m.date_move) min_date FROM incident_move_card m GROUP BY m.num_incident) t2 ' +
    'WHERE ' +
      'a.num_move = i.num_move and ' +
      'p.id_work = i.creator_move and ' +
      'i.date_move = t2.min_date and ' +
      'i.num_incident = t2.num_incident and ' +
      'i.num_incident = ' + IntToStr(incident_num) + ' ' +
     'ORDER BY i.date_move, a.date_ins';

    Module.OraQuery.Execute;


    t.Cell(n,2).Width := 320;

    c := t.Cell(n,2);
    c.Range.Font.Size := 10;

    while not Module.OraQuery.Eof do
    begin

     // Читаем картинку из базы и сохраняем во временный файл
      LOB := Module.OraQuery.LOBField('screen');
      if not LOB.IsNull then
      begin

        LOB.SaveToFile(GetCurrentDir + '\tmp');

         //c.Range.InlineShapes.AddPicture(
         // GetCurrentDir + '\tmp', OleFalse, OleTrue, par1 );

         par1 := c.Range;
         p := c.Range.Paragraphs.Add( par1 );
         p.Range.Font.Bold := 0;
         p.Range.InlineShapes.AddPicture(
          GetCurrentDir + '\tmp', OleFalse, OleTrue, par1 );


         par1 := c.Range;
         p := c.Range.Paragraphs.Add( par1 );
         p.Range.Font.Bold := 1;
         p.Range.Text := WideString(Module.OraQuery.Field(0)) + ' - ' + WideString(Module.OraQuery.Field(1)) +#13#10#13#10;


        // Удаляем временный файл
        DeleteFile( PChar(GetCurrentDir + '\tmp'));
      end;
      Module.OraQuery.Next;
    end;
    finally
    end;


    Inc(n);
    // Время устранения
    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := 'Предполагаемое время устранения';
    end;
    with t.Cell(n,2).Range do
    begin
      Font.Size := 12;
      Text := q1.Field(4);
      t.Cell(n,2).Width := 320;
    end;


     Inc(n);
    // Владелец инцидента
    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := 'Владелец инцидента';
    end;
    with t.Cell(n,2).Range do
    begin
      Font.Size := 12;
      Text := q1.Field(5);
      t.Cell(n,2).Width := 320;
    end;


    Inc(n);
    with t.Cell(n,1).Range do
    begin
      ParagraphFormat.Alignment := wdAlignParagraphRight;
      Shading.BackgroundPatternColor := wdColorGray25;
      Font.Size := 12;
      Font.Bold := 1;
      Text := 'Этап 3';
    end;

    with t.Cell(n,2).Range do
    begin
      Shading.BackgroundPatternColor := wdColorGray25;
      Font.Size := 12;
      Font.Bold := 1;
      Text := 'Закрытие инцидента (заполняет владелец инцидента)';
      t.Cell(n,2).Width := 320;
    end;

    Inc(n);
    with t.Cell(n,1).Range do
    begin
      Font.Size := 11;
      Text := 'Пометка о закрытии и действиях по информированию инициатора инцидента';
    end;
    t.Cell(n,2).Width := 320;


    Inc(n);
    with t.Cell(n,1).Range do
    begin
      Font.Size := 13;
      Text := 'Время закрытия';
    end;
    t.Cell(n,2).Width := 320;



    Inc(n);
    with t.Cell(n,1).Range do
    begin
      ParagraphFormat.Alignment := wdAlignParagraphRight;
      Shading.BackgroundPatternColor := wdColorGray25;
      Font.Size := 12;
      Font.Bold := 1;
      Text := 'Этап 2';
    end;

    with t.Cell(n,2).Range do
    begin
      Shading.BackgroundPatternColor := wdColorGray25;
      Font.Size := 12;
      Font.Bold := 1;
      Text := 'Устранение инцидента (заполняет специалист поддержки, устраняющий инцидент)';
      t.Cell(n,2).Width := 320;
    end;

    Inc(n);
    with t.Cell(n,1).Range do
    begin
      Font.Size := 11;
      Text := 'Описание произведенных действий и их результаты. Изменения характеристик инцидента.';
    end;


    t.Cell(n,2).Width := 320;
    try


      Module.OraQuery.SQL.Text :=
      'select ' +
        't1.date_move, t2.worker, t1.description, t2.phone, t2.email ' +
      'from ' +
        'incident_move_card t1, ' +
        'personnel t2, ' +
        '(select t1.num_incident, min(t1.date_move) min_date from incident_move_card t1 group by t1.num_incident) t2 ' +
      'where ' +
        't2.id_work = t1.creator_move and ' +
        't1.date_move <> t2.min_date and ' +
        't1.num_incident = t2.num_incident and ' +
        't1.num_incident = ' + IntToStr(incident_num) + ' ' +
      'order by t1.date_move desc';

      Module.OraQuery.Execute;


      c := t.Cell(n,2);
      par1 :=  c.Range;
      par1.Font.Size := 10;
      with c.Range do
      begin

        Font.Size := 10;
        while not Module.OraQuery.Eof do
        begin
          desc:= WideString(Module.OraQuery.Field(2));
          if desc = '' then desc := 'Нет описания';
          desc := desc +   #13#10#13#10;

          par1 := c.Range;
          p := c.Range.Paragraphs.Add( par1 );
          p.Range.Font.Bold := 0;
          p.Range.Text := desc;


          par1 := c.Range;
          p := c.Range.Paragraphs.Add( par1 );
          p.Range.Font.Bold := 1;
          p.Range.Text := WideString(Module.OraQuery.Field(0)) + ' - ' + WideString(Module.OraQuery.Field(1)) +
            ' (тел. ' + WideString(Module.OraQuery.Field(3)) +', ' + 'email: ' + WideString(Module.OraQuery.Field(4))+ ')' + #13#10#13#10;;

          Module.OraQuery.Next;
        end;
      end;
    finally
    end;


    Inc(n);
    with t.Cell(n,1).Range do
    begin
      Font.Size := 12;
      Text := 'Копия экрана (если необходимо)';
      t.Cell(n,1).Height := 450;
    end;

    // -- Here!
    try

     Module.OraQuery.SQL.Text :=
      'select ' +
        'i.date_move, p.worker, i.description, a.screen ' +
      'from ' +
        'incident_move_card i, ' +
        'personnel p, ' +
        'addition a, ' +
        '(select m.num_incident, min(m.date_move) min_date from incident_move_card m group by m.num_incident) d ' +
      'where ' +
        'a.num_move = i.num_move and ' +
        'p.id_work = i.creator_move and ' +
        'i.date_move <> d.min_date and ' +
        'i.num_incident = d.num_incident and ' +
        'i.num_incident = ' + IntToStr(incident_num) + ' ' +
       'order by a.date_ins desc';

      Module.OraQuery.Execute;


      t.Cell(n,2).Width := 320;

      c := t.Cell(n,2);
      c.Range.Font.Size := 10;

      while not Module.OraQuery.Eof do
      begin

       // Читаем картинку из базы и сохраняем во временный файл
        LOB := Module.OraQuery.LOBField('screen');
        if not LOB.IsNull then
        begin

          LOB.SaveToFile(GetCurrentDir + '\tmp');

           //c.Range.InlineShapes.AddPicture(
           // GetCurrentDir + '\tmp', OleFalse, OleTrue, par1 );

           par1 := c.Range;
           p := c.Range.Paragraphs.Add( par1 );
           p.Range.Font.Bold := 0;
           p.Range.InlineShapes.AddPicture(
            GetCurrentDir + '\tmp', OleFalse, OleTrue, par1 );


           par1 := c.Range;
           p := c.Range.Paragraphs.Add( par1 );
           p.Range.Font.Bold := 1;
           p.Range.Text := WideString(Module.OraQuery.Field(0)) + ' - ' + WideString(Module.OraQuery.Field(1)) +#13#10#13#10;


          // Удаляем временный файл
          DeleteFile( PChar(GetCurrentDir + '\tmp'));
        end;
        Module.OraQuery.Next;
      end;
    finally
    end;




    Inc(n);
    t.Cell(n,1).Range.Text := 'Время заполнения';
    t.Cell(n,2).Width := 320;

    Inc(n);
    t.Cell(n,1).Range.Text := 'Специалист поддержки, устраняющий инцидент';
    t.Cell(n,2).Width := 320;

    with Content.Paragraphs.Last.Range do
    begin

       InsertParagraphAfter;
       Font.Size := 10;
       InsertAfter('* Статус инцидента может принимать значения:');
       InsertParagraphAfter;
       InsertAfter('Создан, Назначен, Обслужен, Отклонен, Закрыт, Открыт повторно');
       InsertParagraphAfter;
       InsertParagraphAfter;
       InsertAfter('Пустая таблица 2-ого этапа должна предоставляться владельцем инцидента для каждого специалиста поддержки, устраняющего инцидент (копирование таблицы по 2 этапу в конец файла для каждой итерации).');

    end;





    if noclose then
    begin
      word := TWordApplication.Create(self);
      word.Visible := true;
    end
    else
    begin
      SaveAs(s, EmptyParam);
      Close;
    end


  end;

  q.Free;
  q1.Free;
  Result := s;
end;


procedure TModule.UpdateColumnTitle( bar : TStatusBar; grid : TDBGrid );
begin
  bar.Panels[1].Text := 'Текущий столбец : ' + grid.Columns[grid.SelectedIndex].Title.Caption;
end;


procedure TModule.FastFilter( key : char; form : TForm;  ds : TOracleDataSet;
   grid : TDBGrid; var ff : boolean);
begin

  FastFilterForm.SetFilter( key, form, ds, grid, ff );
  FastFilterForm.ShowModal;
  ff := FastFilterForm.Filtered;
end;

function TModule.CheckActualVersion : boolean;
var v : real;
begin
 Module.OraQuery.SQL.Text := 'select t.actual_version from version t';
 Module.OraQuery.Execute;

 v := StrToFloat(Module.OraQuery.Field(0));
 if (v > FVersion) then
 begin
  Application.MessageBox(PChar('У вас установлена неактуальная версия приложения ' + FloatToStr(FVersion) + #13#10 +
    'Актуальная версия ' + FloatToStr(v) + #13#10 + 'Для работы необходимо установить актуальную версию') , 'Неактуальная версия');
  Result := false;
 end
 else
  Result := true;
end;



procedure TModule.MoveDataSetAfterScroll(DataSet: TDataSet);
begin
  IncidentMoveForm.OnMovementsGridScroll;
end;

function TModule.frxDesignerSaveReport(Report: TfrxReport;
  SaveAs: Boolean): Boolean;

begin
  ReportForm.SaveReport( Report );
  Result := true;
end;
end.

