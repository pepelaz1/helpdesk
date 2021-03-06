unit options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ComCtrls, global;

type
  TOptionsForm = class(TForm)
    CloseButton: TSpeedButton;
    ApplyButton: TSpeedButton;
    ColumnsGroupBox: TGroupBox;
    HideListBox: TListBox;
    HideLabel: TLabel;
    ShowListBox: TListBox;
    ShowLabel: TLabel;
    AddButton: TButton;
    RemoveButton: TButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RemoveButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    
  private

    FTmpArr : array [1..COLUMNS_COUNT] of integer;

    procedure SetTmpArr(i,value : integer);
    function GetTmpArr(i: integer) : integer;

    procedure ColumnsToTmp;
    procedure TmpToColumns;

    // ?????????? ???? ??????
    procedure UpdateListBoxes;

    property TmpArr[i : integer] : integer read GetTmpArr write SetTmpArr;
  public


  end;

var
  OptionsForm: TOptionsForm;

implementation

uses main;

{$R *.dfm}

procedure  TOptionsForm.SetTmpArr(i,value : integer);
begin
  FTmpArr[i] := value;
end;

function  TOptionsForm.GetTmpArr(i: integer) : integer;
begin
  Result := FTmpArr[i];
end;

procedure TOptionsForm.ColumnsToTmp;
var i : integer;
begin
  for i := 1 to MainForm.ColumnsCount do
    TmpArr[i] := MainForm.Columns[i];
end;

procedure TOptionsForm.TmpToColumns;
var i : integer;
begin
  for i := 1 to MainForm.ColumnsCount do
    MainForm.Columns[i] := TmpArr[i];
end;

procedure TOptionsForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TOptionsForm.UpdateListBoxes;
var i : integer;
begin

  // ??????? ???? ?????
  HideListBox.Clear;
  ShowListBox.Clear;

  with MainForm do
   for i := 1 to ColumnsCount do
   begin
     if TmpArr[i] = VISIBLE_COLUMN then
       ShowListBox.AddItem( IncidentGrid.Columns[i-1].Title.Caption,nil)
     else
       HideListBox.AddItem( IncidentGrid.Columns[i-1].Title.Caption,nil);
   end;
end;

procedure TOptionsForm.FormShow(Sender: TObject);
begin
  HideListBox.Color := Module.EvenColor;
  ShowListBox.Color := Module.EvenColor;

  ColumnsToTmp;
  UpdateListBoxes;
end;

procedure TOptionsForm.RemoveButtonClick(Sender: TObject);
var i,j, n : integer;
begin
  for i := 0 to ShowListBox.Count - 1 do
  begin
    if ShowListBox.Selected[i] then
    begin
      n := 0;
      for j := 1 to MainForm.ColumnsCount do
      begin
        if TmpArr[j] <> INVISIBLE_COLUMN then
        begin
          Inc(n);
          if (n = (i+1)) then break;
        end;
      end;
      if (j > 0) and ( j <= MainForm.ColumnsCount) then
//        TmpArr[j] := INVISIBLE_COLUMN;
        TmpArr[j] := TMP_VISIBILITY;
    end;
  end;

  for i := 1 to MainForm.ColumnsCount do
    if TmpArr[i] = TMP_VISIBILITY then TmpArr[i] := INVISIBLE_COLUMN;

  UpdateListBoxes;
end;

procedure TOptionsForm.AddButtonClick(Sender: TObject);
var i,j, n : integer;
begin
  for i := 0 to HideListBox.Count - 1 do
  begin
    if HideListBox.Selected[i] then
    begin
      n := 0;
      for j := 1 to MainForm.ColumnsCount do
      begin
        if TmpArr[j] <> VISIBLE_COLUMN then
        begin
          Inc(n);
          if (n = (i+1)) then break;
        end;
      end;
      if (j > 0) and ( j <= MainForm.ColumnsCount) then
//        TmpArr[j] := INVISIBLE_COLUMN;
        TmpArr[j] := TMP_VISIBILITY;
    end;
  end;

  for i := 1 to MainForm.ColumnsCount do
    if TmpArr[i] = TMP_VISIBILITY then TmpArr[i] := VISIBLE_COLUMN;

  UpdateListBoxes;

end;

procedure TOptionsForm.ApplyButtonClick(Sender: TObject);
begin
  TmpToColumns;
  Close;
end;

end.
