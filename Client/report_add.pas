unit report_add;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TReportAddForm = class(TForm)
    CloseButton: TButton;
    OkButton: TButton;
    TitleEdit: TEdit;
    TitleCaption: TLabel;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
  private
    FReportName : String;
    FTitle : String;
  public
    property Title : String read FTitle write FTitle;
    property ReportName : String read FReportName write FReportName;
  end;

var
  ReportAddForm: TReportAddForm;

implementation

uses global;

{$R *.dfm}

procedure TReportAddForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TReportAddForm.FormShow(Sender: TObject);
begin
  TitleEdit.Color := Module.EvenColor;
  ReportName := '';
end;

procedure TReportAddForm.OkButtonClick(Sender: TObject);
begin
  ReportName := TitleEdit.Text;
  Close;
end;

end.
