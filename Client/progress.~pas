unit progress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges;

type
  TProgressForm = class(TForm)
    Gauge: TGauge;
    procedure FormShow(Sender: TObject);
  private
    m_nNextValue : integer;
  public
    procedure MoveProgress( value : integer );
    procedure OnTimer;
  end;

var
  ProgressForm: TProgressForm;

implementation

uses global;
{$R *.dfm}


procedure TProgressForm.FormShow(Sender: TObject);
begin
  Gauge.ForeColor := Module.OddColor;
end;

procedure TProgressForm.MoveProgress( value : integer );
begin
// m_nNextValue := value;
// Module.ProgressTimer.Enabled := true;
 Gauge.Progress := value;
end;

procedure TProgressForm.OnTimer;
begin
  Gauge.Progress := Gauge.Progress + 1;
  if Gauge.Progress = m_nNextValue then Module.ProgressTimer.Enabled := false;

end;

end.
