unit initiator_filter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, settings;

type
  TInitiatorFormFilter = class(TForm)
    FilterGroupBox: TGroupBox;
    FieldLabel: TLabel;
    OperationLabel: TLabel;
    ValueLabel: TLabel;
    InitiatorTitleEdit: TEdit;
    InitiatorComboBox: TComboBox;
    InitiatorValueEdit: TEdit;
    LoginTitleEdit: TEdit;
    LoginComboBox: TComboBox;
    LoginValueEdit: TEdit;
    PhoneTitleEdit: TEdit;
    PhoneComboBox: TComboBox;
    PhoneValueEdit: TEdit;
    EmailTitleEdit: TEdit;
    EmailComboBox: TComboBox;
    EmailValueEdit: TEdit;
    Edit1: TEdit;
    ResetButton: TButton;
    FilterButton: TButton;
    CancelButton: TButton;
    AddressTitleEdit: TEdit;
    AddressComboBox: TComboBox;
    AddressValueEdit: TEdit;
    DescrTitileEdit: TEdit;
    DescrComboBox: TComboBox;
    DescrValueEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FilterButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure InitiatorComboBoxExit(Sender: TObject);
    procedure LoginComboBoxExit(Sender: TObject);
    procedure EmailComboBoxExit(Sender: TObject);
    procedure PhoneComboBoxExit(Sender: TObject);
  private
     FFiltered : boolean;

     // ?????? ???????? ????????? ?? GSettings
     procedure LoadControls;

     // ?????????? ???????? ????????? ? GSettings
     procedure SaveControls;
  public

     // ?????????? ???????
     procedure Apply;

     property Filtered : boolean read FFiltered write FFiltered;
  end;

var
  InitiatorFormFilter: TInitiatorFormFilter;

implementation

uses global;

{$R *.dfm}

procedure TInitiatorFormFilter.FormCreate(Sender: TObject);
begin
 LoadControls;
end;

procedure TInitiatorFormFilter.Apply;
var strNewQuery, strOldQuery : string;
begin
   try
     strNewQuery := 'select * from personnel_view t where 1=1';
     strOldQuery :=  strNewQuery + 'order by t.worker';

     // ????????????
     if InitiatorValueEdit.Text <> '' then
     begin
        if InitiatorComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.worker ' + InitiatorComboBox.Text  + QuotedStr(InitiatorValueEdit.Text)
        else if InitiatorComboBox.Text = '????????' then
          strNewQuery := strNewQuery + ' and instr(lower(t.worker),lower(' + QuotedStr(InitiatorValueEdit.Text) + ')) <> 0';
     end;

     // ?????
     if LoginValueEdit.Text <> '' then
     begin
        if LoginComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.login ' + LoginComboBox.Text  + QuotedStr(LoginValueEdit.Text)
        else if LoginComboBox.Text = '????????' then
          strNewQuery := strNewQuery + ' and instr(lower(t.login),lower(' + QuotedStr(LoginValueEdit.Text) + ')) <> 0';
     end;


     // ?????????
     if DescrValueEdit.Text <> '' then
     begin
        if DescrComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.login ' + DescrComboBox.Text  + QuotedStr(DescrValueEdit.Text)
        else if DescrComboBox.Text = '????????' then
          strNewQuery := strNewQuery + ' and instr(lower(t.descr),lower(' + QuotedStr(DescrValueEdit.Text) + ')) <> 0';
     end;


     // ??????????? ?????
     if EmailValueEdit.Text <> '' then
     begin
        if EmailComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.email ' + EmailComboBox.Text  + QuotedStr(EmailValueEdit.Text)
        else if EmailComboBox.Text = '????????' then
          strNewQuery := strNewQuery + ' and instr(lower(t.email),lower(' + QuotedStr(EmailValueEdit.Text) + ')) <> 0';
     end;

     // ???????
     if PhoneValueEdit.Text <> '' then
     begin
        if PhoneComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.phone ' + PhoneComboBox.Text  + QuotedStr(PhoneValueEdit.Text)
        else if PhoneComboBox.Text = '????????' then
          strNewQuery := strNewQuery + ' and instr(lower(t.phone),lower(' + QuotedStr(PhoneValueEdit.Text) + ')) <> 0';
     end;

     // ?????
     if AddressValueEdit.Text <> '' then
     begin
        if AddressComboBox.Text = '=' then
          strNewQuery := strNewQuery + ' and t.address ' + AddressComboBox.Text  + QuotedStr(AddressValueEdit.Text)
        else if AddressComboBox.Text = '????????' then
          strNewQuery := strNewQuery + ' and instr(lower(t.address),lower(' + QuotedStr(AddressValueEdit.Text) + ')) <> 0';
     end;

     strNewQuery := strNewQuery +  ' order by t.worker';
     Filtered :=  strNewQuery <> strOldQuery;

     Module.InitiatorDataSet.SQL.Text := strNewQuery;
     Module.InitiatorDataSet.Filtered := false;
     Module.InitiatorDataSet.Refresh;

   finally
   end;
end;


procedure TInitiatorFormFilter.LoadControls;
begin
  InitiatorValueEdit.Text := GSettings.Initiator2;
  InitiatorComboBox.ItemIndex := GSettings.Initiator2Op;
  DescrValueEdit.Text := GSettings.Descr;
  DescrComboBox.ItemIndex := GSettings.DescrOp;
  LoginValueEdit.Text := GSettings.Login;
  LoginComboBox.ItemIndex := GSettings.LoginOp;
  EmailValueEdit.Text := GSettings.Email;
  EmailComboBox.ItemIndex := GSettings.EmailOp;
  PhoneValueEdit.Text := GSettings.Phone;
  PhoneComboBox.ItemIndex := GSettings.PhoneOp;
  AddressValueEdit.Text := GSettings.Address;
  AddressComboBox.ItemIndex := GSettings.AddressOp;
end;

procedure TInitiatorFormFilter.SaveControls;
begin
  GSettings.Initiator2 := InitiatorValueEdit.Text;
  GSettings.Initiator2Op := InitiatorComboBox.ItemIndex;
  GSettings.Descr := DescrValueEdit.Text;
  GSettings.DescrOp := DescrComboBox.ItemIndex;
  GSettings.Login := LoginValueEdit.Text;
  GSettings.LoginOp := LoginComboBox.ItemIndex;
  GSettings.Email := EmailValueEdit.Text;
  GSettings.EmailOp := EmailComboBox.ItemIndex;
  GSettings.Phone := PhoneValueEdit.Text;
  GSettings.PhoneOp := PhoneComboBox.ItemIndex;
  GSettings.Address := AddressValueEdit.Text;
  GSettings.AddressOp := AddressComboBox.ItemIndex;
end;


procedure TInitiatorFormFilter.FilterButtonClick(Sender: TObject);
begin
  Apply;
  SaveControls;
  Close;
end;

procedure TInitiatorFormFilter.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TInitiatorFormFilter.FormShow(Sender: TObject);
begin
  Module.PaintFilter (self);
end;

procedure TInitiatorFormFilter.ResetButtonClick(Sender: TObject);
begin
  Module.ResetFilter(self);
end;

procedure TInitiatorFormFilter.InitiatorComboBoxExit(Sender: TObject);
begin
  InitiatorComboBox.Repaint;
end;

procedure TInitiatorFormFilter.LoginComboBoxExit(Sender: TObject);
begin
  LoginComboBox.Repaint;
end;

procedure TInitiatorFormFilter.EmailComboBoxExit(Sender: TObject);
begin
  EmailComboBox.Repaint;
end;

procedure TInitiatorFormFilter.PhoneComboBoxExit(Sender: TObject);
begin
  PhoneComboBox.Repaint;
end;

end.
