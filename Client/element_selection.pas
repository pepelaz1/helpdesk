unit element_selection;

interface



uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DBCtrls, ADSLib_TLB, ComCtrls,
  SxkDBGrid;

type
  TSetCredentialsProc = procedure ( strUserName : string; strPassword : string;
     strDB : string);stdcall;
  TSyncronizeInfrastructure = procedure; stdcall;


  TElementSelectionForm = class(TForm)
    CancelButton: TButton;
    SelectButton: TButton;
    SyncButton: TButton;
    FilterButton: TButton;
    FilterStatusBar: TStatusBar;
    RefreshButton: TButton;
    ElementGrid: TSxkDBGrid;
    procedure SelectButtonClick(Sender: TObject);
    procedure ElementGridDblClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ElementGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure SyncButtonClick(Sender: TObject);
    procedure ElementGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FilterButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RefreshButtonClick(Sender: TObject);
    procedure ElementGridKeyPress(Sender: TObject; var Key: Char);
    procedure ElementGridCellClick(Column: TColumn);
  private
    FFastFiltered : boolean;

    FSyncAD : THandle;
    FSetCredentialsProc :  TSetCredentialsProc;
    FSyncronizeInfrastructure : TSyncronizeInfrastructure;

    procedure SelectElement;
    procedure UpdateFilterBar;
  public


  end;

var
  ElementSelectionForm: TElementSelectionForm;

implementation

{$R *.dfm}

uses global, register, main_filter, element_filter;

procedure TElementSelectionForm.SelectButtonClick(Sender: TObject);
begin
  SelectElement;
end;

procedure  TElementSelectionForm.SelectElement;
begin
  RegisterForm.ElementEdit.Text := ElementGrid.Fields[0].AsString;
  Close;
end;

procedure TElementSelectionForm.ElementGridDblClick(Sender: TObject);
begin
  SelectElement;
end;

procedure TElementSelectionForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TElementSelectionForm.FormCreate(Sender: TObject);
begin
//  Module.ActivateDataSets;
   Module.ElementDataSet.Active := true;
end;

procedure TElementSelectionForm.ElementGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  Module.PaintGrid(ElementGrid, Module.ElementDataSet,Rect, DataCol, Column, State);
end;

procedure TElementSelectionForm.SyncButtonClick(Sender: TObject);
begin

  try
    try
        FSyncAD := LoadLibrary('SyncAD.dll');

      if (FSyncAD <> 0) then
      begin
         SyncButton.Enabled := false;

         FSetCredentialsProc := GetProcAddress(FSyncAD, 'SetCredentials');
         FSyncronizeInfrastructure := GetProcAddress(FSyncAD,'SyncronizeInfrastructure');
         if  ((@FSetCredentialsProc <> nil ) and ( @FSyncronizeInfrastructure <> nil)) then
         begin

           FSetCredentialsProc (Module.OraSession.LogonUsername,
              Module.OraSession.LogonPassword, Module.OraSession.LogonDatabase);

           Screen.Cursor := crHourGlass;
           FSyncronizeInfrastructure;

           Application.MessageBox('Обновление успешно завершено!', 'Синхронизация с AD', MB_OK);

         end
         else
         begin
           Application.MessageBox('Произошла ошибка синхронизации. Возможно недостаточно прав', 'Ошибка', MB_OK);
           FreeLibrary(FSyncAD);
           exit;
         end;

         FreeLibrary(FSyncAD);
         end
      else
        Application.MessageBox('Произошла ошибка синхронизации. Возможно недостаточно прав', 'Ошибка', MB_OK);

    except
      Application.MessageBox('Произошла ошибка синхронизации. Возможно недостаточно прав', 'Ошибка', MB_OK);
    end;
  finally
    SyncButton.Enabled := true;
    Module.ElementDataSet.Active := true;
    Module.ElementDataSet.Refresh;
    Screen.Cursor := crDefault;
  end;

end;

procedure TElementSelectionForm.ElementGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//  if Key = 13 then SelectElement;
end;

procedure TElementSelectionForm.FilterButtonClick(Sender: TObject);
begin
   ElementFormFilter.ShowModal;
   UpdateFilterBar;
end;

procedure TElementSelectionForm.FormShow(Sender: TObject);
begin
//  Module.ElementDataSet.Active := true;
  Module.ElementDataSet.Refresh;
  ElementFormFilter.Apply;
  FilterStatusBar.Color := Module.EvenColor;
  UpdateFilterBar;
  Module.UpdateColumnTitle( FilterStatusBar, ElementGrid );
end;

procedure TElementSelectionForm.UpdateFilterBar;
begin
  if (ElementFormFilter.Filtered) or FFastFiltered then
    FilterStatusBar.Panels[0].Text :=  ' Данные отфильтрованы'
  else
    FilterStatusBar.Panels[0].Text :=  ' Данные не отфильтрованы';
end;

procedure TElementSelectionForm.RefreshButtonClick(Sender: TObject);
begin
  Module.ElementDataSet.Filtered := false;
  FFastFiltered := false;
  Module.ElementDataSet.Refresh;
  UpdateFilterBar;
end;

procedure TElementSelectionForm.ElementGridKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key <> #13) and (Key <> #27) then
  begin
    Module.FastFilter(Key,self, Module.ElementDataSet, ElementGrid, FFastFiltered);
    UpdateFilterBar;
  end;  
end;

procedure TElementSelectionForm.ElementGridCellClick(Column: TColumn);
begin
  Module.UpdateColumnTitle( FilterStatusBar, ElementGrid );
end;



end.
