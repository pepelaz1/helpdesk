unit viewtool;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TViewToolForm = class(TForm)
    Bevel1: TBevel;
    IncidentAmountLabel: TLabel;
    IncidentAmountLabel2: TLabel;
    IncidentMonthMemo: TMemo;
    AcceptUpCheck: TCheckBox;
    procedure IncidentMonthMemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewToolForm: TViewToolForm;

implementation

uses main;

{$R *.dfm}

procedure TViewToolForm.IncidentMonthMemoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if (Key = 13) then
     MainForm.RefreshIncidents;
end;

procedure TViewToolForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 //MainForm.RefreshIncidents;
end;

end.
