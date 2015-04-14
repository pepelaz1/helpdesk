unit scale_selection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, SxkDBGrid, global;

type
  TScaleSelectionForm = class(TForm)
    SelectButton: TButton;
    CancelButton: TButton;
    ScaleGrid: TSxkDBGrid;
    procedure CancelButtonClick(Sender: TObject);
    procedure SelectButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScaleGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ScaleGridDblClick(Sender: TObject);
  private
    FSelected : boolean;

    // Выбор нового масштаба инцидента
    procedure SelectScale;
  public

    property Selected : boolean read FSelected write FSelected;
  end;

var
  ScaleSelectionForm: TScaleSelectionForm;

implementation

{$R *.dfm}

procedure TScaleSelectionForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TScaleSelectionForm.SelectButtonClick(Sender: TObject);
begin
 SelectScale;
end;

procedure TScaleSelectionForm.SelectScale;
begin
  Selected := true;
  Close;
end;

procedure TScaleSelectionForm.FormShow(Sender: TObject);
begin
  Module.ScaleDataSet.Active := true;
  Selected := false;
end;

procedure TScaleSelectionForm.ScaleGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  Module.PaintGrid(ScaleGrid, Module.ScaleDataSet,Rect, DataCol, Column, State);
end;

procedure TScaleSelectionForm.ScaleGridDblClick(Sender: TObject);
begin
  SelectScale;
end;

end.
