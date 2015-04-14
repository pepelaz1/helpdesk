unit class_selection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SxkDBGrid, StdCtrls, ComCtrls;

type
  TClassSelectionForm = class(TForm)
    ClassGrid: TSxkDBGrid;
    FilterStatusBar: TStatusBar;
    FilterButton: TButton;
    SelectButton: TButton;
    CancelButton: TButton;
    RefreshButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure SelectButtonClick(Sender: TObject);
    procedure ClassGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ClassGridDblClick(Sender: TObject);
    procedure FilterButtonClick(Sender: TObject);
    procedure RefreshButtonClick(Sender: TObject);
    procedure ClassGridCellClick(Column: TColumn);
    procedure ClassGridKeyPress(Sender: TObject; var Key: Char);
    procedure ClassGridTitleClick(Column: TColumn);
  private
    FFastFiltered : boolean;
    FSelected : boolean;
    FSortBy : string;

    procedure SelectClass;
    procedure UpdateFilterBar;
  public

    property Selected : boolean read FSelected  write FSelected;

    // Столбец по которому сортировать
    property SortBy : string read FSortBy write FSortBy;
  end;

var
  ClassSelectionForm: TClassSelectionForm;

implementation

uses global, register, class_filter, settings;

{$R *.dfm}

procedure TClassSelectionForm.FormShow(Sender: TObject);
begin
  Module.ClassDataSet2.Active := true;
  ClassFormFilter.Apply;
//  Module.ClassDataSet.Active := true;

  FilterStatusBar.Color := Module.EvenColor;
  UpdateFilterBar;
  Module.UpdateColumnTitle( FilterStatusBar, ClassGrid );
  Selected := false;
  SortBy := '';
end;

procedure TClassSelectionForm.CancelButtonClick(Sender: TObject);
begin
  Selected := false;
  Close;
end;

procedure TClassSelectionForm.SelectButtonClick(Sender: TObject);
begin
  SelectClass;
end;

procedure TClassSelectionForm.SelectClass;
begin
  RegisterForm.ClassEdit.Text := ClassGrid.Fields[1].AsString;
  Selected := true;
  Close;
end;

procedure TClassSelectionForm.ClassGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  Module.PaintGrid(ClassGrid, Module.ClassDataSet2,Rect, DataCol, Column, State);
end;

procedure TClassSelectionForm.ClassGridDblClick(Sender: TObject);
begin
   SelectClass;
end;

procedure TClassSelectionForm.UpdateFilterBar;
begin
   if (ClassFormFilter.Filtered) or (FFastFiltered) then
    FilterStatusBar.Panels[0].Text :=  ' Данные отфильтрованы'
  else
    FilterStatusBar.Panels[0].Text :=  ' Данные не отфильтрованы';
end;

procedure TClassSelectionForm.FilterButtonClick(Sender: TObject);
begin
  ClassFormFilter.ShowModal;
  UpdateFilterBar;  
end;

procedure TClassSelectionForm.RefreshButtonClick(Sender: TObject);
begin
  Module.ClassDataSet2.Filtered := false;
  FFastFiltered := false;
  Module.ClassDataSet2.Refresh;
  UpdateFilterBar;
end;

procedure TClassSelectionForm.ClassGridCellClick(Column: TColumn);
begin
  Module.UpdateColumnTitle( FilterStatusBar, ClassGrid );
end;

procedure TClassSelectionForm.ClassGridKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key <> #13) and (Key <> #27) then
  begin
    Module.FastFilter(Key,self, Module.ClassDataSet2, ClassGrid, FFastFiltered);
    UpdateFilterBar;
  end;
end;



procedure TClassSelectionForm.ClassGridTitleClick(Column: TColumn);
begin
   GSettings.ClassSortedBy := Column.FieldName;
   ClassFormFilter.Apply;
end;

end.
