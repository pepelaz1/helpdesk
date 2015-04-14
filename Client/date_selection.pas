unit date_selection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Calendar, StdCtrls, Spin, DateUtils, Mask;

type
  TCalendarForm = class(TForm)
    CalendarControl: TCalendar;
    YearLabel: TLabel;
    YearEdit: TSpinEdit;
    MonthLabel: TLabel;
    MonthComboBox: TComboBox;
    SelectButton: TButton;
    CancelButton: TButton;
    TimeEdit: TMaskEdit;
    TimeButton: TSpinButton;
    TimeLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure MonthComboBoxChange(Sender: TObject);
    procedure YearEditChange(Sender: TObject);
    procedure CalendarControlDblClick(Sender: TObject);
    procedure SelectButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure TimeButtonDownClick(Sender: TObject);
    procedure TimeButtonUpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    m_bSet : boolean;
    m_Hours, m_Minutes, m_Seconds : integer;

    procedure SelectDate;
    procedure ShowTime;
    function ValidateTime : boolean;
  public
    function IsSet : boolean;

    property Hours : integer read m_Hours write m_Hours;
    property Minutes : integer read m_Minutes write m_Minutes;
    property Seconds : integer read m_Seconds write m_Seconds;
  end;

var
  CalendarForm: TCalendarForm;

implementation

uses register;

{$R *.dfm}

procedure TCalendarForm.FormCreate(Sender: TObject);
begin
  CalendarControl.UseCurrentDate := true;
  YearEdit.Text := IntToStr(CalendarControl.Year);
  MonthComboBox.ItemIndex := CalendarControl.Month-1;
  ShowTime;
  m_bSet := false;
end;

procedure TCalendarForm.MonthComboBoxChange(Sender: TObject);
begin
  CalendarControl.Month := MonthComboBox.ItemIndex+1;
end;

procedure TCalendarForm.YearEditChange(Sender: TObject);
begin
  CalendarControl.Year := StrToInt(YearEdit.Text);
end;

procedure TCalendarForm.CalendarControlDblClick(Sender: TObject);
begin
  SelectDate;
end;

procedure TCalendarForm.SelectButtonClick(Sender: TObject);
begin
  SelectDate;
end;

procedure TCalendarForm.SelectDate;
begin
  if ValidateTime then
  begin
    m_bSet := true;
    Close;
  end;
end;

procedure TCalendarForm.CancelButtonClick(Sender: TObject);
begin
  m_bSet := false;
  Close;
end;

procedure TCalendarForm.ShowTime;
var h,m,s : string;
begin
  h := Format('%0.2d',[m_Hours]);
  m := Format('%0.2d',[m_Minutes]);
  s := Format('%0.2d',[m_Seconds]);
  TimeEdit.Text := h + ':' + m + ':' + s;
end;


procedure TCalendarForm.TimeButtonDownClick(Sender: TObject);
begin
  Hours := StrToInt( Copy(TimeEdit.Text,1,2) );
  Minutes := StrToInt( Copy(TimeEdit.Text,4,2) );
  Seconds := StrToInt( Copy(TimeEdit.Text,7,2) );

  if Seconds = 0 then
  begin
    if Minutes = 0 then
    begin
      Minutes := 60;

      if Hours = 0 then Hours := 24;
      Hours := Hours - 1;
    end;
    Minutes := Minutes - 1;
    Seconds := 60;
  end;
  Seconds := Seconds - 1;

  ShowTime;
end;

function TCalendarForm.ValidateTime : boolean;
var  b : boolean;
begin
  b := true;
  try
   StrToTime( TimeEdit.Text );
  except
    Application.MessageBox('Неправильный формат времени','Ошибка');
    b := false;
  end;

  if b then
  begin
    Hours := StrToInt( Copy(TimeEdit.Text,1,2) );
    Minutes := StrToInt( Copy(TimeEdit.Text,4,2) );
    Seconds := StrToInt( Copy(TimeEdit.Text,7,2) );
  end;

  Result := b;
end;

procedure TCalendarForm.TimeButtonUpClick(Sender: TObject);
begin
  Hours := StrToInt( Copy(TimeEdit.Text,1,2) );
  Minutes := StrToInt( Copy(TimeEdit.Text,4,2) );
  Seconds := StrToInt( Copy(TimeEdit.Text,7,2) );

  if Seconds = 60 then
  begin
    if Minutes = 60 then
    begin
      Minutes := 0;

      if Hours = 24 then Hours := 0;
      Hours := Hours + 1;
    end;
    Minutes := Minutes + 1;
    Seconds := 0;
  end;
  Seconds := Seconds + 1;
  ShowTime;
end;

function TCalendarForm.IsSet : boolean;
begin
  Result := m_bSet;
end;

procedure TCalendarForm.FormShow(Sender: TObject);
begin
 ShowTime;
end;

end.
