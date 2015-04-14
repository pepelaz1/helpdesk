unit reason;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, DBGrids, SxkDBGrid;

type
  TReasonForm = class(TForm)
    SelectButton: TSpeedButton;
    ReasonGrid: TSxkDBGrid;
    procedure FormShow(Sender: TObject);
    procedure ReasonGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure SelectButtonClick(Sender: TObject);
    procedure ReasonGridDblClick(Sender: TObject);
  private
    m_nIncidentNum : integer;
    procedure SelectReason;
  public
    property IncidentNum : integer read m_nIncidentNum write m_nIncidentNum;
  end;

var
  ReasonForm: TReasonForm;

implementation

uses global;

{$R *.dfm}

procedure TReasonForm.FormShow(Sender: TObject);
begin
  Module.ReasonDataSet.Active := true;
end;

procedure TReasonForm.ReasonGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
 Module.PaintGrid(ReasonGrid, Module.ReasonDataSet,Rect, DataCol, Column, State);
end;

procedure TReasonForm.SelectButtonClick(Sender: TObject);
begin
  SelectReason;
end;

procedure TReasonForm.SelectReason;
var s : string;
begin
  Module.OraQuery.SQL.Text := 'begin update incident_card t set t.num_source = ' + Module.ReasonDataSetNUM_SOURCE.AsString + ' where t.num_incident = ' + IntToStr(IncidentNum) + ';commit; end;';
  s := Module.OraQuery.SQL.Text;
  Module.OraQuery.Execute;
  Close;
end;

procedure TReasonForm.ReasonGridDblClick(Sender: TObject);
begin
  SelectReason;
end;

end.
