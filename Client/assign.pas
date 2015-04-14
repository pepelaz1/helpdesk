unit assign;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, db, SxkDBGrid;

type
  TAssignForm = class(TForm)
    SelectButton: TButton;
    CancelButton: TButton;
    AssignGrid: TSxkDBGrid;
    NotifyCheckBox: TCheckBox;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AssignGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure AssignGridDblClick(Sender: TObject);
    procedure SelectButtonClick(Sender: TObject);
  private

    FSelected : boolean;
    procedure UpdateResponsible;
  public

    property Selected : boolean read FSelected write FSelected;

  end;

var
  AssignForm: TAssignForm;

implementation

uses global;
{$R *.dfm}

procedure TAssignForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TAssignForm.FormShow(Sender: TObject);
begin
  Selected := false;
  Module.AssignDataSet.Active := true;
  Module.AssignDataSet.Refresh;
end;

procedure TAssignForm.AssignGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
 Module.PaintGrid(AssignGrid, Module.AssignDataSet,Rect, DataCol, Column, State);
end;

procedure TAssignForm.AssignGridDblClick(Sender: TObject);
begin
  UpdateResponsible;
end;


procedure TAssignForm.SelectButtonClick(Sender: TObject);
begin
  UpdateResponsible;
end;

procedure  TAssignForm.UpdateResponsible;
begin
  Selected := true;
  Close;
end;



end.
