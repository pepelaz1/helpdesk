unit initiator_selection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, Grids, DBGrids, ADSLib_TLB, ComCtrls,
  SxkDBGrid;


type
  TSetCredentialsProc = procedure ( strUserName : string; strPassword : string;
     strDB : string);stdcall;
  TSyncronizeUsersAndGroupsProc = procedure; stdcall;

  TInitiatorSelectionForm = class(TForm)
    SelectButton: TButton;
    CancelButton: TButton;
    InitiatorGrid: TSxkDBGrid;
    SyncButton: TButton;
    FilterButton: TButton;
    FilterStatusBar: TStatusBar;
    RefreshButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SelectButtonClick(Sender: TObject);
    procedure InitiatorGridDblClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure SyncButtonClick(Sender: TObject);
    procedure InitiatorGridDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FilterButtonClick(Sender: TObject);
    procedure InitiatorGridCellClick(Column: TColumn);
    procedure InitiatorGridKeyPress(Sender: TObject; var Key: Char);
    procedure RefreshButtonClick(Sender: TObject);
  private
    FSyncAD : THandle;
    FSetCredentialsProc :  TSetCredentialsProc;
    FSyncronizeUsersAndGroups : TSyncronizeUsersAndGroupsProc;
    FFastFiltered : boolean;

    procedure SelectPerson;
    procedure UpdateFilterBar;
  public

  end;

var
  InitiatorSelectionForm: TInitiatorSelectionForm;

implementation

{$R *.dfm}

uses global, register, initiator_filter;

procedure TInitiatorSelectionForm.FormCreate(Sender: TObject);
begin
  Module.InitiatorDataSet.Active := true;
end;

procedure TInitiatorSelectionForm.SelectButtonClick(Sender: TObject);
begin
  SelectPerson;
end;


procedure TInitiatorSelectionForm.InitiatorGridDblClick(Sender: TObject);
begin
  SelectPerson;
  
end;

procedure  TInitiatorSelectionForm.SelectPerson;
begin
  RegisterForm.InitiatorEdit.Text := InitiatorGrid.Fields[0].AsString;
  Close;
end;



procedure TInitiatorSelectionForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TInitiatorSelectionForm.SyncButtonClick(Sender: TObject);
begin
  try
    try
      FSyncAD := LoadLibrary('SyncAD.dll');
      if (FSyncAD <> 0) then
      begin
         SyncButton.Enabled := false;

         FSetCredentialsProc := GetProcAddress(FSyncAD, 'SetCredentials');
         FSyncronizeUsersAndGroups := GetProcAddress(FSyncAD,'SyncronizeUsersAndGroups');
         if  ((@FSetCredentialsProc <> nil ) and ( @FSyncronizeUsersAndGroups <> nil)) then
         begin

           FSetCredentialsProc (Module.OraSession.LogonUsername,
              Module.OraSession.LogonPassword, Module.OraSession.LogonDatabase);


           Screen.Cursor := crHourGlass;
           FSyncronizeUsersAndGroups;

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
    Module.InitiatorDataSet.Active := true;
    Module.InitiatorDataSet.Refresh;
    Screen.Cursor := crDefault;
  end;

end;

procedure TInitiatorSelectionForm.InitiatorGridDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  Module.PaintGrid(InitiatorGrid, Module.InitiatorDataSet,Rect, DataCol, Column, State);
end;


procedure TInitiatorSelectionForm.FormShow(Sender: TObject);
begin
  Module.InitiatorDataSet.Refresh;
  InitiatorFormFilter.Apply;
  FilterStatusBar.Color := Module.EvenColor;
  UpdateFilterBar;
  Module.UpdateColumnTitle(FilterStatusBar, InitiatorGrid);
end;

procedure TInitiatorSelectionForm.FilterButtonClick(Sender: TObject);
begin
  InitiatorFormFilter.ShowModal;
  UpdateFilterBar;
end;

procedure TInitiatorSelectionForm.UpdateFilterBar;
begin
  if (InitiatorFormFilter.Filtered) or (FFastFiltered) then
    FilterStatusBar.Panels[0].Text :=  ' Данные отфильтрованы'
  else
    FilterStatusBar.Panels[0].Text :=  ' Данные не отфильтрованы';
end;

procedure TInitiatorSelectionForm.InitiatorGridCellClick(Column: TColumn);
begin
   Module.UpdateColumnTitle(FilterStatusBar, InitiatorGrid);
end;

procedure TInitiatorSelectionForm.InitiatorGridKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key <> #13) and (Key <> #27) then
  begin
   Module.FastFilter(Key,self, Module.InitiatorDataSet, InitiatorGrid, FFastFiltered);
   UpdateFilterBar;
  end; 
end;

procedure TInitiatorSelectionForm.RefreshButtonClick(Sender: TObject);
begin
  Module.InitiatorDataSet.Filtered := false;
  FFastFiltered := false;
  Module.InitiatorDataSet.Refresh;
  UpdateFilterBar;
end;




end.
