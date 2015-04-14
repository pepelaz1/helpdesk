unit logon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TLoginForm = class(TForm)
    LoginGroupBox: TGroupBox;
    UserNameLabel: TLabel;
    UserNameEdit: TEdit;
    PasswordLabel: TLabel;
    PasswordEdit: TEdit;
    DBLabel: TLabel;
    DBEdit: TEdit;
    EnterButton: TBitBtn;
    CancelButton: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure EnterButtonClick(Sender: TObject);
  private
     m_bCancel : boolean;
     m_strUserName : String;
     m_strDB : String;
  public

     property Cancel : boolean read m_bCancel write m_bCancel;
     property UserName : String read m_strUserName write m_strUserName;
     property DB : String read m_strDB write m_strDB;
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

procedure TLoginForm.FormShow(Sender: TObject);
begin
  UserNameEdit.Text := UserName;
  DBEdit.Text := DB;
  Cancel := true;
end;

procedure TLoginForm.CancelButtonClick(Sender: TObject);
begin
  Cancel := true;
  Close;
end;

procedure TLoginForm.EnterButtonClick(Sender: TObject);
begin
  Cancel := false;
  Close;
end;

end.
