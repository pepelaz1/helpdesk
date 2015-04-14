unit responsible;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ComCtrls, SxkDBGrid;

type
  TResponsibleForm = class(TForm)
    ResponsibleGrid: TSxkDBGrid;
    AddButton: TButton;
    RemoveButton: TButton;
    CloseButton: TButton;
    FilterButton: TButton;
    FilterStatusBar: TStatusBar;
    RefreshButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure RemoveButtonClick(Sender: TObject);
    procedure ResponsibleGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ResponsibleGridDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FilterButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RefreshButtonClick(Sender: TObject);
    procedure ResponsibleGridKeyPress(Sender: TObject; var Key: Char);
    procedure ResponsibleGridCellClick(Column: TColumn);

  private
    m_bFastFiltered : boolean;

    procedure DeleteCurrentRecord;
    procedure UpdateFilterBar;
  public


  end;

var
  ResponsibleForm: TResponsibleForm;

implementation

uses global, add_responsible, responsible_filter;

{$R *.dfm}

procedure TResponsibleForm.FormCreate(Sender: TObject);
begin
  Module.ResponsibleDataSet.Active := true;
end;

procedure TResponsibleForm.CloseButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TResponsibleForm.AddButtonClick(Sender: TObject);
begin
  ResponsibleAddForm.ShowModal;
  Module.ResponsibleDataSet.Refresh;
end;

procedure TResponsibleForm.RemoveButtonClick(Sender: TObject);
begin
   DeleteCurrentRecord;
end;

procedure TResponsibleForm.ResponsibleGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//  if Key = 46 // 'Delete' key
  //  then DeleteCurrentRecord;
end;

procedure TResponsibleForm.DeleteCurrentRecord;
var
 s: string;
begin

   if (Module.ResponsibleDataSetNUM_CLASS.AsString = '')  or
     (Module.ResponsibleDataSetNUM_CLASS.AsString = '') then
     exit;


 (* try
     Module.OraQuery.SQL.Text := 'begin ' +
      'RESPONSIBLE_PACKAGE.DeleteResponsible(' +
      '''' + ResponsibleGrid.Fields[0].AsString + '''' +
      ',' +
      '''' + ResponsibleGrid.Fields[1].AsString + '''' +
      ');' +
      'end;';
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
     Module.ResponsibleDataSet.Refresh;
   except
     Application.MessageBox('Ошибка удаления записи','Ошибка');
   end;   *)

    try
     Module.OraQuery.SQL.Text := 'begin ' +
      'RESPONSIBLE_PACKAGE.DeleteResponsible(' +
       Module.ResponsibleDataSetNUM_CLASS.AsString +
      ',' +
      '''' +  Module.ResponsibleDataSetID_WORK.AsString + '''' +
      ');' +
      'end;';
     s := Module.OraQuery.SQL.Text;
     Module.OraQuery.Execute;
     Module.ResponsibleDataSet.Refresh;
   except
     Application.MessageBox('Ошибка удаления записи','Ошибка');
   end;

end;

procedure TResponsibleForm.ResponsibleGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  Module.PaintGrid(ResponsibleGrid, Module.ResponsibleDataSet,Rect, DataCol, Column, State);
end;

procedure TResponsibleForm.FilterButtonClick(Sender: TObject);
begin
  ResponsibleFormFilter.ShowModal;
  UpdateFilterBar;
end;

procedure TResponsibleForm.FormShow(Sender: TObject);
begin
  ResponsibleFormFilter.Apply;
  FilterStatusBar.Color := Module.EvenColor;
  UpdateFilterBar;

  Module.UpdateColumnTitle( FilterStatusBar, ResponsibleGrid);
end;

procedure TResponsibleForm.UpdateFilterBar;
begin
  if (ResponsibleFormFilter.Filtered) or m_bFastFiltered then
    FilterStatusBar.Panels[0].Text :=  ' Данные отфильтрованы'
  else
    FilterStatusBar.Panels[0].Text :=  ' Данные не отфильтрованы';
end;

procedure TResponsibleForm.RefreshButtonClick(Sender: TObject);
begin
  Module.ResponsibleDataSet.Filtered := false;
  m_bFastFiltered := false;
  Module.ResponsibleDataSet.Refresh;
  UpdateFilterBar;
end;

procedure TResponsibleForm.ResponsibleGridKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key <> #13) and (Key <> #27) then
  begin
    Module.FastFilter(Key,self, Module.ResponsibleDataSet, ResponsibleGrid, m_bFastFiltered);
    UpdateFilterBar;
  end;  
end;

procedure TResponsibleForm.ResponsibleGridCellClick(Column: TColumn);
begin
   Module.UpdateColumnTitle( FilterStatusBar, ResponsibleGrid);
end;


end.
