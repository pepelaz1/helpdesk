unit main_filter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, global, settings, ComCtrls, IniFiles ,StrUtils, DateUtils;


type

  TMainField = record
    strField : String;
    strName : String;
  end;

  TMainFields = class
    protected
      Fields : array [1..COLUMNS_COUNT] of TMainField;
      m_nCount : integer;
    public
      constructor Create;
      procedure Add( name, field : String);
      function GetFieldAt( i : integer) : String;
      function GetFieldNameAt( i : integer) : String;
  end;


  TMainFormFilter = class(TForm)
    FilterButton: TButton;
    CancelButton: TButton;
    ResetButton: TButton;
    SaveButton: TButton;
    FilterLabel: TLabel;
    FilterCombo: TComboBox;
    SaveAsButton: TButton;
    DeleteButton: TButton;
    FilterPageControl: TPageControl;
    FilterTabSheet: TTabSheet;
    CustomTabSheet: TTabSheet;
    IncidentTitleNumEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    StatusTitleEdit: TEdit;
    InitiatorTitleEdit: TEdit;
    OwnerTitleEdit: TEdit;
    ResponsibleTitleEdit: TEdit;
    InfrastructureTitleEdit: TEdit;
    CreationDateTitleEdit: TEdit;
    FixDateTitleEdit: TEdit;
    ClassTitleEdit: TEdit;
    TypeEdit: TEdit;
    ScaleTitleEdit: TEdit;
    PriorityTitleEdit: TEdit;
    IncidentNumComboBox: TComboBox;
    IncidentNumValueEdit: TEdit;
    StatusComboBox: TComboBox;
    StatusValueComboBox: TComboBox;
    InitiatorComboBox: TComboBox;
    InitiatorValueEdit: TEdit;
    OwnerComboBox: TComboBox;
    OwnerValueEdit: TEdit;
    ResponsibleComboBox: TComboBox;
    ResponsibleValueEdit: TEdit;
    InfrastructureComboBox: TComboBox;
    InfrastructureValueEdit: TEdit;
    CreationDateComboBox: TComboBox;
    CreationDateValueEdit: TEdit;
    CreationDateButton: TButton;
    FixDateComboBox: TComboBox;
    FixDateValueEdit: TEdit;
    FixDateButton: TButton;
    ClassComboBox: TComboBox;
    ClassValueEdit: TEdit;
    TypeComboBox: TComboBox;
    TypeValueEdit: TEdit;
    ScaleComboBox: TComboBox;
    ScaleValueComboBox: TComboBox;
    PriorityComboBox: TComboBox;
    PriorityValueEdit: TEdit;
    WhereMemo: TMemo;
    AvailMemo: TMemo;
    AvailFieldsLabel: TLabel;
    TypeTitleEdit: TEdit;
    IncTypeComboBox: TComboBox;
    IncTypeValueComboBox: TComboBox;
    procedure IncidentNumComboBoxExit(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FilterButtonClick(Sender: TObject);
    procedure StatusComboBoxExit(Sender: TObject);
    procedure InitiatorComboBoxExit(Sender: TObject);
    procedure CreationDateButtonClick(Sender: TObject);
    procedure FixDateButtonClick(Sender: TObject);
    procedure CreationDateValueEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FixDateValueEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ScaleValueComboBoxExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure OwnerComboBoxExit(Sender: TObject);
    procedure ResponsibleComboBoxExit(Sender: TObject);
    procedure InfrastructureComboBoxExit(Sender: TObject);
    procedure CreationDateComboBoxExit(Sender: TObject);
    procedure FixDateComboBoxExit(Sender: TObject);
    procedure ClassComboBoxExit(Sender: TObject);
    procedure ScaleComboBoxExit(Sender: TObject);
    procedure PriorityComboBoxExit(Sender: TObject);
    procedure TypeComboBoxExit(Sender: TObject);
    procedure FilterComboChange(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure SaveAsButtonClick(Sender: TObject);
    procedure FilterComboExit(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure FilterPageControlChange(Sender: TObject);
    procedure WhereMemoChange(Sender: TObject);
    procedure IncTypeValueComboBoxExit(Sender: TObject);
  private
     m_bFiltered : boolean;

     FFields : TMainFields;

      // Чтение значений контролей из GSettings
     procedure LoadControls;

     // Сохранение значение контролей в GSettings
     procedure SaveControls;

     // Создание карты соответствий названий полей с их реальным именем
     procedure CreateFieldsMap;

     // Добавление заказного фильтра
     function AppendCustomFilter( strQuery, strMemo : string ) : string;

     // Проверяет - не выбран ли заказной фильтр и выполняет соответствующие действия
     procedure CheckCustomFilter;

     // Делает достыпными/недоступными элементы фильтра, которые не относятся к заказной части
     procedure EnableNonCustomControls( bEnable : boolean);

     // Пишем на форму доступные для заказного запроса поля
     procedure WriteAvailFields;

     // Удаление ненужных переходов строки во WhereMemo;
     procedure NormalizeWhereMemo;


  public

     // Применение фильтра
     procedure Apply;

     property  Filtered : boolean read m_bFiltered write m_bFiltered;
  end;

var
  MainFormFilter: TMainFormFilter;

implementation

uses main, date_selection, save_main_filter;

{$R *.dfm}

procedure TMainFormFilter.IncidentNumComboBoxExit(Sender: TObject);
begin
  IncidentNumComboBox.Repaint;
end;

procedure TMainFormFilter.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMainFormFilter.FilterButtonClick(Sender: TObject);
begin
  Apply;
  SaveControls;
  Close;
end;



constructor TMainFields.Create;
begin
  m_nCount := 0;
end;

procedure TMainFields.Add( name, field : String);
begin
  Inc(m_nCount);
  Fields[m_nCount].strName := name;
  Fields[m_nCount].strField := field;
end;



function TMainFields.GetFieldAt( i : integer) : String;
begin
  Result := Fields[i].strField;
end;

function TMainFields.GetFieldNameAt( i : integer) : String;
begin
  Result := Fields[i].strName;
end;

procedure TMainFormFilter.CreateFieldsMap;
begin
  FFields := TMainFields.Create;
  FFields.Add('[№]','t2.num_incident');
  FFields.Add('[Статус]','t1.name_state');
  FFields.Add('[Тип]','t2.incident_type');
  FFields.Add('[Инициатор]','t2.worker');
  FFields.Add('[Владелец]','t2.owner_inc');
  FFields.Add('[Ответственный]','t2.responsible_inc');
  FFields.Add('[Элемент инфраструктуры]','t2.name_device');
  FFields.Add('[Дата и время создания]','t2.date_create');
  FFields.Add('[Дата и время устранения]','t2.date_resolution');
  FFields.Add('[Класс инцидента]','t2.name_class');
  FFields.Add('[Тип класса инцидента]','t2.name_type');
  FFields.Add('[Масштаб инцидента]','t2.name_scale');
  FFields.Add('[Приоритет]','t2.priority');
end;

procedure TMainFormFilter.WriteAvailFields;
var i : integer;
begin
  AvailMemo.Text := '';
  for i := 1 to 11 do
    AvailMemo.Text := AvailMemo.Text + FFields.GetFieldNameAt(i) + ', ';
  AvailMemo.Text := AvailMemo.Text + FFields.GetFieldNameAt(12);
end;

function TMainFormFilter.AppendCustomFilter( strQuery, strMemo : string ) : string;
var i : integer;
    s,s1 : string;
begin
  if (strMemo = '') then
  begin
    Result := strQuery;
    exit;
  end;

  for i := 1 to COLUMNS_COUNT do
  begin
    s := FFields.GetFieldAt(i);
    s1 := FFields.GetFieldNameAt(i);
    strMemo := StringReplace(strMemo,   s1,s, [rfReplaceAll, rfIgnoreCase]);
  end;

  Result := strQuery + ' and ( ' + strMemo + ' )';
end;



procedure TMainFormFilter.EnableNonCustomControls( bEnable : boolean);
var i : integer;
begin
  for i := 0 to FilterTabSheet.ControlCount-1 do
  begin
    FilterTabSheet.Controls[i].Enabled := bEnable;
  end;
  ResetButton.Enabled := bEnable;
  SaveButton.Enabled := bEnable;
  SaveAsButton.Enabled := bEnable;
  DeleteButton.Enabled := bEnable;
  FilterButton.Enabled := bEnable;
  CancelButton.Enabled := bEnable;
end;

procedure TMainFormFilter.FilterPageControlChange(Sender: TObject);
begin
  if (GSettings.Custom <> '') then
  begin
    if (FilterPageControl.ActivePage = CustomTabSheet)  then
      EnableNonCustomControls(true)
    else
      EnableNonCustomControls(false);
  end
  else
    EnableNonCustomControls(true);
end;

procedure TMainFormFilter.CheckCustomFilter;
begin
 if (GSettings.Custom <> '') then
 begin
    FilterPageControl.ActivePage := CustomTabSheet;
 end
 else
 begin
   FilterPageControl.ActivePage := FilterTabSheet;
 end;
end;

procedure TMainFormFilter.WhereMemoChange(Sender: TObject);
begin
 if (WhereMemo.Text = '') then SaveControls;
end;

procedure TMainFormFilter.NormalizeWhereMemo;
var s: string;
begin
  s := Chr(13)+Chr(10);
  WhereMemo.Text := StringReplace(WhereMemo.Text,s,'',[rfReplaceAll]);
end;

procedure TMainFormFilter.Apply;
var strNewQuery,strOldQuery : string;
begin
   SaveControls;
   try

    strNewQuery :=
      'select  lpad(to_char(t2.num_incident),7,''0'') incident_str,  t1.name_state, t2.* ' +
      'from incident_state t1, common_view t2, incident_move_card t3,' +
      '    (select t.num_incident, max(t.date_move) max_date from incident_move_card t group by t.num_incident) t4 '+
      'where'+
      '   t2.num_incident = t3.num_incident and' +
      '   t3.num_incident = t4.num_incident and' +
      '   t3.date_move = t4.max_date and' +
      '   t1.num_state = t3.num_state';

     strOldQuery := strNewQuery + ' order by t2.id_incident desc';

     // Определяем активную вкладку фильтра
     if FilterPageControl.ActivePage = FilterTabSheet then
     begin

        // Номер инцидента
        if IncidentNumValueEdit.Text <> '' then
            strNewQuery := strNewQuery + ' and t2.num_incident ' + IncidentNumComboBox.Text  + IncidentNumValueEdit.Text;

        // Статус инцидента
        if StatusValueComboBox.Text <> '' then
            strNewQuery := strNewQuery + ' and t1.name_state ' + StatusComboBox.Text  + QuotedStr(StatusValueComboBox.Text);

        // Тип инцидента
        if IncTypeValueComboBox.Text <> '' then
            strNewQuery := strNewQuery + ' and t2.incident_type ' + IncTypeComboBox.Text  + QuotedStr(IncTypeValueComboBox.Text);

        // Инициатор
        if InitiatorValueEdit.Text <> '' then
        begin
          if InitiatorComboBox.Text = '=' then
            strNewQuery := strNewQuery + ' and t2.worker ' + InitiatorComboBox.Text  + QuotedStr(InitiatorValueEdit.Text)
          else if InitiatorComboBox.Text = 'включает' then
            strNewQuery := strNewQuery + ' and instr(lower(t2.worker),lower(' + QuotedStr(InitiatorValueEdit.Text) + ')) <> 0';
        end;

        // Владелец
        if OwnerValueEdit.Text <> '' then
        begin
          if OwnerComboBox.Text = '=' then
            strNewQuery := strNewQuery + ' and t2.owner_inc ' + OwnerComboBox.Text  + QuotedStr(OwnerValueEdit.Text)
          else if OwnerComboBox.Text = 'включает' then
            strNewQuery := strNewQuery + ' and instr(lower(t2.owner_inc),lower(' + QuotedStr(OwnerValueEdit.Text) + ')) <> 0';
        end;

        // Ответственный
        if ResponsibleValueEdit.Text <> '' then
        begin
          if ResponsibleComboBox.Text = '=' then
            strNewQuery := strNewQuery + ' and t2.responsible_inc ' + ResponsibleComboBox.Text  + QuotedStr(ResponsibleValueEdit.Text)
          else if ResponsibleComboBox.Text = 'включает' then
            strNewQuery := strNewQuery + ' and instr(lower(t2.responsible_inc),lower(' + QuotedStr(ResponsibleValueEdit.Text) + ')) <> 0';
        end;

        // Элемент инфраструктуры
        if InfrastructureValueEdit.Text <> '' then
        begin
          if InfrastructureComboBox.Text = '=' then
            strNewQuery := strNewQuery + ' and t2.name_device ' + InfrastructureComboBox.Text  + QuotedStr(InfrastructureValueEdit.Text)
          else if InfrastructureComboBox.Text = 'включает' then
            strNewQuery := strNewQuery + ' and instr(lower(t2.name_device),lower(' + QuotedStr(InfrastructureValueEdit.Text) + ')) <> 0';
        end;

        // Дата и время создания
        if CreationDateValueEdit.Text <> '' then
            strNewQuery := strNewQuery + ' and t2.date_create ' + CreationDateComboBox.Text  + 'to_date(' + QuotedStr(CreationDateValueEdit.Text) +',''DD.MM.YYYY HH24:MI:SS'')';

        // Дата и время устранения
        if FixDateValueEdit.Text <> '' then
          strNewQuery := strNewQuery + ' and t2.date_resolution ' + FixDateComboBox.Text  + 'to_date(' + QuotedStr(FixDateValueEdit.Text) +',''DD.MM.YYYY HH24:MI:SS'')';


        // Класс инциндента
        if ClassValueEdit.Text <> '' then
        begin
          if ClassComboBox.Text = '=' then
            strNewQuery := strNewQuery + ' and t2.name_class ' + ClassComboBox.Text  + QuotedStr(ClassValueEdit.Text)
          else if ClassComboBox.Text = 'включает' then
            strNewQuery := strNewQuery + ' and instr(lower(t2.name_class),lower(' + QuotedStr(ClassValueEdit.Text) + ')) <> 0';
        end;

        // Тип класса инцидента
        if TypeValueEdit.Text <> '' then
        begin
          if TypeComboBox.Text = '=' then
            strNewQuery := strNewQuery + ' and t2.name_class ' + TypeComboBox.Text  + QuotedStr(TypeValueEdit.Text)
          else if TypeComboBox.Text = 'включает' then
            strNewQuery := strNewQuery + ' and instr(lower(t2.name_type),lower(' + QuotedStr(TypeValueEdit.Text) + ')) <> 0';
        end;


        // Масштаб инцидента
        if ScaleValueComboBox.Text <> '' then
            strNewQuery := strNewQuery + ' and t2.name_scale ' + ScaleComboBox.Text  + QuotedStr(ScaleValueComboBox.Text);

        // Приоритет инцидента
        if PriorityValueEdit.Text <> '' then
            strNewQuery := strNewQuery + ' and t2.priority ' + PriorityComboBox.Text  + PriorityValueEdit.Text;

     end
     else if FilterPageControl.ActivePage = CustomTabSheet then
     begin
       NormalizeWhereMemo;
       strNewQuery := AppendCustomFilter(strNewQuery, WhereMemo.Text);
     end;

//    strNewQuery := strNewQuery + ' and  t2.date_create


    strNewQuery := strNewQuery + ' order by t2.id_incident desc';
    Filtered := strNewQuery <> strOldQuery;

    GSettings.MainFiltersCurrent := FilterCombo.ItemIndex;

    Module.OraDataSet.SQL.Text :=  strNewQuery;
    Module.OraDataSet.Filtered := false;
    
//    try
//     Module.OraDataSet.Refresh;
//    except
//      Application.MessageBox('Неправильно построенный фильтр','Ошибка',MB_ICONERROR);
//    end;

  finally
  end;
end;

procedure TMainFormFilter.StatusComboBoxExit(Sender: TObject);
begin
  StatusComboBox.Repaint;
end;

procedure TMainFormFilter.InitiatorComboBoxExit(Sender: TObject);
begin
  InitiatorComboBox.Repaint;
end;

procedure TMainFormFilter.CreationDateButtonClick(Sender: TObject);
var s : string;
begin
  Module.OraQuery.SQL.Text := 'select to_char(sysdate, ''DD.MM.YYYY HH24:MI:SS'') from dual';
  Module.OraQuery.Execute;

  s := Module.OraQuery.Field(0);
  CalendarForm.Hours := StrToInt(Copy(s,12,2));
  CalendarForm.Minutes := StrToInt(Copy(s,15,2));
  CalendarForm.Seconds := StrToInt(Copy(s,18,2));

  CalendarForm.ShowModal;
  if CalendarForm.IsSet then
  begin
    CreationDateValueEdit.Text  := Format('%0.2d.%0.2d.%0.2d %s',[CalendarForm.CalendarControl.Day,
      CalendarForm.CalendarControl.Month,CalendarForm.CalendarControl.Year, CalendarForm.TimeEdit.Text  ]);
  end;
end;

procedure TMainFormFilter.FixDateButtonClick(Sender: TObject);
var s : string;
begin
  Module.OraQuery.SQL.Text := 'select to_char(sysdate, ''DD.MM.YYYY HH24:MI:SS'') from dual';
  Module.OraQuery.Execute;

  s := Module.OraQuery.Field(0);
  CalendarForm.Hours := StrToInt(Copy(s,12,2));
  CalendarForm.Minutes := StrToInt(Copy(s,15,2));
  CalendarForm.Seconds := StrToInt(Copy(s,18,2));
  CalendarForm.ShowModal;

  if CalendarForm.IsSet then
  begin
    FixDateValueEdit.Text  := Format('%0.2d.%0.2d.%0.2d %s',[CalendarForm.CalendarControl.Day,
      CalendarForm.CalendarControl.Month,CalendarForm.CalendarControl.Year, CalendarForm.TimeEdit.Text  ]);
  end;
end;

procedure TMainFormFilter.CreationDateValueEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 46) or (Key = 8) then
   CreationDateValueEdit.Text := '';
end;

procedure TMainFormFilter.FixDateValueEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 46) or (Key = 8) then
   FixDateValueEdit.Text := '';
end;

procedure TMainFormFilter.ScaleValueComboBoxExit(Sender: TObject);
begin
  ScaleValueComboBox.Repaint;
end;

procedure TMainFormFilter.FormShow(Sender: TObject);
begin
   Module.PaintFilter( self );
   if FilterCombo.Text <> '' then GSettings.LoadMain( FilterCombo.Text );
   LoadControls;

   CheckCustomFilter;
   WriteAvailFields;
end;

procedure TMainFormFilter.LoadControls;
begin
  IncidentNumValueEdit.Text := GSettings.NumIncident;
  IncidentNumComboBox.ItemIndex := GSettings.NumIncidentOp;
  StatusValueComboBox.ItemIndex := GSettings.Status;
  StatusComboBox.ItemIndex := GSettings.StatusOp;
  InitiatorValueEdit.Text := GSettings.Initiator;
  InitiatorComboBox.ItemIndex := GSettings.InitiatorOp;
  OwnerValueEdit.Text := GSettings.Owner;
  OwnerComboBox.ItemIndex := GSettings.OwnerOp;
  ResponsibleValueEdit.Text := GSettings.Responsible;
  ResponsibleComboBox.ItemIndex := GSettings.ResponsibleOp;
  InfrastructureValueEdit.Text := GSettings.Element;
  InfrastructureComboBox.ItemIndex := GSettings.ElementOp;
  CreationDateValueEdit.Text := GSettings.CreationDate;
  CreationDateComboBox.ItemIndex := GSettings.CreationDateOp;
  FixDateValueEdit.Text := GSettings.FixDate;
  FixDateComboBox.ItemIndex := GSettings.FixDateOp;
  ClassValueEdit.Text := GSettings.ClassIncident;
  ClassComboBox.ItemIndex := GSettings.ClassIncidentOp;
  TypeValueEdit.Text := GSettings.TypeClass0;
  TypeComboBox.ItemIndex := GSettings.TypeClass0Op;
  ScaleValueComboBox.ItemIndex := GSettings.Scale;
  ScaleComboBox.ItemIndex := GSettings.ScaleOp;
  IncTypeValueComboBox.ItemIndex:= GSettings.IncType;
  IncTypeComboBox.ItemIndex := GSettings.IncTypeOp;
  PriorityValueEdit.Text := GSettings.Priority;
  PriorityComboBox.ItemIndex := GSettings.PriorityOp;
  WhereMemo.Text := GSettings.Custom;
end;

procedure TMainFormFilter.SaveControls;
begin
  GSettings.NumIncident := IncidentNumValueEdit.Text;
  GSettings.NumIncidentOp := IncidentNumComboBox.ItemIndex;
  GSettings.Status := StatusValueComboBox.ItemIndex;
  GSettings.StatusOp := StatusComboBox.ItemIndex;
  GSettings.Initiator := InitiatorValueEdit.Text;
  GSettings.InitiatorOp := InitiatorComboBox.ItemIndex;
  GSettings.Owner := OwnerValueEdit.Text;
  GSettings.OwnerOp := OwnerComboBox.ItemIndex;
  GSettings.Responsible := ResponsibleValueEdit.Text;
  GSettings.ResponsibleOp := ResponsibleComboBox.ItemIndex;
  GSettings.Element := InfrastructureValueEdit.Text;
  GSettings.ElementOp := InfrastructureComboBox.ItemIndex;
  GSettings.CreationDate :=  CreationDateValueEdit.Text;
  GSettings.CreationDateOp := CreationDateComboBox.ItemIndex;
  GSettings.FixDate := FixDateValueEdit.Text;
  GSettings.FixDateOp := FixDateComboBox.ItemIndex;
  GSettings.ClassIncident := ClassValueEdit.Text;
  GSettings.ClassIncidentOp := ClassComboBox.ItemIndex;
  GSettings.TypeClass0 := TypeValueEdit.Text;
  GSettings.TypeClass0Op := TypeComboBox.ItemIndex;
  GSettings.Scale := ScaleValueComboBox.ItemIndex;
  GSettings.ScaleOp := ScaleComboBox.ItemIndex;
  GSettings.Priority := PriorityValueEdit.Text;
  GSettings.PriorityOp := PriorityComboBox.ItemIndex;
  GSettings.IncType := IncTypeValueComboBox.ItemIndex;
  GSettings.IncTypeOp := IncTypeComboBox.ItemIndex;


  NormalizeWhereMemo;
  GSettings.Custom := WhereMemo.Text;

   GSettings.SaveMain( FilterCombo.Text );
   GSettings.Save;

end;



procedure TMainFormFilter.FormCreate(Sender: TObject);
var i : integer;
begin
   LoadControls;
   for i := 0 to GSettings.MainFiltersCount-1 do
   begin
     FilterCombo.AddItem(GSettings.MainFilters[i], TObject(0));
   end;
   FilterCombo.ItemIndex := GSettings.MainFiltersCurrent;

   CreateFieldsMap;
   CheckCustomFilter;
end;

procedure TMainFormFilter.ResetButtonClick(Sender: TObject);
begin
  if (FilterPageControl.ActivePage = FilterTabSheet) then
    Module.ResetFilter(self)
  else
    WhereMemo.Text := '';
end;


procedure TMainFormFilter.OwnerComboBoxExit(Sender: TObject);
begin
  OwnerComboBox.Repaint;
end;

procedure TMainFormFilter.ResponsibleComboBoxExit(Sender: TObject);
begin
  ResponsibleComboBox.Repaint;
end;

procedure TMainFormFilter.InfrastructureComboBoxExit(Sender: TObject);
begin
  InfrastructureComboBox.Repaint;
end;

procedure TMainFormFilter.CreationDateComboBoxExit(Sender: TObject);
begin
  CreationDateComboBox.Repaint;
end;

procedure TMainFormFilter.FixDateComboBoxExit(Sender: TObject);
begin
  FixDateComboBox.Repaint;
end;

procedure TMainFormFilter.ClassComboBoxExit(Sender: TObject);
begin
  ClassComboBox.Repaint;
end;

procedure TMainFormFilter.ScaleComboBoxExit(Sender: TObject);
begin
  ScaleComboBox.Repaint;
end;

procedure TMainFormFilter.PriorityComboBoxExit(Sender: TObject);
begin
  PriorityComboBox.Repaint;
end;

procedure TMainFormFilter.IncTypeValueComboBoxExit(Sender: TObject);
begin
  IncTypeComboBox.Repaint;
end;


procedure TMainFormFilter.TypeComboBoxExit(Sender: TObject);
begin
  TypeComboBox.Repaint;
end;

procedure TMainFormFilter.FilterComboChange(Sender: TObject);
var i : integer;
begin
  GSettings.LoadMain( FilterCombo.Text );
  LoadControls;

  for i := 0 to ComponentCount-1 do
  begin
    if Components[i] is TComboBox then
    begin
      TComboBox(Components[i]).Repaint;
    end;
  end;

  CheckCustomFilter;
   if (GSettings.Custom <> '') then
  begin
    if (FilterPageControl.ActivePage = CustomTabSheet)  then
      EnableNonCustomControls(true)
    else
      EnableNonCustomControls(false);
  end
  else
    EnableNonCustomControls(true);
end;

procedure TMainFormFilter.SaveButtonClick(Sender: TObject);
var i : integer;
begin
  SaveControls;
//  GSettings.SaveMain( FilterCombo.Text );
//  GSettings.Save;

  for i := 0 to ComponentCount-1 do
  begin
    if Components[i] is TComboBox then
    begin
      TComboBox(Components[i]).Repaint;
    end;
  end;
end;

procedure TMainFormFilter.SaveAsButtonClick(Sender: TObject);
var i : integer;
begin
  SaveFilterForm.ShowModal;
  if SaveFilterForm.Name = '' then exit;
  for i := 0 to FilterCombo.Items.Count - 1 do
  begin
    if SaveFilterForm.Name = FilterCombo.Items[i] then
    begin
      Application.MessageBox('Фильтр с таким именем уже существует','Ошибка создания фильтра', MB_ICONERROR);
      exit;
    end;
  end;

  FilterCombo.AddItem(SaveFilterForm.Name,TObject(0));
  SaveControls;
  GSettings.SaveMain(SaveFilterForm.Name);
  FilterCombo.ItemIndex := FilterCombo.Items.Count - 1;

  for i := 0 to ComponentCount-1 do
  begin
    if Components[i] is TComboBox then
    begin
      TComboBox(Components[i]).Repaint;
    end;
  end;

  GSettings.MainFiltersCount := FilterCombo.Items.Count;
  for i := 0 to FilterCombo.Items.Count - 1 do
  begin
    GSettings.MainFilters[i] := FilterCombo.Items[i];
  end;
 GSettings.Save;
end;

procedure TMainFormFilter.FilterComboExit(Sender: TObject);
begin
  FilterCombo.Repaint;
end;

procedure TMainFormFilter.DeleteButtonClick(Sender: TObject);
var i : integer;
begin
  GSettings.DeleteMain( FilterCombo.Text );
  GSettings.MainFiltersCount := GSettings.MainFiltersCount-1;
  FilterCombo.DeleteSelected;
  GSettings.MainFiltersCount := FilterCombo.Items.Count;
  for i := 0 to FilterCombo.Items.Count - 1 do
  begin
    GSettings.MainFilters[i] := FilterCombo.Items[i];
  end;
  GSettings.MainFiltersCurrent := 0;
  FilterCombo.ItemIndex := GSettings.MainFiltersCurrent;
  GSettings.LoadMain( FilterCombo.Text );
  LoadControls;

  for i := 0 to ComponentCount-1 do
  begin
    if Components[i] is TComboBox then
    begin
      TComboBox(Components[i]).Repaint;
    end;
  end;
end;





end.
