unit user_info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls;

type
  TUserInfoForm = class(TForm)
    gb1: TGroupBox;
    FIOLabel: TLabel;
    FIOEdit: TDBEdit;
    PhoneLabel: TLabel;
    Label1: TLabel;
    EmailEdit: TDBEdit;
    PhoneEdit: TDBEdit;
    CloseButton: TButton;
    Label2: TLabel;
    AddressEdit: TDBEdit;
    Label3: TLabel;
    DeptMemo: TDBMemo;
    DescrLabel: TLabel;
    DescrEdit: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private
    // Идентификатор пользователя по которому будем получать информацию
    FUserID : string;
  public
    property UserID : string read FUserID write FUserID;
  end;

var
  UserInfoForm: TUserInfoForm;

implementation

uses global;

{$R *.dfm}

procedure TUserInfoForm.FormShow(Sender: TObject);
begin
  Module.UserInfoDataSet.SetVariable('ID',UserID);
  Module.UserInfoDataSet.Close();
  Module.UserInfoDataSet.Open();


  FIOEdit.Color := Module.EvenColor;
  DescrEdit.Color := Module.OddColor;
  PhoneEdit.Color := Module.EvenColor;
  EmailEdit.Color := Module.OddColor;
  AddressEdit.Color := Module.EvenColor;
  DeptMemo.Color := Module.OddColor;
end;

procedure TUserInfoForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

end.
