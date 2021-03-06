unit save_main_filter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TSaveFilterForm = class(TForm)
    NameEdit: TEdit;
    NameLabel: TLabel;
    SaveButton: TButton;
    procedure SaveButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    m_Name : string;
  public
    property Name : string read m_Name write m_Name;
  end;

var
  SaveFilterForm: TSaveFilterForm;

implementation

{$R *.dfm}

procedure TSaveFilterForm.SaveButtonClick(Sender: TObject);
begin
  if NameEdit.Text <> '' then
  begin
    Name := NameEdit.Text;
    Close;
  end;
end;

procedure TSaveFilterForm.FormShow(Sender: TObject);
begin
  Name := '';
  NameEdit.Text := '';
end;

end.
