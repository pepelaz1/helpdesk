unit add_responsible;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Oracle;

type
  TResponsibleAddForm = class(TForm)
    ClassLabel: TLabel;
    ResponsibleLabel: TLabel;
    ResponsibleComboBox: TComboBox;
    AddButton: TSpeedButton;
    CancelButton: TSpeedButton;
    ClassComboBox: TComboBox;
    procedure ClassComboBoxExit(Sender: TObject);
    procedure ResponsibleComboBoxExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
  private
    m_StrWorkers : TStringList;
  public
   
  end;

var
  ResponsibleAddForm: TResponsibleAddForm;

implementation

uses global;
{$R *.dfm}

procedure TResponsibleAddForm.ClassComboBoxExit(Sender: TObject);
begin
  ClassComboBox.Repaint;
end;

procedure TResponsibleAddForm.ResponsibleComboBoxExit(Sender: TObject);
begin
  ResponsibleComboBox.Repaint;
end;

procedure TResponsibleAddForm.FormCreate(Sender: TObject);
var s : string;
begin

  m_StrWorkers := TStringList.Create;


  Module.ClassDataSet2.Active := true;
  Module.InitiatorDataSet.Active := true;

  // Fill responsible combobox
  ResponsibleComboBox.Clear;
  Module.InitiatorDataSet.First;
  while not Module.InitiatorDataSet.Eof do
  begin
    s := Module.InitiatorDataSet.FieldByName('ID_WORK').AsString;
    m_StrWorkers.Add(s);
    ResponsibleComboBox.AddItem(Module.InitiatorDataSet.FieldByName('WORKER').AsString, nil);
    Module.InitiatorDataSet.Next;
  end;
  ResponsibleComboBox.ItemIndex := 0;


   // Fill class combobox
  ClassComboBox.Clear;
  Module.ClassDataSet2.First;
  while not Module.ClassDataSet2.Eof do
  begin
    ClassComboBox.Items.AddObject(Module.ClassDataSet2.FieldByName('NAME_CLASS').AsString,
      TObject(Module.ClassDataSet2.FieldByName('NUM_CLASS').AsInteger));
    Module.ClassDataSet2.Next;
  end;
  ClassComboBox.ItemIndex := 0;
end;

procedure TResponsibleAddForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TResponsibleAddForm.AddButtonClick(Sender: TObject);
var s : string;
begin
  try
    Module.OraQuery.SQL.Text := 'begin' +
      ' Responsible_package.InsertResponsible(' +
        IntToStr(integer(ClassComboBox.Items.Objects[ClassComboBox.ItemIndex])) +
        ','+
        '''' + string(m_StrWorkers[ ResponsibleComboBox.ItemIndex ]) + '''' +
      ');' +
      'end;';
    s := Module.OraQuery.SQL.Text;
    Module.OraQuery.Execute;
    Close;
  except
    on E: EOracleError do
    begin
       if E.ErrorCode = 20000 then
         Application.MessageBox('????? ?????? ??? ??????????', '??????');
    end
    else
    begin
     Application.MessageBox('?????? ?????????? ??????????????', '??????');
     Close;
    end;
  end;
end;

end.
